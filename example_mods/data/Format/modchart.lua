-- so that spritetransform scale modifier works fine
--cloneMod('sprite', '')
set {
	0,
	0, 'miniX',
}

local swagWidth = 160 * 0.7

local function centerOffset(i, offset)
	local t = {-offset * 1.5, -offset * .5, offset * .5, offset * 1.5}
	return t[i + 1]
end

local function bounceOffset(scale, beat, note, endscale, _ease, player)
	endscale = endscale or 0
	set {
		beat,
		scale, 'scalex'..note,
		scale, 'scaley'..note,
		centerOffset(note, swagWidth * scale), 'x'..note,
		plr = player,
	}
	ease {
		beat, 1, _ease or outCubic,
		endscale, 'scalex'..note,
		endscale, 'scaley'..note,
		centerOffset(note, swagWidth * endscale), 'x'..note,
		plr = player,
	}
end

for beat=20,49 do
	for i=0,3 do
		bounceOffset(.1, beat, i)
	end
end


for i,v in pairs{
	{1, 3, 1},
	{0, 2, -1},
} do
	local beat = 50 + ((i - 1) * .25)
	for o=1,2 do
		local n = v[o]
		local m = (n == 2) and -1 or 1
		set {
			beat,
			-35 * (o * m), 'angle'..n,
			-20 * o, 'y'..n,
		}
		ease {
			beat, .25, outSine,
			0, 'angle'..n,
			0, 'y'..n,
		}
	end
end

for i=0,3 do
	local m = (i % 2 == 0) and 1 or -1
	ease {
		51, .25, inCubic,
		-.3, 'scalex'..i,
		-.3, 'scaley'..i,
		centerOffset(i, swagWidth * -.3), 'x'..i,
		360 * -m, 'angle'..i,
	}
	ease {
		51, .5, outCirc,
		-30, 'y'..i,
	}
	set {
		51.25,
		0, 'angle'..i,
	}
	ease {
		51.25, .5, outCubic,
		.2, 'scalex'..i,
		.2, 'scaley'..i,
		centerOffset(i, swagWidth * .2), 'x'..i,
		-45, 'angle'..i,
	}
	ease {
		51.75, .25, inCirc,
		0, 'scalex'..i,
		0, 'scaley'..i,
		0, 'x'..i,
		0, 'y'..i,
		0, 'angle'..i,
	}
end

local function formatBounce(from, to, first)
	for beat=from,to do
		local doSmall = first and beat == to
		if doSmall then
			print 'i did small'
		end
		for i=0,3 do
			if i % 2 == beat % 2 then
				bounceOffset(.2, beat, i, doSmall and -.2 or 0, doSmall and outInCirc or nil)
			elseif doSmall then
				ease {
					beat + .5, .5, inCirc,
					-.2, 'scalex'..i,
					-.2, 'scaley'..i,
					centerOffset(i, swagWidth * -.2), 'x'..i,
				}
			end
			ease {
				beat, .5, outCirc,
				-20, 'y'..i,
			}
			ease {
				beat + .5, .5, inCirc,
				0, 'y'..i,
			}
		end
	end
end
formatBounce(52, 83, true)
for i=0,3 do
	ease {
		84, .5, outCubic,
		0, 'scalex'..i,
		0, 'scaley'..i,
		0, 'x'..i,
	}
end

local function calmSpin(from, to)
	for beat=from,to,4 do
		--local e = (beat / 4) % 2 == 0
		for i,v in pairs {0, 1, 2.5, 3} do
			local e = i % 2 == 0 and -1 or 1
			ease {
				beat + v - .15, .15, inSine,
				15 * e, 'spin',
			}
			ease {
				beat + v, .35, outSine,
				0, 'spin',
			}
		end
	end
end

local function transBeat(beat)
	for i=0,3 do
		ease {
			beat - 1, .5, outCubic,
			-50, 'transform'..i..'Y',
			15, 'confusion'..i,
		}
		ease {
			beat - .5, .5, inCubic,
			centerOffset(i, -30), 'transform'..i..'X',
			30, 'transform'..i..'Y',
			360 - 35, 'confusion'..i,
		}
		set {
			beat,
			-35, 'confusion'..i,
		}
		ease {
			beat, .5, outCubic,
			0, 'transform'..i..'X',
			0, 'transform'..i..'Y',
			0, 'confusion'..i,
		}
	end
end

calmSpin(84, 98)
transBeat(100)

local offsets = {}
for i=0,3 do
	offsets[i] = math.random(-100, 100)
	set {
		0,
		offsets[i], 'circleOffset'..i
	}
end
ease {
	99, 1, outCirc,
	10, 'circle',
}
for i=100,114,2 do
	for o=0,3 do
		offsets[o] = offsets[o] + 2 + math.random(0, 2)
		ease {
			i, 2, outSine,
			offsets[o], 'circleOffset'..o,
		}
	end
end

ease {
	115, 1, inCirc,
	0, 'circle',
}

transBeat(116)

local function bouncingBabies(from, to, format, rot, fast)
	for i=from,to do
		for o=0,3 do
			local e = o % 2 == i % 2
			if format and e then
				bounceOffset(.2, i, o)
			end
			local s = (.25 * o)
			ease {
				i + s, .5, outQuad,
				-25, 'y'..o,
			}
			ease {
				i + s + .5, .5, inQuad,
				0, 'y'..o,
			}
			if rot then
				ease {
					i + s, 1, outQuad,
					e and -25 or 25, 'angle'..o,
				}
			end
		end
	end
end

bouncingBabies(116, 146)

transBeat(148)


for o=0,1 do
	local b = o * 8
	local plr = o == 0 and 2 or 1
	ease {
		b + 149, .5, outCubic,
		-20, 'y',
		plr = plr,
	}
	
	ease {
		b + 149.5, .5, inCubic,
		0, 'y',
		plr = plr,
	}
	
	ease {
		b + 150, .5, outCubic,
		50, 'y',
		plr = plr,
	}
	
	ease {
		b + 150.5, .5, inCubic,
		0, 'y',
		plr = plr,
	}
	for i=0,3 do
		ease {
			b + 150.75, .5, outBack,
			centerOffset(i, 50), 'x'..i,
			plr = plr,
		}
	
		set {
			b + 151.5,
			centerOffset(i, 25), 'x'..i,
			plr = plr,
		}
	
		set {
			b + 151.75,
			0, 'x'..i,
			plr = plr,
		}
	
		ease {
			b + 152, .5, outCubic,
			.3, 'scalex'..i,
			.3, 'scaley'..i,
			centerOffset(i, .3 * swagWidth), 'x'..i,
			plr = plr,
		}
		ease {
			b + 152.5, .5, inCubic,
			-.1, 'scalex'..i,
			-.1, 'scaley'..i,
			centerOffset(i, -.1 * swagWidth), 'x'..i,
			centerOffset(i, -45), 'angle'..i,
			plr = plr,
		}
	
		ease {
			b + 153, .5, outCubic,
			0, 'scalex'..i,
			0, 'scaley'..i,
			0, 'x'..i,
			0, 'angle'..i,
			plr = plr,
		}
	end

	for i=0,3 do
		for n=0,3 do
			if i % 2 == n % 2 then
				bounceOffset(.3, b + 154.5 + (i * .5), n, nil, nil, plr)
			end
		end
	end
end

local function slowShift(from, to)
	for b=from,to do
		for i=0,3 do
			local m = b % 2 == i % 2 and -1 or 1
			local s = .1 * m
			ease {
				b, 1, outSine,
				s, 'mini'..i..'X',
				s, 'mini'..i..'Y',
				centerOffset(i, swagWidth * -s), 'transform'..i..'X',
			}
		end
	end
end

slowShift(164, 179)

for i=0,3 do
	ease {
		180, .5, outSine,
		0, 'mini'..i..'X',
		0, 'mini'..i..'Y',
		0, 'transform'..i..'X',
	}
end

bouncingBabies(180, 195, false, true)

for i=0,3 do
	ease {
		196, 1, outQuad,
		0, 'angle'..i,
	}
end

for i=0,3 do
	for n=0,3 do
		bounceOffset(.1, 216 + i, n)
	end
end

formatBounce(196, 212, false)

bouncingBabies(220, 251)
bouncingBabies(252, 284, true)
bouncingBabies(252, 316)
for i=284,313.5,.5 do
	for o=0,3 do
		if (i * 2) % 2 == o % 2 then
			bounceOffset(.2, i, o)
		end
	end
end

for i=0,3 do
	for o=0,3 do
		if i % 2 == o % 2 then
			bounceOffset(.4, 314 + (i * .5), o)
		end
	end
end

ease {
	300, 16, linear,
	360 * 4, 'confusion',
}

set {
	316,
	.2, 'scalex',
	.2, 'scaley',
}

ease {
	316, .5, outQuad,
	0, 'scalex',
	0, 'scaley',
}



for i=0,7 do
	local n = i % 4
	local plr = i > 3 and 1 or 2

	ease {
		316, 8, inSine,
		centerOffset(n, 30), 'transform'..n..'X-a',
		-200 - (100 * i * .4), 'transform'..n..'Y-a',
		math.random(-90, 90), 'confusion'..n,
		plr = plr,
	}
end