local modes = require("modes")
local settings = require("settings")
local downloads = require("downloads")
local webview = require("webview")

---set download dir, and stop prompt for download
downloads.default_dir = os.getenv("HOME") .. "/dl"
downloads.add_signal("download-location", function (uri, file)
    luakit.spawn(string.format("notify-send 'Luakit' 'file downloaded to ~/dl/'"))
    if not file or file == "" then
        file = (string.match(uri, "/([^/]+)$")
            or string.match(uri, "^%w+://(.+)")
            or string.gsub(uri, "/", "_")
            or "untitled")
    end
    return downloads.default_dir .. "/" .. file
end)

---set how to handle various schemes (from luakit FAQ)
webview.add_signal("init", function (view)
    view:add_signal("navigation-request", function (v, uri)
---open magnet links with transadd
        if string.match(string.lower(uri), "^magnet:")  then
            luakit.spawn(string.format("%s %q", "transadd", uri))
            return false 
        end
        --- Check URI and open program here
    end)
end)


---set home page
settings.window.home_page = os.getenv("HOME") .. "/.config/startpage/index.html"


---open webpage in mpv with: ; + shift + m
local video_cmd_fmt = "mpv '%s' --loop"
modes.add_binds("ex-follow", {
  { "m", "Hint all links and open the video behind that link externally with MPV.",
      function (w)
          w:set_mode("follow", {
              prompt = "open with MPV", selector = "uri", evaluator = "uri",
              func = function (uri)
                  assert(type(uri) == "string")
                  luakit.spawn(string.format(video_cmd_fmt, uri))
                  w:notify("Launched MPV")
              end
          })
      end },
  { "M", "Open the video on the current page externally with MPV.",
      function (w)
        local uri = string.gsub(w.view.uri or "", " ", "%%20")
        luakit.spawn(string.format(video_cmd_fmt, uri))
        w:notify("Launched MPV")
      end },
})
