local beatHitFunc = nil;
local thisScriptIn3D = false;

local runStepChart = {}

local stepChart = {
    [842] = function()
        --cameraFlash('game', 'FFFFFF', 1)
        callOnLuas('changeBG')

        addLuaSprite('jimblewatch', false)
        doTweenY('the jimple appears ARGHH!!', 'jimblewatch', -15, {["duration"] = 1.8, ["ease"] = 'cubeInOut'})
        setProperty('wheelchair.angularVelocity', -50)
        setProperty('wheelchair.velocity.x', -140)
        setProperty('wheelchair.velocity.y', -160)
        addLuaSprite('wheelchair')
        thisScriptIn3D = true;
    end,
    [914] = function()
        removeLuaSprite('wheelchair') -- offscreen by now... probably
    end,
    [1132] = function()
        thisScriptIn3D = false;
        doTweenY('the jimple floats back.. woww', 'jimblewatch', -15, {["duration"] = 0.25, ["ease"] = 'quadInOut'})
        playAnim('jimblewatch', 'JOMNLE')
    end,
    [1223] = function()
        setProperty('dad.alpha', 0)

        setProperty('modifiers.beatBounce.enabled', true)
        setProperty('modifiers.beatBounce.multiplier', 60)

        setProperty('cubleDeath.alpha', 1)
        setProperty('explosion.alpha', 1)
		setProperty('explosion.animation.callback', function(n, f, a)
			if f >= 10 then
				setProperty('cubleMic.visible', true)
			end
		end)
        playAnim('cubleDeath', 'death')
        playAnim('explosion', 'explode')
        setProperty('camZoom', getProperty('camZoom') + 0.2) 
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.1)
        setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.1)

        setProperty('camGame.angle', 15)
        doTweenAngle('camGameAngle', 'camGame', 0, {["duration"] = stepsToSeconds(4.3), ["ease"] = 'cubeOut'})
    end,
    [1232] = function()
        removeLuaSprite('cubleDeath', true)
        removeLuaSprite('explosion', true)

        setProperty('dad.alpha', 1) -- Psych Engine
        setProperty('dad.offset.x', 2000)
        doTweenX('jimbleSaysHi', 'dad.offset', 0, {["duration"] = 1, ['ease'] = 'quartOut'})

        if cameraZoomOnBeat then
            beatHitFunc = function(curBeat) 
                setProperty('camZoom', getProperty('camZoom') + 0.035) 
                setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
                setProperty('camStrums.zoom', getProperty('camStrums.zoom') + 0.025)
            end
        end
    end,
    [1664] = function()
     -- hi cuble
        addLuaSprite('bgcuble', false)
        playAnim('bgcuble', 'idle')
        setObjectOrder('bgcuble', getObjectOrder('foreground3D'))
        setProperty('bgcuble.velocity.y', -200)
        setProperty('bgcuble.angularVelocity', 40)
    end,
    [2115] = function()
        beatHitFunc = false
        setProperty('modifiers.beatBounce.enabled', false)
    end,
    [2122] = function()
        setProperty('dad.visible', true)
        cameraSetTarget('dad')
    end,
    [2195] = function()
        addLuaSprite('littleflong', false)
        setProperty('littleflong.animation.curAnim.curFrame', -1)
        scaleObject('littleflong', 0.3, 0.3, true)
        setObjectOrder('littleflong', getObjectOrder('foreground3D'))
        setProperty('littleflong.velocity.x', -250)
        setProperty('littleflong.velocity.y', 40)
        setProperty('littleflong.angularVelocity', -20)
    end,
    [2256] = function()
        setProperty('littleflong.animation.curAnim.curFrame', -1)
        scaleObject('littleflong', 0.2, 0.2, true)
        -- setPosition('littleflong', -700, 500) -- whyyy is this not a function huh
        setProperty("littleflong.x", -700)
        setProperty("littleflong.y", 500)
        setProperty('littleflong.velocity.x', 200)
        setProperty('littleflong.velocity.y', -50)
        setProperty('littleflong.angularVelocity', 16)
    end,
}

function onCreate()
    for step in pairs(stepChart) do
        runStepChart[step] = false
    end
end

function onCreatePost()
    makeLuaSprite('wheelchair', 'stages/deepFences/wheelChair', getCharacterX("dad") - 15, getCharacterY("dad") - 80)
    setProperty('wheelchair.antialiasing', false)
    setProperty('wheelchair.moves', true)

    -- liittle baby background jimble fly
    makeAnimatedLuaSprite('jimblewatch', 'stages/deepFences/jimblefriewndjombleYUP', 750, 1500) -- -15 ayaya
    addAnimationByPrefix('jimblewatch', 'JOMNLE', 'JOMNLE instance 1', 24, false)
    addAnimationByPrefix('jimblewatch', 'dormant', 'JOMNLE instance 10000', 24, false)
    setProperty('jimblewatch.antialiasing', false)
    setScrollFactor('jimblewatch', 0.9, 0.9)

    playAnim('jimblewatch', 'dormant')

    -- liittle baby background jimble
    makeAnimatedLuaSprite('littleflong', 'stages/deepFences/im in a fucking wheelchair', 1700, -100)
    addAnimationByPrefix('littleflong', 'idle', 'crippleFlong', 0, false)
    setProperty('littleflong.antialiasing', false)
    setProperty('littleflong.moves', true)
    setScrollFactor('littleflong', 0.35, 0.35)

    playAnim('littleflong', 'idle')
    scaleObject('littleflong', 0.2, 0.2, true)

    -- liittle baby background CUBLE
    makeAnimatedLuaSprite('bgcuble', 'stages/deepFences/littleBG_boy', ((getCharacterX("dad") + getCharacterX("bf")) / 2) - 400, 1200)
    addAnimationByPrefix('bgcuble', 'idle', 'erm', 24, false)
    setProperty('bgcuble.antialiasing', false)
    setProperty('bgcuble.moves', true)
    setScrollFactor('bgcuble', 0.35, 0.35)
    scaleObject('bgcuble', 0.35, 0.35, true)


    makeAnimatedLuaSprite('explosion', 'stages/deepFences/BOOM')
    addAnimationByPrefix('explosion', 'explode', 'BigBoomies', 30, false)
    setProperty('explosion.alpha', 0.00001) -- doing this fixes the lag spike... i guess
    scaleObject('explosion', 4.5, 4.5, true)
    setProperty('explosion.x', getMidpointX('dad') - (getProperty('explosion.width') / 2))
    setProperty('explosion.y', getMidpointY('dad') - (getProperty('explosion.height') / 2))
    setProperty('explosion.antialiasing', false)
    addLuaSprite('explosion', true)

    makeAnimatedLuaSprite('cubleDeath', 'stages/deepFences/DIE_stupidFuckingCube', -200, -250)
    addAnimationByPrefix('cubleDeath', 'death', 'DIE', 24, false)
    setObjectCamera('cubleDeath', 'camOther')
    setProperty('cubleDeath.antialiasing', false)
    setProperty('cubleDeath.alpha', 0.00001)
    scaleObject('cubleDeath', 0.8, 0.8, true)
    addLuaSprite('cubleDeath', true)
end

function onNoteSpawn(data)
    if data.strumTime > 142153 and data.strumTime < 228920 and data.mustHit == false then
        setPropertyFromGroup('notes', data.index, 'multSpeed', flashingLights and 6 or 2.5)
        setPropertyFromGroup('notes', data.index, 'jimbleHit', true)
    end
end

function onUpdate()
    for step in pairs(stepChart) do
        if step <= curStep and runStepChart[step] == false then
            runStepChart[step] = true
            stepChart[step]()
        end
    end

    if thisScriptIn3D then
        setProperty('jimblewatch.y', getProperty('jimblewatch.y') + (math.sin(elapsedTime - 1.15) * (getProperty('jimblewatch.scrollFactor.x') / 4) * (60 / getPropertyFromClass('flixel.FlxG', 'updateFramerate'))))
    end
end

function onBeatHit()
    if beatHitFunc then beatHitFunc(curBeat) end

    if (curBeat % 2 == 0) then
        playAnim('bgcuble', 'idle', true)
    end
end