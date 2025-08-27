local doShit = false
local alternateTransition = false -- gets enabled if lowQuality or not shadersEnabled
local allShaderObjects = {}
local bgObjects = {'cliffs', 'cactus', 'ground'}

function onCreatePost()
    makeLuaSprite('tweenDummy', '', 0, 0)

    for _, character in pairs({'dad', 'boyfriend', 'partner'}) do
        setSpriteShader(character, 'periodicShader')
        color = getProperty(character..".healthColorArray")
        setShaderFloatArray(character, 'outlineColor', {color[1] / 255, color[2] / 255, color[3] / 255, 1})
        setShaderFloat(character, 'overlay', 0)
        table.insert(allShaderObjects, character)
    end

    for _, object in pairs(bgObjects) do
        setSpriteShader(object, 'periodicShader')
        color = getMostPresentColor(object)
        setShaderFloatArray(object, 'outlineColor', {color[1], color[2], color[3], color[4]})
        setShaderFloat(object, 'overlay', 0)
        table.insert(allShaderObjects, object)
    end

    return 
end

function swagShitShader(val)
    doShit = val

    if val == true then
        doTweenX('overlayTween', 'tweenDummy', 1, {["duration"] = 0.4, ["ease"] = "linear"})
        doTweenAlpha("blackOverlayTween", "blackOverlay", 1, {["duration"] = 0.4, ["ease"] = "linear"})
        -- doTweenAlpha('camHUDAlpha', 'camHUD', 0, {["duration"] = 0.4})
    end

    if val == false then
        cancelTween('overlayTween')
        cancelTween('blackOverlayTween')


        doTweenX('overlayTweenLal', 'tweenDummy', 0, {["duration"] = 0.4, ["ease"] = "linear"})
        doTweenAlpha("blackOverlayTweenLal", "blackOverlay", 0, {["duration"] = 0.4, ["ease"] = "linear"})
    end
end

function onUpdate(elapsed)
    -- if not doShit then return end

    for _, object in pairs(allShaderObjects) do
        setShaderFloat(object, 'overlay', getProperty('tweenDummy.x'))
    end
end