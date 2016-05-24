--[[
Precious was originally written by Robin Hahling
(Cloned from git://rolinh.ch/precious.git)
See LICENSE
--]]
-- needed in order to get the number of CPU cores
require("precious.utils")

-- Create a CPU widget
jiffies = {}
function activecpu(nbcores)
    local res, str

    for line in io.lines("/proc/stat") do
        local cpu,newjiffies = string.match(line, "(cpu)\ +(%d+)")
        if cpu and newjiffies then
            if not jiffies[cpu] then
                jiffies[cpu] = newjiffies
            end
            -- The string.format prevents your task list from jumping around
            -- When CPU usage goes above/below 10%
            str = string.format("%02d", (newjiffies-jiffies[cpu])/nbcores)
            if str < "31" then
                str = '<span color="green">' .. str .. '</span>'
            elseif str < "51" then
                str = '<span color="yellow">' .. str .. '</span>'
            elseif str < "70" then
                str = '<span color="orange">' .. str .. '</span>'
            else
                str = '<span color="red">' .. str .. '</span>'
            end

            res = '| CPU: ' .. str .. '% '
            jiffies[cpu] = newjiffies
        end
    end
    return res
end

cpuinfo = wibox.widget.textbox()

-- register the hook to update the display
cpuinfo_timer = timer({timeout = 1})
cpuinfo_timer:connect_signal("timeout", function() cpuinfo:set_markup(activecpu(getnbcore())) end)
cpuinfo_timer:start()

local temperatureFile = "/sys/bus/acpi/devices/LNXTHERM\:00/thermal_zone/temp"

-- Create CPU Temp Widget
function activecputemp()
    local temp, f

    f = io.input(temperatureFile)
    temp = io.read("*number")/1000
    f:close()

    if temp < 46 then
        temp = '<span color="turquoise">' .. temp .. '</span>'
    elseif	temp < 61 then
        temp = '<span color="yellow">' .. temp .. '</span>'
    elseif  temp < 76 then
        temp = '<span color="orange">' .. temp .. '</span>'
    else
        temp = '<span color="red">' .. temp .. '</span>'
    end
    return temp
end

cputemp = wibox.widget.textbox()

-- Assign a hook to update temperature
local f = io.open(temperatureFile)
if f then
    f:close()
    cputemp_timer = timer({timeout = 1})
    cputemp_timer:connect_signal("timeout", function() cputemp:set_markup("@ " .. activecputemp() .. "°C | RAM: ") end)
    cputemp_timer:start()
end
