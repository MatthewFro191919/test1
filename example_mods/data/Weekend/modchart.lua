local function sadDave(from, to)
	for i=from,to,2 do
		local b = i % 4 == 0 and 1 or -1
		for o=0,3 do
			local bb = o % 2 == 0
			local m = b * (bb and -1 or 1)
			ease {
				i - .25, .25, linear,
				10 * m, 'x'..o,
			}
			ease {
				i, 1.75, linear,
				0, 'x'..o,
			}
			ease {
				i, 1, outCubic,
				-20, 'y'..o,
			}
			ease {
				i + 1, 1, inCubic,
				0, 'y'..o,
			}
		end
	end
end
ease {
	256, .5, outCubic,
	1, 'glow',
}

ease {
	258, 1, linear,
	0, 'glow',
}

sadDave(66, 254)
sadDave(278, 342)

local function spikeCrazy(from, to, len)
	for i=from,to,len do
		local b = i % (len * 2) == 0 and -1 or 1
		for o=0,3 do
			local bb = b * (o % 2 == 0 and -1 or 1)
			ease {
				i, len * .5, outCubic,
				10, 'y'..o,
				5 * bb, 'angle'..o,
			}
			ease {
				i + (len * .5), len * .5, inCubic,
				0, 'y'..o,
				0, 'angle'..o,
			}
		end
	end
end

spikeCrazy(360, 487, 1)
spikeCrazy(488, 547, 2)
spikeCrazy(548, 679, 1)

for o=0,3 do
	ease {
		680, 1, outCubic,
		25, 'beat'..o,
		o % 2 == 0 and -.05 or .05, 'beatz'..o,
	}
	ease {
		840, 1, linear,
		0, 'beat'..o,
		0, 'beatz'..o,
	}
end