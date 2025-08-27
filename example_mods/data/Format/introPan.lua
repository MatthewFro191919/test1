function onCreatePost()
    setProperty("isCameraOnForcedPos", true)
    setProperty("disableAllCamMovement", true)
    snapCamFollowToPos(
        getMidpointX('partner') + getProperty("partner.cameraPosition.x") + getProperty("girlfriendCameraOffset.x"),
        getMidpointY('partner') + getProperty("partner.cameraPosition.y") + getProperty("girlfriendCameraOffset.y") - 900,
        true
    )
end

function onSongStart()
    setProperty("disableAllCamMovement", false)
end

local hasRenabledCam = false
function onUpdate()
    if curBeat >= 20 and hasRenabledCam == false then
        hasRenabledCam = true
        cancelTween("cutsceneStart")
        setProperty("camFollowPos.y", 1093)
        setProperty("isCameraOnForcedPos", false)
        cameraSetTarget('dad')
    end
end
function onStepHit()
	if (curStep == 16) then
		doTweenY("cutsceneStart", "camGame.camFollow", getProperty("camGame.camFollow.y") + 900, {["duration"] = 8, ["ease"] = "quadInOut"})
	end
end