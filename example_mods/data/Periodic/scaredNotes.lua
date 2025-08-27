local lastMS = 0
local doShit = false

function forAllStrums(func)
    for i=0,7 do
        func(i)
    end
end

function onUpdate(elapsed)
    if not doShit then return end

    if getPropertyFromClass('flixel.FlxG', 'game.ticks') > lastMS then
        lastMS = getPropertyFromClass('flixel.FlxG', 'game.ticks') + 15
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'skew.x', math.sin(math.random(-1000, 1000)) * 5)
            setPropertyFromGroup('strumLineNotes', note, 'skew.y', math.cos(math.random(-1000, 1000)) * 5)
        end)
    end
end

function scaredNotes(val)
    doShit = val
    if doShit then doShit = not disableModcharts end

    if not doShit then
        forAllStrums(function(note)
            noteTween('resetSkew'..note, note, {['skew.x'] = 0, ['skew.y'] = 0}, {["duration"] = 1.3, ["ease"] = "quadOut"})
        end)
    end
end