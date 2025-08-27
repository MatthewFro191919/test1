local runStepChart = {}
local stepChartPassthrough = {}

function removePassthroughItem(item)
    for i in pairs(stepChartPassthrough) do
        if stepChartPassthrough[i] == item then
            table.remove(stepChartPassthrough, i)
        end
    end
end

local beatHitFunc
local updateFunc

local stepChart = {
    [252] = function()
        beatHitFunc = nil
        callOnLuas('swagShitShader', {true}) 
    end,

    [507] = function()
        beatHitFunc = nil
        callOnLuas('swagShitShader', {false}) 
    end,

    [763] = function()
        beatHitFunc = nil
        callOnLuas('swagShitShader', {true}) 
    end,

    [1019] = function()
        beatHitFunc = nil
        callOnLuas('swagShitShader', {false}) 
    end
}

function onCreate()
    math.randomseed(-1333)
    for step in pairs(stepChart) do
        runStepChart[step] = false
    end
end

function onSongStart()
    if stepChart[0] then stepChart[0]() end
end

function onUpdate(elapsed)
    for step in pairs(stepChart) do
        if step <= curDecStep and runStepChart[step] == false then
            runStepChart[step] = true
            stepChart[step]()
        end
    end

    for _, passthroughFunc in pairs(stepChartPassthrough) do 
        callOnLuas(passthroughFunc, {curDecStep})
    end

    if updateFunc then updateFunc(elapsed) end
end