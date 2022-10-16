#![allow(dead_code)]

extern crate neovim_lib;
extern crate ffmpeg_next;

use neovim_lib::{Neovim, NeovimApi, Session};
use ffmpeg_next::{
    media::Type,
    format::{input, Pixel},
    software::scaling::{context::Context, flag::Flags},
    util::frame::video::Video,
};
use std::{
    fs,
    io::prelude::*,
    rc::Rc,
    cell::RefCell,
};

struct Player {
    frames: Vec<Rc<RefCell<Video>>>,
}

impl Player {
    fn new() -> Player {
        Player {
            frames: vec![],
        }
    }

    fn save_file(frame: &Video, index: usize) -> std::result::Result<(), std::io::Error> {
        let mut file = fs::File::create(format!("./myplugins/badapple/frames/frame{}.ppm", index))?;
        file.write_all(format!("P6\n{} {}\n255\n", frame.width(), frame.height()).as_bytes())?;
        file.write_all(frame.data(0))?;
        Ok(())
    }

    fn load_video(&mut self) -> Result<(), ffmpeg_next::Error> {
        self.frames = Vec::new();
        fs::create_dir("./myplugins/badapple/frames").unwrap();

        if let Ok(mut ictx) = input(&String::from("./bad_apple.mp4")) {
            let input = ictx
                .streams()
                .best(Type::Video)
                .ok_or(ffmpeg_next::Error::StreamNotFound)?;
            let video_stream_index = input.index();

            let context_decoder = ffmpeg_next::codec::context::Context::from_parameters(input.parameters())?;
            let mut decoder = context_decoder.decoder().video()?;

            let mut scaler = Context::get(
                decoder.format(),
                decoder.width(),
                decoder.height(),
                Pixel::RGB24,
                decoder.width(),
                decoder.height(),
                Flags::BILINEAR,
            )?;

            let mut ascii_frames: Vec<Rc<RefCell<Video>>> = vec![];

            let mut frame_index = 0;
            let mut receive_and_process_decoded_frames =
                |decoder: &mut ffmpeg_next::decoder::Video| -> Result<(), ffmpeg_next::Error> {
                    let mut decoded = Video::empty();
                    while decoder.receive_frame(&mut decoded).is_ok() {
                        let mut rgb_frame = Video::empty();
                        scaler.run(&decoded, &mut rgb_frame)?;
                        Player::save_file(&rgb_frame, frame_index).unwrap();
                        ascii_frames.push(Rc::new(RefCell::new(rgb_frame)));
                        frame_index += 1;
                    }
                    Ok(())
                };

            for (stream, packet) in ictx.packets() {
                if stream.index() == video_stream_index {
                    decoder.send_packet(&packet)?;
                    receive_and_process_decoded_frames(&mut decoder)?;
                }
            }
            decoder.send_eof()?;
            receive_and_process_decoded_frames(&mut decoder)?;

            self.frames = std::mem::take(&mut ascii_frames);
        }

        Ok(())
    }
}

struct EventHandler {
    neovim: Neovim,
    player: Player,
}

impl EventHandler {
    fn new() -> EventHandler {
        let session = Session::new_parent().unwrap();
        let neovim = Neovim::new(session);
        let player = Player::new();

        EventHandler { player, neovim }
    }

    fn recv(&mut self) {
        let receiver = self.neovim.session.start_event_loop_channel();

        for (_event, _values) in receiver {
            self.neovim
                .command(&format!("echo \"Hello, World!\""))
                .unwrap();
            self.player.load_video().unwrap();
            // thread::sleep(Duration::from_secs(1));
            // self.neovim
            //     .command(&format!("echo \"More lines baby\""))
            //     .unwrap();
        }
    }
}

fn main() {
    let mut event_handler = EventHandler::new();
    event_handler.recv();
}
