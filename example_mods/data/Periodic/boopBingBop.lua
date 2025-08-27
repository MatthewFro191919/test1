local NOTE_WIDTH = 160 * 0.7

local doIt = false

local function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

local function anchored(note)
    return note % 4 - 1.5
end

local function split(note)
    return note % 4 < 2 and -1 or 1
end

local function alternate(note)
    return note % 2 * 2 - 1
end

local function theBees(note, what)
    noteTweenY("boopMove"..note, note, defaultStrumValues[note + 1].y + what * 20, {duration = stepsToSeconds(2), ease = "sineIn"})
end

local thingTable = {
    [0] = function()
        forAllStrums(function(note)
            cancelTween("boopAngle"..note)
            setPropertyFromGroup('strumLineNotes', note, 'angle', 0)

            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + (note % 2 == 0 and 28 or 0))
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1.2)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.6)

            noteTween("boopMove"..note, note, {
                x = defaultStrumValues[note + 1].x + anchored(note) * -25,
                y = defaultStrumValues[note + 1].y,
                ["multScale.x"] = 1,
                ["multScale.y"] = 1
            }, {duration = stepsToSeconds(1.75), ease = "cubeIn"})
        end)
    end,

    [2] = function()
        forAllStrums(function(note)
            noteTween("boopMove"..note, note, {
                x = defaultStrumValues[note + 1].x + split(note) * 30,
                angle = 45
            }, {duration = stepsToSeconds(0.5), ease = "quartOut"})

            noteTween("boopMoveB"..note, note, {
                x = defaultStrumValues[note + 1].x,
                angle = 0
            }, {duration = stepsToSeconds(1.25), ease = "quartIn", chainParent = "boopMove"..note})
        end)
    end,

    [4] = function()
        forAllStrums(function(note)
            cancelTween("boopMoveB"..note)

            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + anchored(note) * NOTE_WIDTH * -0.4)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y - 20)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.7)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.7)

            noteTween("boopMove"..note, note, {
                x = defaultStrumValues[note + 1].x,
                y = defaultStrumValues[note + 1].y,
                ["multScale.x"] = 1,
                ["multScale.y"] = 1
            }, {duration = stepsToSeconds(2), ease = "quartIn"})
        end)
    end,

    [6] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + anchored(note) * NOTE_WIDTH * -0.3)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1.2)

            local values = {}

            if note % 4 == 0 then
                values = {
                    x = defaultStrumValues[note + 1].x - NOTE_WIDTH * 0.5,
                    y = defaultStrumValues[note + 1].y + NOTE_WIDTH * 0.25,
                    ["multScale.x"] = 0.5,
                    ["multScale.y"] = 1.5
                }
            else
                values = {
                    x = defaultStrumValues[note + 1].x,
                    ["multScale.x"] = 1
                }
            end

            noteTween("boopMove"..note, note, values, {duration = stepsToSeconds(2), ease = "quartIn"})
        end)
    end,

    [8] = function()
        forAllStrums(function(note)
            if note % 4 == 0 then
                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    y = defaultStrumValues[note + 1].y,
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "quartOut"})
            end

            noteTween("boopAngle"..note, note, {
                angle = 360 * 3
            }, {duration = stepsToSeconds(24)})
        end)
    end,

    [10] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 1 or wat == 2 then
                local yAdd = (wat == 1 and 25 or -25)
                setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + yAdd)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 2)

                noteTween("boopMove"..note, note, {
                    y = defaultStrumValues[note + 1].y,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [12] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 2 then
                noteTweenX("boopMove"..note, note, defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.75, {duration = stepsToSeconds(2), ease = "cubeIn"})
            elseif wat == 3 then
                setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x - NOTE_WIDTH * 0.5)
                setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y - NOTE_WIDTH * 0.25)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 2)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1.5)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    y = defaultStrumValues[note + 1].y,
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [14] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + 20)
                theBees(note, -1)
            elseif wat == 1 then
                setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.2)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 2.5)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 2.5)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            elseif wat == 2 then
                noteTweenX("boopMoveX"..note, note, defaultStrumValues[note + 1].x - NOTE_WIDTH * 0.25, {duration = stepsToSeconds(8), ease = "quadInOut"})
            end
        end)
    end,

    [16] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, 1)
            elseif wat == 2 then
                setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y - NOTE_WIDTH * 0.5)
                noteTweenY("boopMoveY"..note, note, defaultStrumValues[note + 1].y, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [18] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, -1)
            elseif wat == 3 then
                setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x - NOTE_WIDTH * 1.5)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 3)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "quadOut"})
            end
        end)
    end,

    [20] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, 1)
            elseif wat == 1 then
                setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.25)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1.5)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [22] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, -1)
            elseif wat == 1 then
                setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.25)
                setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y - NOTE_WIDTH * 0.35)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.5)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.5)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    y = defaultStrumValues[note + 1].y,
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "quartIn"})
            elseif wat == 2 then
                noteTweenX("boopMove"..note, note, defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.75, {duration = stepsToSeconds(2), ease = "backIn"})
            end
        end)
    end,

    [24] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, 1)
            elseif wat == 2 or wat == 3 then
                if wat == 3 then
                    setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + NOTE_WIDTH * 0.25)
                end
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.5)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 2)

                noteTween("boopMove"..note, note, {
                    x = defaultStrumValues[note + 1].x,
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [26] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, -1)
            elseif wat == 1 then
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 3)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.4)
                noteTween("boopMove"..note, note, {
                    ["multScale.x"] = 0.75,
                    ["multScale.y"] = 1.5
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [28] = function()
        forAllStrums(function(note)
            local wat = note % 4
            if wat == 0 then
                theBees(note, 0)
            elseif wat == 1 then
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 2)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.5)
                noteTween("boopMove"..note, note, {
                    ["multScale.x"] = 1,
                    ["multScale.y"] = 1
                }, {duration = stepsToSeconds(2), ease = "cubeOut"})
            end
        end)
    end,

    [30] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + split(note) * NOTE_WIDTH * 0.5)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + alternate(note) * NOTE_WIDTH * 0.4 + anchored(note) * 8)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.5)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.5)
            noteTween("boopMove"..note, note, {
                x = defaultStrumValues[note + 1].x,
                y = defaultStrumValues[note + 1].y,
                ["multScale.x"] = 1,
                ["multScale.y"] = 1
            }, {duration = stepsToSeconds(2), ease = "cubeOut"})
        end)
    end
}

function boopBingBop(enable)
    doIt = enable

    if enable then
        --it doesn't do it sometimes
        thingTable[0]()
    else
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y)
            setPropertyFromGroup('strumLineNotes', note, 'angle', defaultStrumValues[note + 1].angle)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1)
            
            cancelTween("boopMove"..note)
            cancelTween("boopAngle"..note)
        end)
    end
end

function onStepHit()
	local id = curStep % 32
    if doIt and thingTable[id] then 
        thingTable[id]()
    end
end