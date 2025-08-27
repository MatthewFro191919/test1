local doShit = false

function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

function floatySection(val)
    doShit = val
    print(doShit)

    if val == false then
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y)
        end)
    end 
end

local noteBump = {
    [0] = {
        ["x"] = -13.8,
        ["y"] = 0
    },
    [1] = {
        ["x"] = -6.2,
        ["y"] = -10
    },
    [2] = {
        ["x"] = 6.25,
        ["y"] = 11.25
    },
    [3] = {
        ["x"] = 10.05,
        ["y"] = -8.75
    }
}

function onBeatHit()
    if not doShit then return end

    forAllStrums(function(note)
        local modNote = note % 3
        setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + noteBump[modNote].x)
        setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + noteBump[modNote].y + (math.sin((elapsedTime * math.pi) + note) * 10))
    end)
end

function onUpdate()
    if not doShit then return end

    forAllStrums(function(note)
        setPropertyFromGroup('strumLineNotes', note, 'x', fpsLerp(getPropertyFromGroup('strumLineNotes', note, 'x'), defaultStrumValues[note + 1].x, 0.1))
        setPropertyFromGroup('strumLineNotes', note, 'y', fpsLerp(getPropertyFromGroup('strumLineNotes', note, 'y'), defaultStrumValues[note + 1].y + (math.sin((elapsedTime * math.pi) + note) * 10), 0.1))
    end)
end