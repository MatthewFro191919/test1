local runStepChart = {}

function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

local stepChart = {
    [60] = function() 
        forAllStrums(function(note)
            local modNote = note % 4

            local x = 0
            local toX = 0
            local y = 0
            local toY = 0
            local angle = 0
            local toAngle = 0

            local time = stepsToSeconds(3)

            cancelTween('recordNoteSwap'..note)
            cancelTween('noteRecordScale'..note)
            cancelTween('beatNoteTweenX'..note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1.3 / .321)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1.3 / .321)

            if modNote == 0 then
                x = 327.25
                y = 176.95
                angle = -17

                toX = -122.15
                toY = 3.6
                toAngle = 50
            end

            if modNote == 1 then
                x = 168.95
                y = -178.55
                angle = 17

                toX = 21.5
                toY = 151.55
                toAngle = 30
            end

            if modNote == 2 then
                x = -125.35
                y = 243.5
                angle = -25

                toX = 83.2
                toY = -48.45
                toAngle = 35

                time = stepsToSeconds(3.3)
            end

            if modNote == 3 then
                x = -448.2
                y = -93.65
                angle = -17

                toX = 111.6
                toY = -24.3
                toAngle = 45
            end

            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + x)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + y)
            setPropertyFromGroup('strumLineNotes', note, 'angle', 360 + angle)
            noteTweenX('noteYellX'..note, note, (defaultStrumValues[note + 1].x + x) + toX, {["duration"] = time, ["ease"] = "smootherStepIn"})
            noteTweenY('noteYellY'..note, note, (defaultStrumValues[note + 1].y + y) + toY, {["duration"] = time, ["ease"] = "smootherStepIn"})
            noteTweenAngle('noteSpin'..note, note, toAngle, {["duration"] = time, ["ease"] = "quadOut"})
            noteTween('noteScale'..note, note, {['multScale.x'] = 1, ['multScale.y'] = 1}, {["duration"] = time, ["ease"] = "quadOut"})
        end)
    end,

    [63.05] = function()
        forAllStrums(function(note)
            local modNote = note % 4
            if modNote ~= 2 then
                local x = 0
                local y = 0
                local angle = 0
                local ease = 'smootherStepInOut'

                local time = stepsToSeconds(1.7)

                cancelTween('noteYellX'..note)
                cancelTween('noteYellY'..note)
                cancelTween('noteSpin'..note)

                if modNote == 0 or modNote == 1 then
                    x = defaultStrumValues[note + 1].x
                    y = defaultStrumValues[note + 1].y
                    angle = defaultStrumValues[note + 1].angle
                end

                if modNote == 3 then
                    x = defaultStrumValues[note + 1].x + 253.1
                    y = defaultStrumValues[note + 1].y + -0.95
                    angle = -5
                    ease = "smootherStepIn"
                    time = stepsToSeconds(0.85)
                end

                noteTweenX('noteYellX'..note, note, x, {["duration"] = time, ["ease"] = "smootherStepInOut"})
                noteTweenY('noteYellY'..note, note, y, {["duration"] = time, ["ease"] = "smootherStepInOut"})
                noteTweenAngle('noteSpin'..note, note, angle, {["duration"] = time, ["ease"] = "quadOut"})
            end
        end)
    end,

    [63.25] = function()
        for _,note in pairs({3, 7}) do
            local modNote = note % 4
            local x = 0
            local y = 0
            local angle = 0

            local time = stepsToSeconds(1.6)

            cancelTween('noteYellX'..note)
            cancelTween('noteYellY'..note)
            cancelTween('noteSpin'..note)

            x = defaultStrumValues[note + 1].x
            y = defaultStrumValues[note + 1].y
            angle = defaultStrumValues[note + 1].angle

            noteTweenX('noteYellX'..note, note, x, {["duration"] = time, ["ease"] = "smootherStepInOut"})
            noteTweenY('noteYellY'..note, note, y, {["duration"] = time, ["ease"] = "smootherStepInOut"})
            noteTweenAngle('noteSpin'..note, note, angle, {["duration"] = time, ["ease"] = "quadOut"})
        end
    end,

    [63.85] = function()
        for _,note in pairs({2, 6}) do
            local modNote = note % 4
            local x = 0
            local y = 0
            local angle = 0

            local time = stepsToSeconds(0.85)

            cancelTween('noteYellX'..note)
            cancelTween('noteYellY'..note)
            cancelTween('noteSpin'..note)

            x = defaultStrumValues[note + 1].x
            y = defaultStrumValues[note + 1].y
            angle = defaultStrumValues[note + 1].angle

            noteTweenX('noteYellX'..note, note, x, {["duration"] = time, ["ease"] = "smootherStepOut"})
            noteTweenY('noteYellY'..note, note, y, {["duration"] = time, ["ease"] = "smootherStepOut"})
            noteTweenAngle('noteSpin'..note, note, angle, {["duration"] = time, ["ease"] = "quadOut"})
        end
    end
}

function onCreate()
    for step in pairs(stepChart) do
        runStepChart[step] = false
    end
end

function screamAnim(curDecStep)
    for step in pairs(stepChart) do
        if step <= curDecStep and runStepChart[step] == false then
            runStepChart[step] = true
            stepChart[step]()
        end
    end
end