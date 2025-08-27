if true then
    return -- no
end

noteHitOffsets = {}

function opponentNoteHit(id, data, type, sus)
    if disableModcharts then return end
    if curBeat >= 128 and curBeat < 320 then
        for i=0,3 do
			setValue('x'..i..'-aa', noteHitOffsets[data][i + 1].x + math.random(-5, 5))
			setValue('y'..i..'-aa', noteHitOffsets[data][i + 1].y*(downscrollFlipper) + math.random(-5, 5))
			setValue('angle'..i..'-aa', noteHitOffsets[data][i + 1].a + math.random(-2, 2))
        end
    end
end

function onUpdatePost(e)
    if disableModcharts then return end
    if curBeat >= 128 then
		for p=0,1 do
			for i=0,3 do
				setValue('x'..i..'-aa', fpsLerp(getValue('x'..i..'-aa', p), 0, 0.15), p)
				setValue('y'..i..'-aa', fpsLerp(getValue('y'..i..'-aa', p), 0, 0.15), p)
				setValue('angle'..i..'-aa', fpsLerp(getValue('angle'..i..'-aa', p), 0, 0.15), p)
			end
		end
    end
end

function onCreate()
    if disableModcharts then return end
    noteHitOffsets[0] = {
        {x = -40, y = 0, a = 15},
        {x = -34, y = 0, a = 8},
        {x = -26, y = 0, a = 4},
        {x = -18, y = 0, a = 2}
    }
    noteHitOffsets[1] = {
        {x = 0, y = 26, a = 15},
        {x = 0, y = 40, a = 8},
        {x = 0, y = 26, a = -8},
        {x = 0, y = 18, a = -15}
    }
    noteHitOffsets[2] = {
        {x = 0, y = -18, a = -15},
        {x = 0, y = -26, a = -8},
        {x = 0, y = -40, a = 8},
        {x = 0, y = -26, a = 15}
    }
    noteHitOffsets[3] = {
        {x = 18, y = 0, a = -2},
        {x = 26, y = 0, a = -4},
        {x = 34, y = 0, a = -8},
        {x = 40, y = 0, a = -15}
    }
end