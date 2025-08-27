function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

function getFlipValues(note) -- Fuck
    local isPlayer = note > 3
    local modNote = note % 4
    local target = 0

    if modNote == 0 then
        target = 3
    end
    if modNote == 1 then
        target = 2
    end
    if modNote == 2 then
        target = 1
    end
    if modNote == 3 then
        target = 0
    end

    if isPlayer then target = target + 4 end
    return defaultStrumValues[target + 1]
end

function swap360(enabled)
    forAllStrums(function(note)

        for _, noteData in ipairs(getNoteArray()) do
            setPropertyFromGroup('notes', noteData.index, 'copyX', false)
        end

        local from = getFlipValues(note)
        local to = defaultStrumValues[note + 1]

        setPropertyFromGroup('strumLineNotes', note, 'x', from.x)
        setPropertyFromGroup('strumLineNotes', note, 'y', from.y)
        setPropertyFromGroup('strumLineNotes', note, 'angle', 180)
    
        noteTweenQuad('noteQuad360'..note, note, {
            ["fromX"] = from.x,
            ["fromY"] = from.y,
            ["controlX"] = (from.x + to.x) / 2,
            ["controlY"] = from.y + 130 * (note % 2 == 0 and -1 or 1),
            ["toX"] = to.x,
            ["toY"] = to.y
        }, {["duration"] = 0.25, ["ease"] = "smoothStepInOut"})
    
        noteTweenAngle('noteAngle360'..note, note, 0, {["duration"] = 0.25, ["ease"] = "smoothStepInOut"})
    end)
end