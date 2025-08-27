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

local function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

local function anchored(note)
    return note % 4 - 1.5
end

local function alternate(note)
    return note % 2 * 2 - 1
end

local function recordSwitchSection()
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

local function introThing(curBeat)
    forAllStrums(function(note)
        local modNote = note % 4
        local flip = curBeat % 2 == 0

        local x = 0
        local y = 0

        if modNote == 0 then
            x = (flip and -16.25 or 5)
        end

        if modNote == 1 then
            x = (flip and -12.5 or 10)
            y = (flip and 13.75 or -7.5)
        end

        if modNote == 2 then
            x = (flip and -6.25 or 15)
            y = (flip and -13.75 or 6.25)
        end
        
        if modNote == 3 then
            x = (flip and -2.5 or 18.75)
        end

        setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + x)
        noteTweenX('beatNoteTweenX'..note, note, defaultStrumValues[note + 1].x, {["duration"] = stepsToSeconds(4), ["ease"] = "cubeOut"})

        setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + y)
        noteTweenY('beatNoteTweenY'..note, note, defaultStrumValues[note + 1].y, {["duration"] = stepsToSeconds(4), ["ease"] = "cubeOut"})
    end)
end

local smallStep = 0

local function getSmaller(curBeat)
    forAllStrums(function(note)
        local scaleFactor = (1 - smallStep * 0.15)
        noteTween("skewy"..note, note, {
            x = defaultStrumValues[note + 1].x - anchored(note) * 20 * smallStep,
            ["multScale.x"] = scaleFactor,
            ["multScale.y"] = scaleFactor,
            ["skew.x"] = 15 * (smallStep % 2 == 0 and -1 or 1),
            speedMult = scaleFactor
        }, {duration = stepsToSeconds(4), ease = "quartOut"})
    end)

    smallStep = smallStep + 1
end

local stepChart = {
    [0] = function()
        beatHitFunc = introThing
    end,

    [47] = function()
        beatHitFunc = function(curBeat)
            forAllStrums(function(note)
                local modNote = note % 4
                if modNote ~= 1 or modNote ~= 2 then
                    local flip = curBeat % 2 == 0

                    local x = 0
                    local y = 0

                    if modNote == 0 then
                        x = (flip and -16.25 or 5)
                    end
                    
                    if modNote == 3 then
                        x = (flip and -2.5 or 18.75)
                    end

                    setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + x)
                    noteTweenX('beatNoteTweenX'..note, note, defaultStrumValues[note + 1].x, {["duration"] = stepsToSeconds(4), ["ease"] = "cubeOut"})

                    setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + y)
                    noteTweenY('beatNoteTweenY'..note, note, defaultStrumValues[note + 1].y, {["duration"] = stepsToSeconds(4), ["ease"] = "cubeOut"})
                end
            end)
        end
    end,

    [48] = function()
        table.insert(stepChartPassthrough, 'recordSwitch')
    end,
    [52] = function()
        beatHitFunc = nil
    end,

    [60] = function()
        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.035) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.025)
            end
        end

        removePassthroughItem('recordSwitch')
        table.insert(stepChartPassthrough, 'screamAnim')
    end,

    [63] = function() callOnLuas('scaredNotes', {true}) end,
    [64.8] = function() 
        removePassthroughItem('screamAnim')

        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x)
            setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y)
            setPropertyFromGroup('strumLineNotes', note, 'angle', defaultStrumValues[note + 1].angle)
        end)
    end,

    [94] = function() callOnLuas('swap360') end,
    [158] = function() callOnLuas('swap360') end,

    [185] = function()
        callOnLuas('scaredNotes', {false})
        callOnLuas('glitchDrum', {0}) 
    end,
    [186] = function() callOnLuas('glitchDrum', {1}) end,
    [187] = function() callOnLuas('glitchDrum', {2}) end,
    [188] = function() 
        callOnLuas('glitchDrum', {3}) 

        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'angle', 360)


            local modNote = note % 3
            local noteBump = { -- fuck it im lazy
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
            noteTween('noteReturnFloat'..note, note, {
                ['x'] = defaultStrumValues[note + 1].x + noteBump[modNote].x,
                ['y'] = defaultStrumValues[note + 1].y + noteBump[modNote].y,
                ['multScale.x'] = .45 / .321,
                ['multScale.y'] = .45 / .321,
                ['angle'] = 0
            }, {['duration'] = stepsToSeconds(4), ['ease'] = 'quintIn'})
            
            callOnLuas('floatySection', {true})
        end)
    end,

    [192] = function()
        beatHitFunc = nil
    end,

    [248] = function()
        callOnLuas('floatySection', {false})

        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1)
        end)
    end,
    [249] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.45 / .321)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.45 / .321)
        end)
    end,
    [250] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1)
        end)
    end,
    [250.5] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 0.45 / .321)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 0.45 / .321)
        end)
    end,
    [251] = function()
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.x', 1)
            setPropertyFromGroup('strumLineNotes', note, 'multScale.y', 1)
        end)
    end,

    [252] = function()
        --callOnLuas('spinNotes3D', {true})
    end,

    [256] = function()
        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.035) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.025)
            end
        end
    end,

    [320] = function()
        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.025) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.015)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.015)
            end
        end
    end,
    [352] = function()
        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.035) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.025)
            end
        end
    end,

    [376] = function()
        --callOnLuas('spinNotes3D', {false})

        forAllStrums(function(note)
            noteTween('boopMove'..note, note, {
                ['x'] = defaultStrumValues[note + 1].x + alternate(note) * 25,
                ['y'] = defaultStrumValues[note + 1].y - 40
            }, {['duration'] = stepsToSeconds(6), ['ease'] = 'cubeOut'})
        end)
    end,

    [382] = function()
        forAllStrums(function(note)
            noteTween('boopMove'..note, note, {
                ['x'] = defaultStrumValues[note + 1].x,
                ['y'] = defaultStrumValues[note + 1].y,
                ["multScale.x"] = 0.5,
                ["multScale.y"] = 1.5
            }, {['duration'] = stepsToSeconds(2), ['ease'] = 'cubeIn'})
        end)
    end,
    
    [384] = function() 
        callOnLuas('boopBingBop', {true})

        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.015) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.005)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.005)
            end
        end
    end,

    [640] = function()
        callOnLuas('boopBingBop', {false})
        beatHitFunc = introThing
    end,

    [696] = function() 
        callOnLuas('floatySection', {true})
        beatHitFunc = nil
    end,

    [832] = function() 
        -- doTweenZoom('camGameZoomTwn', 'camGame', 1.1,  {["duration"] = stepsToSeconds(48)}) 
    
        forAllStrums(function(note)
            local scaleFactor = (1 - anchored(note) * 0.1)
            noteTween("skewy"..note, note, {
                ["multScale.x"] = scaleFactor,
                ["multScale.y"] = scaleFactor,
                ["skew.x"] = 10,
                ["skew.y"] = 10,
                speedMult = scaleFactor
            }, {duration = stepsToSeconds(8), ease = "cubeOut"})
        end)
    end,

    [848] = function()
        forAllStrums(function(note)
            local scaleFactor = (1 + anchored(note) * 0.15)
            noteTween("skewy"..note, note, {
                ["multScale.x"] = scaleFactor,
                ["multScale.y"] = scaleFactor,
                ["skew.x"] = -10,
                ["skew.y"] = -10,
                speedMult = scaleFactor
            }, {duration = stepsToSeconds(8), ease = "cubeOut"})
        end)
    end,

    [864] = function()
        forAllStrums(function(note)
            local scaleFactor = (1 - anchored(note) * 0.2)
            noteTween("skewy"..note, note, {
                ["multScale.x"] = scaleFactor,
                ["multScale.y"] = scaleFactor,
                ["skew.x"] = 10,
                ["skew.y"] = 10,
                speedMult = scaleFactor
            }, {duration = stepsToSeconds(8), ease = "cubeOut"})
        end)
    end,

    [880] = function() 
        -- cancelTween('camGameZoomTwn')

        forAllStrums(function(note)
            local scaleFactor = (1 + anchored(note) * 0.25)
            noteTween("skewy"..note, note, {
                ["multScale.x"] = scaleFactor,
                ["multScale.y"] = scaleFactor,
                ["skew.x"] = -10,
                ["skew.y"] = -10,
                speedMult = scaleFactor
            }, {duration = stepsToSeconds(8), ease = "cubeOut"})
        end)
    end,

    [888] = function() 
        forAllStrums(function(note)
            setPropertyFromGroup('strumLineNotes', note, 'angle', 360)
            noteTween("skewy"..note, note, {
                x = defaultStrumValues[note + 1].x,
                y = defaultStrumValues[note + 1].y,
                ["multScale.x"] = 1.2,
                ["multScale.y"] = 1.2,
                ["skew.x"] = 0,
                ["skew.y"] = 0,
                angle = 0,
                speedMult = 1
            }, {duration = stepsToSeconds(8), ease = "cubeOut"})
        end)
    end,

    [896] = function() 
        -- doTweenZoom('camGameZoomTwn', 'camGame', 1.1, {["duration"] = stepsToSeconds(48)})
        callOnLuas('floatySection', {false})
        beatHitFunc = getSmaller
        getSmaller()
    end,
    [908] = function() smallStep = 0 end,
    [924] = function() smallStep = 0 end,
    [944] = function()
        beatHitFunc = nil
    end,

    [952] = function()
        -- doTweenZoom('camGameZoomTwn', 'camGame', 0.6, {["duration"] = stepsToSeconds(8)}, "quartIn")
        doTweenAlpha('whiteOverlayAlpha', 'whiteOverlay', 1, {["duration"] = stepsToSeconds(8)}, "quartIn")
    
        forAllStrums(function(note)
            noteTween("skewy"..note, note, {
                x = defaultStrumValues[note + 1].x,
                ["multScale.x"] = 1,
                ["multScale.y"] = 1,
                ["skew.x"] = 0,
                speedMult = 1
            }, {duration = stepsToSeconds(8), ease = "cubeInOut"})
        end)
    end,
    [959] = function()
        -- cancelTween('camGameZoomTwn')
        cancelTween('whiteOverlayAlpha')

        setProperty('camHUD.alpha', 1)
        cameraFlash('camHud', 'FFFFFF', 1)
        setProperty('whiteOverlay.alpha', 0)
    end,

    [1018] = function()
        forAllStrums(function(note)
            local scale = math.random(1, 3)
            noteTween("screamer"..note, note, {
                x = math.random(0, screenWidth),
                y = math.random(0, screenHeight),
                ["multScale.x"] = scale,
                ["multScale.y"] = scale,
                angle = math.random(-2000, 2000)
            }, {duration = stepsToSeconds(2), ease = "quartIn"})
        end)
    end,

    [1020] = function()
        forAllStrums(function(note)
            noteTweenQuad("screamer"..note, note, {
                fromX = getPropertyFromGroup('strumLineNotes', note, 'x'),
                fromY = getPropertyFromGroup('strumLineNotes', note, 'y'),
                controlX = math.random(0, screenWidth),
                controlY = math.random(0, screenHeight),
                toX = defaultStrumValues[note + 1].x + - math.random(-10, 10),
                toY = defaultStrumValues[note + 1].y - math.random(6, 20) * downscrollFlipper
            }, {duration = stepsToSeconds(4), ease = "quartIn"})

            noteTween("umpley"..note, note, {
                ["multScale.x"] = 1,
                ["multScale.y"] = 1,
            }, {duration = stepsToSeconds(4), ease = "quartIn"})

            noteTweenAngle("angler"..note, note, 0, {duration = stepsToSeconds(4)})
        end)
    end,

    [1024] = function()
        forAllStrums(function(note)
            noteTween("reset"..note, note, {
                x = defaultStrumValues[note + 1].x,
                y = defaultStrumValues[note + 1].y,
            }, {duration = stepsToSeconds(4), ease = "cubeOut"})
        end)
    end
}

function onCreate()
    math.randomseed(-1333)
end

function onCreatePost()
    makeLuaSprite('whiteOverlay', '', 0.0, 0.0)
    makeGraphic('whiteOverlay', 1, 1, '#FFFFFF')
    setGraphicSize('whiteOverlay', 1280, 720)
    setObjectCamera('whiteOverlay', 'camOther')
    setProperty('whiteOverlay.alpha', 0)
    addLuaSprite('whiteOverlay')
end

function onSongStart()
    if stepChart[0] then stepChart[0]() end
end

function onUpdate(elapsed)
    for step,value in pairs(stepChart) do
        if  value and step <= curDecStep then
			value()
			stepChart[step] = nil
        end
    end

    for _, passthroughFunc in pairs(stepChartPassthrough) do 
        callOnLuas(passthroughFunc, {curDecStep})
    end

    if updateFunc then updateFunc(elapsed) end
end

function onBeatHit()
    if beatHitFunc then beatHitFunc(curBeat) end
end