local p = print
local function print(...)
	p("[backstage.lua]	", ...)
end

local toRad = math.pi / 180

set {
	-5, 
	1, 'alpha',
	plr = 2,
}

local function wormCircle(beat, len, plrs, params)
	plrs = plrs or 1
	plrs = getPlayers(plrs)
	params = params or {}
	ease {
		beat, 3, inOutSine,
		params.swap or .5, 'opponentSwap',
		-25, 'circle',
		-.75, 'circleSpeed',
		1, 'circleOffset',
		-50, 'x',
		50, 'y',
		-.05, 'z',
		.8, 'circleScaleX',
		plr = plrs,
	}
	

	for _,plr in ipairs(plrs) do
		for b=beat,beat + len,12 do
			local v = math.floor((b - len)/12) % 2
			local m = v == 0 and 1 or -1
			m = m * (plr == 2 and -1 or 1)
			local p = (b + 6 + 12) > params.finish and ((params.finish - (b + 6)) / 12) or 1
			--print(b, p)
			ease {
				b + 6, 12 * p, inOutSine,
				toRad * 7 * m * p, 'strumrotateZ',
				7 * m * p, 'angle',
				plr = plr,
			}
		end
	end
end
wormCircle(-5, (56 - 12) + 5, nil, {finish = 55})
ease {
	30, 6, inOutSine,
	90, 'x',
}
ease {
	51, 3, inOutSine,
	25, 'x',
}

local function unWormCircle(beat, plrs)
	ease {
		beat, 2, inCubic,
		0, 'opponentSwap',
		0, 'x',
		0, 'y',
		0, 'z',
		0, 'circle',
		0, 'strumrotateZ',
		0, 'angle',
		plr = getPlayers(plrs or 1),
	}
end

unWormCircle(55)

ease {
	55, 2, inCubic,
	0, 'alpha',
	plr = 2,
}

for o=0,3 do
	set {
		-5,
		math.random(-50, 50), 'x'..o,
		math.random(-50, 50), 'y'..o,
		math.random(-.1, .1), 'z'..o,
		math.random(-360, 360), 'angle'..o,
		plr = 2,
	}
	ease {
		55, 3, inOutCubic,
		0, 'x'..o,
		0, 'y'..o,
		0, 'z'..o,
		0, 'angle'..o,
		plr = 2,
	}
end

local function wormPunch(beat)
	for p=1,2 do
		local DUMB = p == 1 and '-a' or ''
		for o=0,3 do
			set {
				beat,
				math.random(-25, 25), 'x'..o..DUMB,
				math.random(-25, 25), 'y'..o..DUMB,
				--math.random(0, 0), 'z'..o,
				math.random(-25, 25), 'angle'..o..DUMB,
				plr = p,
			}
			ease {
				beat, 1.5, outSine,
				0, 'x'..o..DUMB,
				0, 'y'..o..DUMB,
				--0, 'z'..o,
				0, 'angle'..o..DUMB,
				plr = p,
			}
		end
	end
end

for beat=57,72,3 do
	wormPunch(beat + 2)
end

for beat=75,80,1.5 do
	wormPunch(beat)
end

for beat=81,102,3 do
	wormPunch(beat + 2)
end

ease {
	75, 1, outCubic,
	170, 'x',
	-.2, 'z',
	.5, 'alpha',
	plr = 1,
}
for beat=75,80,.5 do
	for o=0,3 do
		local m = o % 2 == beat % 2 and -1 or 1
		set {
			beat,
			math.random(25, 50) * m, 'skewx'..o,
			plr = 2,
		}
		ease {
			beat, .5, outSine,
			0, 'skewx'..o,
			plr = 2,
		}
	end
end

ease {
	80, 1, inCubic,
	0, 'x',
	0, 'z',
	0,'alpha',
}

wormPunch(103)
wormPunch(104)

ease {
	103, 1, linear,
	1, 'alpha',
}

set {
	111,
	0, 'alpha',
}

for beat=111,177 - 3,3 do
	--local v = beat % 18
	--if v == 0 or v > 6 or beat <= 111 + 6 then
	if beat < 129 or beat > 135 - 3 then
		wormPunch(beat + 2)
	end
end

do
	local beat = 111 + 18
	wormPunch(beat)
	wormPunch(beat + 1.5)
	wormPunch(beat + 3)
	wormPunch(beat + 5)
end

-- invis here
set {
	109,
	.1, 'drunk',
}

for beat=159,159 + (12 * 1),12 do
	local m = (beat/12) % 2 == .25 and -1 or 1
	--print((beat/12) % 3)
	local a = m * 10
	ease {
		beat, 12, outSine,
		toRad * a, 'centerrotateZ',
		a, 'angle-a',
	}
end

for beat=111,177 - 3,3 do
	local m = (beat/3) % 2 == 0 and 1 or -1
	local a = 6 * m
	if (beat/3) % 4 == 0 then
		for i=0,1 do
			-- rise
			local a = i == 1 and -a or a
			ease {
				beat + (i * 1.5), 1, inSine,
				.25, 'tipsy',
				1, 'gayholds',
				a, 'angle',
				a * toRad, 'strumrotateZ',
			}
			-- go away
			ease {
				beat + (i * 1.5) + 1, .5, inSine,
				0, 'tipsy',
				0, 'gayholds',
				0, 'angle',
				0, 'strumrotateZ',
			}
		end
	else
		-- rise
		ease {
			beat, 2.5, inCubic,
			.6, 'tipsy',
			3, 'gayholds',
			a, 'angle',
			a * toRad, 'strumrotateZ',
		}
		-- go away
		ease {
			beat + 2.5, .5, inCubic,
			0, 'tipsy',
			0, 'gayholds',
			0, 'angle',
			0, 'strumrotateZ',
		}
	end
end

for b=0,2 do
	wormPunch(177 + b)
end

ease {
	183 - 1, 1, inSine,
	0, 'centerrotateZ',
	0, 'angle-a',
}

ease {
	183, 2, outSine,
	-.25, 'z',
	-150, 'x',
	1, 'alpha',
	plr = 2,
}

ease {
	183, 2, outSine,
	.35, 'opponentSwap',
	plr = 1,
}

local noob = false
for b=195,204,3 do
	noob = not noob
	local m = noob and -1 or 1
	local a = 10 * m
	set {
		b,
		a * toRad , 'strumrotateZ',
		a, 'angle-a',
		plr = 1,
	}
	ease {
		b, 2.5, outSine,
		0, 'strumrotateZ',
		0, 'angle-a',
	}
end
wormCircle(207, 46, {1, 2}, {swap = .6, finish = 253})

ease {
	216, 6, inOutSine,
	160, 'x',
}

ease {
	231, 2, outSine,
	.5, 'opponentSwap',
	plr = 1,
}
set {
	231,
	-1, 'glow',
	plr = 2,
}
ease {
	231, 2, outSine,
	-.2, 'opponentSwap',
	-.1, 'z',
	.9, 'alpha',
	plr = 2,
}

ease {
	231, 5, outSine,
	-.5, 'glow',
	plr = 2,
}

unWormCircle(253, {1, 2})
ease {
	253, 2, inCubic,
	0, 'glow',
	0, 'alpha',
	plr = 2,
}

for b=255,276 - 3,3 do
	wormPunch(b + 2)
end

for b=276,278 do
	wormPunch(b)
	local m = b % 2 == 0 and -1 or 1
	set {
		b,
		50 * m, 'skewx',
		16, 'gayholds',
		plr = 2,
	}
	ease {
		b, 1, outCubic,
		b == 278 and 0 or 15 * m, 'skewx',
		0, 'gayholds',
		plr = 2,
	}
end

for b=279,303 - 3,3 do
	wormPunch(b + 2)
end

ease {
	306, 3, inCubic,
	1000, 'gayholds',
	1, 'drunk',
	-700, 'y',
	1, 'tAccel',
}

local friends = {"invert", "flip"}
local friendVal = {0, 0}
for b=306,309,.25 * .5 do
	local id = math.random(1, #friends)
	local friend = friends[id]
	friendVal[id] = friendVal[id] == 0 and 100 or 0
	ease {
		b, .25 * .5, linear,
		friendVal[id], friend,
	}
end

set {
	309,
	2, 'gayholds',
	.3, 'drunk',
	720, 'y',
	-1, 'glow',
	1, 'alpha',
	0, 'tAccel',
}
ease {
	314, 6, outCubic,
	0, 'y',
	0, 'glow',
	0, 'alpha',
}

ease {
	316, 2, outCubic,
	0, 'invert',
	0, 'flip',
}

-- live reaction: ITS 5???
local m = 1
for b=309,389 - 5,5 do
	m = m * -1
	local a = 4.45 * m
	set {
		b,
		toRad * a, 'centerrotateZ',
		a, 'angle',
	}
	ease {
		b, 5, outCubic,
		0, 'centerrotateZ',
		0, 'angle',
	}

	if b < 384 then
		wormPunch(b + 2)
		if b == 354 then
			wormPunch(b + 4.5)
		elseif b ~= 364 then
			wormPunch(b + 4)
		end
	end
end

for b=385,388,.5 do
	wormPunch(b)
end

-- boxy function. but in lua. and it returns in beats.
local crochet = (60/180)*1000
local propTime = false
local function rotationStep(timeAh)
    local addition = timeAh;

    if not timeAh then 
		addition = 0
	end

    if addition >= 4 then
		addition = 4
	end

    if addition >= 4 and not propTime then 
		propTime = true
	end

    return ((math.pi/(6 + addition)) * 1000) / crochet;
end

ease {
	389, 3, inOutSine,
	0, 'z-a',
	0, 'gayholds', -- dont work with z :(
}
ease {
	389, 3, inOutSine,
	.35, 'alpha',
	-.25, 'glow',
	plr = 2,
}
local pb = 389
local len = rotationStep(0) * 2
local b = 389 + len
local m = 0
local i = 0
while b < 519 do
	if m == 0 then
		m = 1
	else
		m = 0
	end
	--print(b, m)
	ease {
		pb, len, inOutSine,
		m, 'opponentSwap',
	}
	for p=1,2 do
		local m = m
		if p == 2 then
			m = (m == 1) and 0 or 1
		end
		local mmm = (m * 2) - 1
		local a = 5 * mmm
		ease {
			pb - len * .5, len, inOutSine,
			-.3 * m, 'z',
			a * toRad, 'strumrotateZ',
			a, 'angle-a',
			plr = p,
		}
	end
	-- ok ok ok
	i = i + 1
	len = rotationStep((i * .5) - .5) * 2
	pb = b
	b = b + len
end
for b=389,513 - 2,2 do
	wormPunch(b + 1)
end

ease {
	469, 1, outSine,
	.1, 'z-a',
	50, 'y',
}
ease {
	485, 1, outSine,
	0, 'z-a',
	0, 'y',
}
ease {
	513, 4, inSine,
	-200, 'y',
}

ease {
	517, 1, outExpo,
	1, 'alpha',
}
set {
	520,
	0, 'opponentSwap',
	0, 'angle-a',
	0, 'strumrotateZ',
	0, 'z',
	0, 'y',
}
set {
	523,
	0, 'alpha',
	plr = 1,
}

wormCircle(520, 60, {1, 2}, {finish = 99999})

ease {
	574, 4, inSine,
	1, 'alpha',
}

print('ok im fine')