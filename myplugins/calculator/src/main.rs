extern crate neovim_lib;

use neovim_lib::{Neovim, NeovimApi, Session};

struct Calculator;

impl Calculator {
    fn new() -> Calculator {
        Calculator {}
    }

    // Add a vector of numbers.
    fn add(&self, nums: Vec<i64>) -> i64 {
        nums.iter().sum::<i64>()
    }

    // Multiply two numbers
    fn multiply(&self, p: i64, q: i64) -> i64 {
        p * q
    }
}

enum Message {
    Add,
    Multiply,
    Unknown(String),
}

impl From<String> for Message {
    fn from(event: String) -> Message {
        match &event[..] {
            "add" => Message::Add,
            "multiply" => Message::Multiply,
            _ => Message::Unknown(String::from(event)),
        }
    }
}

struct EventHandler {
    neovim: Neovim,
    calculator: Calculator,
}

impl EventHandler {
    fn new() -> EventHandler {
        let session = Session::new_parent().unwrap();
        let neovim = Neovim::new(session);
        let calculator = Calculator::new();

        EventHandler { neovim, calculator }
    }

    fn recv(&mut self) {
        let receiver = self.neovim.session.start_event_loop_channel();

        for (event, values) in receiver {
            match Message::from(event) {

                Message::Add => {
                    let nums = values
                        .iter()
                        .map(|v| v.as_i64().unwrap())
                        .collect::<Vec<i64>>();

                    let res = self.calculator.add(nums);

                    self.neovim
                        .command(&format!("echo \"sum result: {res}\""))
                        .unwrap();
                },

                Message::Multiply => {
                    let mut nums = values.iter();
                    let p = nums.next().unwrap().as_i64().unwrap();
                    let q = nums.next().unwrap().as_i64().unwrap();

                    let res = self.calculator.multiply(p, q);

                    self.neovim
                        .command(&format!("echo \"sum result: {res}\""))
                        .unwrap();
                },

                Message::Unknown(s) => {
                    self.neovim
                        .command(&format!("echo \"Command '{s}' not found...\""))
                        .unwrap();
                },
            }
        }
    }
}

fn main() {
    let mut event_handler = EventHandler::new();
    event_handler.recv();
}
