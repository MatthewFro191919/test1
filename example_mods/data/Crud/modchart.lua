
local toRad = math.pi / 180
--for o=0,3 do
--	ease {
--		112, 1, stepped(4),
--		1, 'crudpath'..o,
--	}
--end

set {
	-5,
	-.5, 'jimbleZ',
}

local function lameBop(from, to)
	for beat=from,to do
		for o=0,3 do
			local s = -math.abs(centerOffset(o, .05))
			ease {
				beat - .25, .25, stepped(2),
				centerOffset(o, swagWidth * s), 'x'..o,
				s, 'scalex'..o,
				s, 'scaley'..o,
			}
			ease {
				beat, .75, stepped(6),
				0, 'x'..o,
				0, 'scalex'..o,
				0, 'scaley'..o,
			}
		end
	end
end

lameBop(0, 95)

ease {
	96, 1, stepped(4),
	1, 'crudpath',
}

setModProperty('lerp', 'ease', inSine)
set {
	-5,
	swagWidth, 'lerpdistance',
}
for o=0,3 do
	local x = centerOffset(o, 45 * .5)
	ease {
		112, 1, stepped(4),
		-x, 'lerpx'..o,
		x, 'x'..o,
	}
end

ease {
	128, 16, stepped(72),
	1, 'opponentSwap',
}

ease {
	144, 16, stepped(72),
	0, 'opponentSwap',
}

local function theClassic(from, to)
	for beat=from,to do
		for o=0,3 do
			set {
				beat + (o * .25),
				(beat > 192 and beat < 256) and 15 or -15, beat > 224 and 'x'..o or 'y'..o,
			}
			set {
				beat + (o * .25) + .25,
				0, 'y'..o,
				0, 'x'..o,
			}
		end
	end
end

theClassic(160, 287)
ease {
	160, 4, stepped(8),
	0, 'crudpath',
}
for o=0,3 do
	ease {
		160, 4, stepped(8),
		0, 'lerpx'..o,
		0, 'x'..o,
	}
end



local function unlameBop(from, to, len, s)
	len = len or 2
	s = s or .2
	for beat=from,to,len do
		for o=0,3 do
			local s = math.abs(centerOffset(o, 1)) * ((beat/len) % 2 == 0 and s or -s)
			ease {
				beat - (.25 * len), .25 * len, stepped(2),
				centerOffset(o, swagWidth * s), 'x'..o,
				s, 'scalex'..o,
				s, 'scaley'..o,
			}
			ease {
				beat, .75 * len, stepped(6),
				0, 'x'..o,
				0, 'scalex'..o,
				0, 'scaley'..o,
			}
		end
	end
end

unlameBop(288, 349)

local function gayBop(from, to, strength, len)
	len = len or 1
	for beat=from,to,len do
		local m = (beat/len) % 2 == 0 and -1 or 1
		ease {
			beat - (len * .25), len * .25, stepped(2 * len),
			m * strength, 'gayholds',
		}
		ease {
			beat, len, stepped(6 * len),
			0, 'gayholds',
		}
	end
end
gayBop(400, 527, 1)
gayBop(528, 655, 8, 2)
gayBop(656, 783, 1)
-- return of the jimble * 3
setModProperty('jimble', 'canSkew', false)
setModProperty('jimble', 'useTan', false)

set {
	-5,
	10, 'jimbleSpread',
	0, 'jimbleSpeed',
}

ease {
	350, 2, stepped(4),
	.1, 'jimble',
} 

ease {
	397, 3, stepped(4),
	.4, 'jimble',
}

ease {
	400, 1, stepped(4),
	.15, 'tornado',
}

ease {
	462, 2, stepped(8),
	0, 'tornado',
}

ease {
	528, 1, stepped(2),
	.5, 'waveamount',
	8, 'wavedensity',
	10, 'wavetriangle',
	--200, 'y',
	--45, 'skewy',
}

local function pulseBop(from, to)
	for beat=from,to do
		for p=0,1 do
			local plr = p == 0 and 2 or 1
			for o=0,3 do
				local b = (p * .5) +  (o * .25 * .5)
				set {
					beat + b,
					.3, 'scalex'..o,
					.3, 'scaley'..o,
					plr = plr,
				}
				ease {
					beat + b, 1 / 3, stepped(4),
					0, 'scalex'..o,
					0, 'scaley'..o,
					plr = plr,
				}
			end
		end
	end
end

pulseBop(464, 495)

local function getX(player, i)
	local x = (1280 / 2) - swagWidth - 54 + (swagWidth * i)

	if player == 1 then
		x = x + (1280 / 2) - (swagWidth * 2) - 100
	elseif player == 0 then
		x = x - (1280 / 2) - (swagWidth * 2) - 100
	end
	
	x = x - 56

	return x
end

local function groupBop(from, to, strength)
	for beat=from,to do
		for p=0,1 do
			local plr = p + 1
			for o=0,3 do
				local x = 0
				if beat % 2 == 0 then
					x = -swagWidth * o
					if plr == 1 then
						x = x - 632
					end
				else
					x = swagWidth * (3 - o)
					if plr == 2 then
						x = x + 632
					end
				end
				x = x * strength
				local sx = -1.0 * strength
				local sy = 1.0 * strength
				ease {
					beat - .25, .25, stepped(2),
					x, 'x'..o,
					sx, 'scalex'..o..'-a',
					sy, 'scaley'..o..'-a',
					plr = plr,
				}
				ease {
					beat, .75, stepped(6),
					0, 'x'..o,
					0, 'scalex'..o..'-a',
					0, 'scaley'..o..'-a',
					plr = plr,
				}
			end
		end
	end
end

groupBop(495, 527, .075)

for o=0,3 do
	for i=0,1 do
		local b = 654 + (i * .25)
		if (o % 2) == i then
			local s = -.3
			set {
				b,
				centerOffset(o, swagWidth * s), 'x'..o,
				s, 'scalex'..o,
				s, 'scaley'..o,
			}
			ease {
				b, .25, stepped(4),
				0, 'x'..o,
				0, 'scalex'..o,
				0, 'scaley'..o,
			}
		end
	end
	
	local s = .3
	set {
		654.5,
		centerOffset(o, swagWidth * s), 'x'..o,
		s, 'scalex'..o,
		s, 'scaley'..o,
	}
	ease {
		654.5, .5, stepped(8),
		0, 'x'..o,
		0, 'scalex'..o,
		0, 'scaley'..o,
	}

	local ofs = o * .15
	ease {
		655 - .15 + ofs, .15, stepped(2),
		.2, 'squish'..o,
	}

	ease {
		655 + ofs, .25, steppedEase(outCubic, 4),
		-.2, 'squish'..o,
		-40, 'y'..o,
	}
	ease {
		655 + ofs, .25, steppedEase(inCubic, 4),
		0, 'squish'..o,
		0, 'y'..o,
	}
end

local function madFormat(from, to, s)
	s = s or .3
	for beat=from,to do
		for o=0,3 do
			if o % 2 == beat % 2 then
				set {
					beat,
					centerOffset(o, swagWidth * s), 'x'..o,
					s, 'scalex'..o,
					s, 'scaley'..o,
				}
				ease {
					beat, 1, steppedEase(outCubic, 6),
					-30, 'y'..o,
					0, 'x'..o,
					0, 'scalex'..o,
					0, 'scaley'..o,
				}
				ease {
					beat + 1, 1, steppedEase(inCubic, 6),
					0, 'y'..o,
				}
			end
		end
	end
end
madFormat(656, 718)

ease {
	728, 32, linear,
	20, 'jimble',
}

set {
	736,
	.4, 'jimble',
}

local function madBabies(from, to)
	for beat=from,to do
		for o=0,3 do
			local ofs = o * .25
			ease {
				beat + ofs, .5, steppedEase(outCubic, 6),
				-20, 'y'..o,
			}
			ease {
				beat + ofs + .5, .5, steppedEase(inCubic, 6),
				0, 'y'..o,
			}
		end
	end
end

madBabies(736, 783)

ease {
	784, 16, linear,
	0, 'jimble',
}

reset {788}

for i=0,3 do
	local b = 16 * i
	lameBop(800 + b, 807 + b)
	unlameBop(808 + b, 815 + b, 1, .1)
end

madFormat(864, 894, .1)

ease {
	896, 1, stepped(4),
	1, 'crudpath',
}
ease {
	928, 2, stepped(8),
	0, 'crudpath',
}

print 'its a-okay'