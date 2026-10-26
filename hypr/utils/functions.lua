-- dwindle moves the shared split line right/down on keyboard resize, no matter
-- which side the active window is on. Flip the sign for windows on the
-- right/bottom half so "increase" always grows the active window.
local function dwindle_direction(win)
    local mon = win.monitor
    if win.floating or not mon then
        return 1, 1
    end

    -- mon.width/height are physical pixels; window coords are logical
    local r = mon.reserved or { top = 0, right = 0, bottom = 0, left = 0 }
    local area_x = mon.x + r.left
    local area_y = mon.y + r.top
    local area_w = mon.width / mon.scale - r.left - r.right
    local area_h = mon.height / mon.scale - r.top - r.bottom

    local center_x = win.at.x + win.size.x / 2
    local center_y = win.at.y + win.size.y / 2

    local sx = center_x > area_x + area_w / 2 and -1 or 1
    local sy = center_y > area_y + area_h / 2 and -1 or 1
    return sx, sy
end

-- x, y: percent of the active window's current size
local function resize_active_window(x, y)
    return function()
        local win = hl.get_active_window()
        if win and win.size then
            local sx, sy = dwindle_direction(win)
            local w = win.size.x * (x / 100) * sx
            local h = win.size.y * (y / 100) * sy

            hl.dispatch(hl.dsp.window.resize({ x = w, y = h, relative = true }))
        else
            hl.dispatch(hl.dsp.no_op())
        end
    end
end

return {
  resize_active_window = resize_active_window,
}
