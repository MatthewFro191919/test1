local runStepChart = {}
local stepChart = {
    [1263] = function()
        setProperty('camZoomingMult', 0)
        setProperty('isCameraOnForcedPos', true)
        setProperty('moveCameraOnNote', false)
        setProperty('camZooming', false)
        
        snapCamFollowToPos(getCharacterX('partner') + 191, getCharacterY('partner') + 50, false)
        doTweenZoom('camGamezoom', 'camGame', 0.6, {["duration"] = stepsToSeconds(154)})
        doTweenAlpha('camHUDalpha', 'camHUD', 0, {["duration"] = stepsToSeconds(61.5)})
        doTweenAlpha('camStrumsalpha', 'camStrums', 0, {["duration"] = stepsToSeconds(61.5)})

        setProperty('defaultCamZoom', 0.6)
    end,
    
    [1303.15] = function()
        if not isStoryMode then return end
        playSound('cutscene/Format', 1, 'cutsceneAudio')

        setProperty('partner.visible', false)
        setProperty('dad.visible', false)
        setProperty('boyfriend.visible', false)
        
        for _, spriteName in ipairs({'gf', 'portal', 'panel', 'dave', 'boyfriend'}) do
            setScrollFactor(spriteName..'Cutscene', 1, 1)
            playAnim(spriteName..'Cutscene', spriteName..'Cutscene', true)
            setProperty(spriteName..'Cutscene.alpha', 1)
        end
    end,

    [1416] = function() 
        cameraFade('game', '#000000', stepsToSeconds(10))
    end
}

function onUpdate()
    for step in pairs(stepChart) do
        if step <= curStep and runStepChart[step] == false then
            runStepChart[step] = true
            stepChart[step]()
        end
    end

    if not isStoryMode then return end
    setShaderFloat('scaryBG', 'uTime', elapsedTime)
end

function onCreate()
    for step in pairs(stepChart) do
        runStepChart[step] = false
    end
    
    if not isStoryMode then return end
    precacheSound('cutscene/Format')

    makeAnimatedLuaSprite('gfCutscene', 'stages/daveBackyard/cutscene/gf', 1620, 707)
    addAnimationByPrefix('gfCutscene', 'gfCutscene', 'gfCutscene', 24, false)
    setProperty('gfCutscene.alpha', 0.00001)
    addLuaSprite('gfCutscene', true)
    
    makeAnimatedLuaSprite('portalCutscene', 'stages/daveBackyard/cutscene/portal', 778, 699)
    addAnimationByPrefix('portalCutscene', 'portalCutscene', 'portalCutscene', 24, false)
    setProperty('portalCutscene.alpha', 0.00001)
    addLuaSprite('portalCutscene', true)
    
    makeAnimatedLuaSprite('panelCutscene', 'stages/daveBackyard/cutscene/panel', 2288, 821)
    addAnimationByPrefix('panelCutscene', 'panelCutscene', 'panelCutscene', 24, false)
    setProperty('panelCutscene.alpha', 0.00001)
    addLuaSprite('panelCutscene', true)
    
    makeAnimatedLuaSprite('daveCutscene', 'stages/daveBackyard/cutscene/dave', 1295, 844)
    addAnimationByPrefix('daveCutscene', 'daveCutscene', 'daveCutscene', 24, false)
    setProperty('daveCutscene.alpha', 0.00001)
    addLuaSprite('daveCutscene', true)

    makeAnimatedLuaSprite('boyfriendCutscene', 'stages/daveBackyard/cutscene/boyfriend', 2173, 971)
    addAnimationByPrefix('boyfriendCutscene', 'boyfriendCutscene', 'boyfriendCutscene', 24, false)
    setProperty('boyfriendCutscene.alpha', 0.00001)
    addLuaSprite('boyfriendCutscene', true)

    for _, spriteName in ipairs({'gf', 'portal', 'panel', 'dave', 'boyfriend'}) do
        setScrollFactor(spriteName..'Cutscene', 0.0, 0.0) -- fixes Stupid lag spike
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if not isStoryMode then return end

    if string.match(tag, 'hideBG') then
        setProperty('scaryBG.visible', false)
    end

    if string.match(tag, 'showBG') then
        setProperty('scaryBG.visible', true)
    end
end

function onPause()
    if not isStoryMode then return end

    pauseSound('cutsceneAudio')
end

function onResume()
    if not isStoryMode then return end

    resumeSound('cutsceneAudio')
end