local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
	print "Could not load dashboard plugin..."
	return
end

dashboard.setup({

})
