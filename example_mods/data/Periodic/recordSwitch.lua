local runStepChart = {}

function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

function recordSwitchSection()
    if disableModcharts then return end
    local modStep = curStep % 2 == 0
    if modStep then
        noteTweenX('recordNoteSwap1', 1, defaultStrumValues[2 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
        noteTweenX('recordNoteSwap2', 2, defaultStrumValues[1 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})

        noteTweenX('recordNoteSwap5', 5, defaultStrumValues[6 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
        noteTweenX('recordNoteSwap6', 6, defaultStrumValues[5 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
    else
        noteTweenX('recordNoteSwap1', 1, defaultStrumValues[1 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
        noteTweenX('recordNoteSwap2', 2, defaultStrumValues[2 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})

        noteTweenX('recordNoteSwap5', 5, defaultStrumValues[5 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
        noteTweenX('recordNoteSwap6', 6, defaultStrumValues[6 + 1].x, {["duration"] = stepsToSeconds(0.95), ["ease"] = "cubeOut"})
    end
end

local stepChart = {
    [48] = recordSwitchSection,
    [49] = recordSwitchSection,
    [50] = recordSwitchSection,
    [51] = recordSwitchSection,
    [52] = function() 
        forAllStrums(function(note) 
            if note % 4 == 1 or note % 4 == 2 then
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1.15 / .321)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1.15)
                noteTween('noteRecordScale'..note, note, {
                        ['multScale.x'] = 1, 
                        ['multScale.y'] = 1, 
                    }, {["duration"] = stepsToSeconds(2), ["ease"] = "quartOut"}
                )
            end
        end)
    end,

    [54] = recordSwitchSection,
    [55] = recordSwitchSection,
    [56] = recordSwitchSection,
    [57] = recordSwitchSection,
    [58] = function() 
        forAllStrums(function(note) 
            if note % 4 == 1 or note % 4 == 2 then
                setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1.2 / .321)
                setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1.2 / .321)
                noteTween('noteRecordScale'..note, note, {
                        ['multScale.x'] = 1, 
                        ['multScale.y'] = 1, 
                    }, {["duration"] = stepsToSeconds(1.3), ["ease"] = "quartOut"}
                )
            end
        end)
    end
}

function onCreate()
    for step in pairs(stepChart) do
        runStepChart[step] = false
    end
end


function recordSwitch(curDecStep)
    for step in pairs(stepChart) do
        if step <= curDecStep and runStepChart[step] == false then
            runStepChart[step] = true
            stepChart[step]()
        end
    end
end