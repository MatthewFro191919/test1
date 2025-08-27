set {
	0,
	200, 'spiralperiod',
	8, 'jimbleSpread', -- guess which other song the "jimble" modifier will appear in! you snobby nosy dirty code reader
	5, 'bumpyPeriod',
	1, 'furiositySpread',
}
local function outerBop(from, to, complex, m)
	m = m or 1
	for i=from,to do
		if i % 2 == 0 then
			local m = (((i / 2) % 2 == 0) and -1 or 1) * m
			for o=0,3 do
				ease {
					i - .5, .5, inCubic,
					-25 * m, 'x'..o,
				}
				ease {
					i, .5, outCubic,
					50 * m, 'x'..o,
				}
				ease {
					i + .5, 1, inOutCubic,
					0, 'x'..o,
				}
			end
		end
		local m = (i % 2 == 0 and -1 or 1) * m
		for o=0,3 do
			local m = m * (o % 2 == 0 and -1 or 1)
			ease {
				i, .5, outCubic,
				10 * m, 'y'..o,
			}
			ease {
				i + .5, .5, inCubic,
				0, 'y'..o,
			}
		end
		if complex then
			local a = 35 * m
			ease {
				i - .25, .25, inCubic,
				a, 'spiral',
				a, 'confusion',
			}
			ease {
				i, .75, outCubic,
				0, 'spiral',
				0, 'confusion',
			}
		end
	end
end
outerBop(0, 62, false)

local function outerPunch(beat, n, l)
	n = n or {0, 1, 2, 3}
	l = l or 1
	for _,i in pairs(n) do
		local s = .5
		ease {
			beat - (l * .25), l * .25, inCubic,
			s, 'scalex'..i,
			s, 'scaley'..i,
			centerOffset(i, swagWidth * s), 'transform'..i..'X-aaaa',
			plr = 2,
		}
		ease {
			beat, l * .75, outCubic,
			0, 'scalex'..i,
			0, 'scaley'..i,
			0, 'transform'..i..'X-aaaa',
			plr = 2,
		}
	end
end

for i=0,1 do
	local b = i * 256
	outerPunch(b + 5, {0, 3})
	outerPunch(b + 5.25, {1, 2})
	ease {
		b + 6, .5, linear,
		360, 'angle2',
		pl2 = 2,
	}
	set {
		b + 6.5,
		0, 'angle2',
		plr = 2,
	}
	outerPunch(b + 7, {3}, .5)
	outerPunch(b + 7.5, {3}, .5)
	for i=0,3 do
		outerPunch(b + 8 + (i * .25), {i})
	end
	for i=0,1 do
		outerPunch(b + 11 + (i * .5), {3}, .5)
		outerPunch(b + 11.5 + (i * .5), {0}, .5)
	end
	outerPunch(b + 12, {2})
	for i=0,3 do
		outerPunch(b + 13 + (i * .25), {3 - i})
	end
end

outerPunch(33, {0})
for i=0,2 do
	outerPunch(33.75 + (i * .5), {3}, .5)
end
for i=0,1 do
	outerPunch(34 + (i * .5), {2}, .5)
end
outerPunch(36.75, {0, 1})
for i=0,3 do
	outerPunch(37 + (i * .5), {3 - i}, .5)
end
outerPunch(39, nil, .5)
outerPunch(39.5)

for i=0,7 do
	local n = i > 3 and ((4 - i) % 4) or i
	local b = 42 + (i * .25)
	ease {
		b, .5, linear,
		360, 'angle'..n,
		plr = 2,
	}
	set {
		b + .5,
		0, 'angle'..n,
		plr = 2,
	}
end

--for i=0,3 do
--	set {
--		0,
--		.5, 'tAccel'..i
--	}
--end
local function wrap(i, s)
	while i > s do
		i = i - s
	end
	return s
end
--for i=0,100 do
--	for o=0,3 do
--		for s=0,3 do
--			ease {
--				i + (s / 4), .25, outSine
--				((s + o) % 4) / 8, 'tAccel'..o,
--			}
--		end
--	end
--end

for i=0,3 do
	ease {
		63, 1, inCubic,
		360, 'angle'..i,
		.3, 'scalex'..i,
		.3, 'scaley'..i,
		centerOffset(i, -swagWidth * 2), 'x'..i,
	}
	ease {
		64, .25, outCubic,
		0, 'angle'..i,
		0, 'scalex'..i,
		0, 'scaley'..i,
		0, 'x'..i,
	}
end

local function innerBump(from, to)
	for i=from,to do
		for o=0,3 do
			ease {
				i - .5, .5, inSine,
				.5, 'tAccel'..o,
			}
			ease {
				i, .5, outSine,
				0, 'tAccel'..o,
			}
		end
	end
end

innerBump(64, 127)

local function innerShuffle(beat)
	for i=0,3 do
		ease {
			beat + (.25 * i), .25, outCubic,
			-25 * (i % 2 == 0 and -1 or 1), 'x',
		}
	end

	ease {
		beat + 1, .25, outCubic,
		0, 'x',
	}
end
for i=0,1 do
	local b = 16 * i
	innerShuffle(64 + b)
	ease {
		65 + b, .5, inCubic,
		30, 'y',
	}
	ease {
		65.5 + b, .5, outCubic,
		0, 'y',
	}
	innerShuffle(66 + b)
	ease {
		67 + b, .5, inCubic,
		-30, 'y',
	}
	ease {
		67.5 + b, .5, outCubic,
		0, 'y',
	}

	for i=0,3 do
		for o=0,3 do
			ease {
				68 + b + i, 1, outBack,
				centerOffset(o, swagWidth * ((i + 1) * .1)), 'x'..o,
			}
		end
	end
	for i=0,3 do
		ease {
			72 + b, .5, outCubic,
			0, 'x'..i,
		}
	end

	ease {
		72 + b, 4, linear,
		360, 'angle',
		.5, 'tipZ',
	}
	set {
		76 + b,
		0, 'angle',
	}


	for i=76,79 do
		local m = i % 2 == 0 and -1 or 1
		for o=0,3 do
			local s = -.2 * m
			ease {
				i + b - .25, .25, inCubic,
				s, 'scalex'..o,
				s, 'scaley'..o,
				centerOffset(o, swagWidth * s), 'x'..o,
			}
			ease {
				i + b, .75, outCubic,
				0, 'scalex'..o,
				0, 'scaley'..o,
				0, 'x'..o,
			}
		end
	end

	ease {
		79 + b, 1, inCubic,
		0, 'tipZ',
	}

	for i=0,1 do
		local m = i == 0 and 1 or -1
		local b = b + i
		local a = 30 * m
		ease {
			96 + b - .5, .5, inCubic,
			a, 'spiral',
			a, 'confusion',
		}
		ease {
			96 + b, .5, outCubic,
			0, 'spiral',
			0, 'confusion',
		}
	end
	ease {
		98 + b, 2, linear,
		10, 'spiral',
		10, 'confusion',
	}
	ease {
		102 + b, 2, linear,
		0, 'spiral',
		0, 'confusion',
	}
	ease {
		106 + b, 2, linear,
		-10, 'spiral',
		-10, 'confusion',
	}
	ease {
		110 + b, .5, outCubic,
		0, 'spiral',
		0, 'confusion',
	}
	set {
		111 + b,
		2, 'jimble',
	}
	ease {
		111 + b, 1, outSine,
		0, 'jimble',
	}

	for o=0,3 do
		for i=0,3 do
			local m = o % 2 == i % 2 and -1 or 1
			local s = .2 * m
			do
				local b = 98 + b + (o * .5)
				set {
					b,
					centerOffset(i, swagWidth * s), 'transform'..i..'X-a',
					s, 'scalex'..i,
					s * .6, 'scaley'..i,
				}
				ease {
					b, .5, outQuad,
					0, 'transform'..i..'X-a',
					0, 'scalex'..i,
					0, 'scaley'..i,
				}
			end
			do
				local b = 100 + b + (o * .25)
				ease {
					b, .25, outElastic,
					10 * (o + 1), 'transform'..i..'Y',
					centerOffset(i, -15 * (o + 1)), 'transform'..i..'X',
				}
			end
		end
	end
	for i=0,3 do
		ease {
			101 + b, .5, outBack,
			centerOffset(i, 50), 'transform'..i..'X',
			centerOffset(i, -45), 'angle'..i,
		}
		ease {
			101.5 + b, .5, outBack,
			0, 'transform'..i..'X',
			0, 'transform'..i..'Y',
			0, 'angle'..i,
		}
		ease {
			102 + b, .5, outCirc,
			-360, 'angle'..i,
			-30, 'transform'..i..'Y',
		}
		set {
			102.5 + b,
			0, 'angle'..i,
		}
		ease {
			102.5 + b, .5, inCirc,
			35, 'angle'..i,
			15, 'transform'..i..'Y',
		}
		ease {
			103 + b, .5, outCubic,
			0, 'angle'..i,
			0, 'transform'..i..'Y',
		}
	end

	for o,n in pairs{2, 0, 3, 1} do
		ease {
			108 + b + ((o - 1) * .5), .5, outSine,
			(swagWidth * (i == 0 and 3 or -3)) + (i == 0 and -45 or 45), 'transform'..n..'X-aa',
			plr = (i == 0 and 2 or 1),
		}
		local x = (swagWidth * (i == 0 and -3 or 3))
		ease {
			108 + b, .5, outSine,
			swagWidth, 'transform'..n..'Y-aa',
			plr = (i == 0 and 1 or 2),
		}
	end

	local p = i == 0 and 2 or 1
	for i=0,1 do
		local bb = 110 + b + i
		local s = .3
		for o=(i * 2),1 + (i * 2) do
			ease {
				bb - .25, .25, inCubic,
				s, 'scalex'..o,
				s, 'scaley'..o,
				centerOffset(o, swagWidth * s), 'transform'..o..'X-aaa',
				plr = p,
			}
			ease {
				b + 112, .5, outCubic,
				0, 'scalex'..o,
				0, 'scaley'..o,
				0, 'transform'..o..'X-aaa',
				0, 'transform'..o..'X-aa',
				0, 'transform'..o..'Y-aa',
			}
		end
	end

	for i=0,3 do
		for o=0,3 do
			local m = i % 2 == o % 2 and -1 or 1
			local bb = 104 + o + b
			set {
				bb,
				50 * m, 'skewx'..i,
			}
			ease {
				bb - .25, .25, inCubic,
				50, 'flip',
			}
			ease {
				bb, .75, outCubic,
				0, 'skewx'..i,
				0, 'flip',
			}
		end
	end
end

outerBop(128, 128, true)
outerBop(130, 130, true, -1)
outerBop(132, 132, true)
outerBop(136, 145, true)
outerBop(148, 148, true)
outerBop(150, 150, true)
outerBop(152, 159, true)
outerBop(165, 166, true)
outerBop(168, 170, true)
outerBop(172, 174, true)
outerBop(176, 187, true)


for i=0,3 do
	ease {
		129, .5, outCubic,
		.75, 'tAccel',
		plr = 2,
	}
	ease {
		129.5, .25, outCubic,
		0, 'tAccel',
		plr = 2,
	}
end
set {
	129.5,
	2.5, 'jimble',
	plr = 2,
}
ease {
	129.5, .5, outCubic,
	0, 'jimble',
	plr = 2,
}
set {
	130,
	-30, 'transform0X',
	-45, 'confusion0',
	plr = 2,
}
ease {
	130, .5, outCirc,
	0, 'transform0X',
	0, 'confusion0',
	plr = 2,
}
set {
	131,
	5, 'jimble',
	plr = 2,
}
set {
	132,
	0, 'jimble',
	plr = 2,
}
for i=0,3 do
	for o=0,1 do
		local s = .2 * (o + 1)
		ease {
			133 + o, .5, outQuart,
			s, 'scalex'..i,
			centerOffset(i, swagWidth * s), 'transform'..i..'X',
			plr = 2,
		}
	end
	ease {
		134, .5, outBack,
		0, 'scalex'..i,
		0, 'transform'..i..'X',
		plr = 2,
	}
	for o=0,3 do
		local m = (i % 2 == o % 2) and -1 or 1
		set {
			134 + (o * .25),
			30 * m, 'skewy'..i,
			plr = 2,
		}
	end
	set {
		135,
		0, 'skewy'..i,
		plr = 2,
	}
end

set {
	135,
	7, 'jimble',
	plr = 2,
}
ease {
	135, 1, inCirc,
	0, 'jimble',
	plr = 2,
}

set {
	146,
	60, 'spiral',
	plr = 2,
}

ease {
	146, .5, outCirc,
	0, 'spiral',
	plr = 2,
}

set {
	146.5,
	30, 'bumpy',
	plr = 2,
}

ease {
	146.5, .5, outCirc,
	0, 'bumpy',
	plr = 2,
}

set {
	147,
	.25, 'tQuantize',
	plr = 2,
}
set {
	147.5,
	0, 'tQuantize',
	plr = 2,
}
for i=0,3 do	
	set {
		147,
		-.3, 'mini'..i..'X',
		-.3, 'mini'..i..'Y',
		plr = 2,
	}
	set {
		147.5,
		0, 'mini'..i..'X',
		0, 'mini'..i..'Y',
		plr = 2,
	}
end

set {
	149,
	2, 'jimble',
	plr = 2,
}

set {
	150,
	0, 'jimble',
	plr = 2,
}

set {
	151,
	5, 'jimble',
	plr = 2,
}

set {
	152,
	0, 'jimble',
	plr = 2,
}

set {
	167,
	0, 'bumpyPeriod',
	10, 'bumpy',
	plr = 2,
}
set {
	168,
	0, 'bumpy',
	5, 'bumpyPeriod'
}

for i=0,1 do
	set {
		171 + (i * .5),
		100, 'furiosity',
		plr = 2,
	}
	ease {
		171 + (i * .5), .5, outCubic,
		0, 'furiosity',
		plr = 2,
	}

end
for o=0,1 do
	ease {
		175, .5, outCubic,
		-180, 'confusion'..o,
		plr = 2,
	}
	ease {
		175.5, .5, outCubic,
		-360, 'confusion'..o,
		plr = 2,
	}
	set {
		176,
		0, 'confusion'..o,
		plr = 2,
	}
end

for i=0,1 do
	set {
		189 + (i * .5),
		50, 'transformY',
		plr = 1,
	}
	ease {
		189 + (i * .5), .5, outQuad,
		0, 'transformY',
		plr = 1,
	}
	set {
		190 + (i * .5),
		50, 'transformX',
		plr = 1,
	}
	ease {
		190 + (i * .5), .5, outQuad,
		0, 'transformX',
		plr = 1,
	}
end

for o=0,3 do
	ease {
		191, .5, outCirc,
		-60, 'transform'..o..'Y-aaa',
		centerOffset(o, 80), 'transform'..o..'X-aaa',
		180, 'confusion'..o,
		plr = 1,
	}
	ease {
		191.5, .5, inCirc,
		20, 'transform'..o..'Y-aaa',
		centerOffset(o, -50), 'transform'..o..'X-aaa',
		360 - 35, 'confusion'..o,
		plr = 1,
	}
	set {
		192,
		- 35, 'confusion'..o,
		plr = 1,
	}
	ease {
		192, .5, outCirc,
		0, 'transform'..o..'Y-aaa',
		0, 'transform'..o..'X-aaa',
		0, 'confusion'..o,
		plr = 1,
	}
end

local y = 0
local s = 0
for i=1,4.75,.25 do
	if math.floor(i - 1) % 2 == 0 then
		y = y + swagWidth
		s = s - .05
	else
		y = y - swagWidth
		s = s + .05
	end
	set {
		160 + (i - 1),
		y, 'transformY-a',
		s, 'miniX',
		s, 'miniY',
		plr = 2,
	}
	set {
		176 + (i - 1),
		y * .25, 'transformY-aa',
		s, 'miniX',
		s, 'miniY',
		plr = 1,
	}
end

set {
	192,
	--100, 'spiralperiod',
	1, 'furiositySpeed',
	.5, 'furiositySpread',
}

for i=0,1 do
	local plr = i == 0 and 2 or 1
	-- shuffle but cooler
	local b = 16 * i
	for o=0,1 do
		local b = b + (o * 4)
		print(b)
		for i=0,4 do
			local m = i % 2 == 0 and 1 or -1
			local b1 = 192 + b + (i * .25)
			local b2 = 192 + 1.5 + b + ((4 - i) * .25)
			local v1 = 30 * m
			local m1 = o == 0 and 'x' or 'y'
			local m2 = o == 0 and 'y' or 'x'
			for n=0,3 do
				local v2 = (o == 1) and splitOffset(n, 10 * (i + 1)) or (10 * (i + 1))
				ease {
					b1, .25, outBack,
					v1, m1..n,
					v2, m2..n,
				}
				ease {
					b2, .25, outBack,
					i == 0 and 0 or v1, m1..n,
					i == 0 and 0 or v2, m2..n,
				}
				for v=0,1 do
					local e = (v == 0) == (o == 0)
					local s = e and ((3 - n) * .1) or n * .1
					ease {
						b + (v * .5) + 195 - .25, .5, inBack,
						s, 'scalex'..n,
						s, 'scaley'..n,
						centerOffset(n, swagWidth * s), 'transform'..n..'X',
						e and -20 or 20, 'spiral',
					}
				end
				ease {
					196 + b, .25, outCirc,
					0, 'scalex'..n,
					0, 'scaley'..n,
					0, 'transform'..n..'X',
					0, 'spiral',
				}
			end
		end
	end
	
	-- fall guy
	local dist = (((60/140)*1000) / 4) * .45 * 2.5
	print(dist)
	local function fall(bb)
		ease {
			bb + b, .5, inSine,
			dist, 'transformY',
		}
		ease {
			bb + b + .5, .5, outSine,
			0, 'transformY',
		}
	end
	for i=0,1 do
		fall(205.5 + i)
	end
	for i=0,3 do
		fall(235.5 + i)
	end

	-- furiosity fast with other
	ease {
		200 + b - .5, .5, inQuad,
		60, 'furiosity',
	}
	ease {
		203.5 + b, .5, inQuad,
		0, 'furiosity',
	}
	for o=0,3 do
		for i=0,3.5,.5 do
			local m = ((i * 2) % 2 == o % 2) and -1 or 1
			local s = m * .1
			ease {
				i + 200 + b - .5, .5, inOutCirc,
				-s, 'mini'..o..'X',
				-s, 'mini'..o..'Y',
				centerOffset(o, swagWidth * s), 'x'..o,
				15 * m, 'spiral'..o,
			}
		end

		ease {
			204 + b, .5, outSine,
			0, 'mini'..o..'X',
			0, 'mini'..o..'Y',
			0, 'x'..o,
			0, 'spiral'..o,
		}
		-- spinning
		--[[
			x-a: offset for scaling to keep them next to each oither
			transformiX-a: offset for left and right movement
		]]
		
		ease {
			204 + b, .5, linear,
			-.2, 'scalex'..o..'-a',
			-.2, 'scaley'..o..'-a',
			centerOffset(o, swagWidth * -.2), 'x'..o..'-a',
		}
		ease {
			204 + b, .5, inSine,
			-50, 'transform'..o..'X-a',
		}
		ease {
			204.5 + b, .5, linear,
			-.4, 'scalex'..o..'-a',
			-.4, 'scaley'..o..'-a',
			centerOffset(o, swagWidth * -.4), 'x'..o..'-a',
		}
		ease {
			204.5 + b, 1, outSine,
			50, 'transform'..o..'X-a',
		}
		ease {
			205 + b, .5, linear,
			-.2, 'scalex'..o..'-a',
			-.2, 'scaley'..o..'-a',
			centerOffset(o, swagWidth * -.2), 'x'..o..'-a',
		}
		ease {
			205.5 + b, .5, linear,
			0, 'scalex'..o..'-a',
			0, 'scaley'..o..'-a',
			0, 'x'..o..'-a',
		}
		ease {
			205.5 + b, .5, inSine,
			0, 'transform'..o..'X-a',
		}
	end

	
	for o=0,3 do
		for i=0,3.5,.5 do
			local s = i * .08
			ease {
				224 + b + i, .5, outCubic,
				90 * i, 'angle'..o..'-a',
				s, 'scalex'..o..'-a',
				s, 'scaley'..o..'-a',
				centerOffset(o, swagWidth * s), 'x'..o..'-a',
				(i / 3.5) * 10, 'spiral'..o,
			}
		end
		ease {
			228 + b, .5, outBack,
			0, 'angle'..o..'-a',
			0, 'scalex'..o..'-a',
			0, 'scaley'..o..'-a',
		}
		ease {
			235 + b, 1, inCirc,
			0, 'spiral'..o,
		}

		ease {
			232 + b, .5, inCirc,
			0, 'x'..o..'-a',
			30, 'transform'..o..'Y-aa',
		}

		ease {
			232.5 + b, .5, outCirc,
			centerOffset(o, swagWidth * 3.5 * .08), 'x'..o..'-a',
			60, 'transform'..o..'Y-aa',
		}

		ease {
			233 + b, .5, outCubic,
			centerOffset(o, -30), 'x'..o..'-a',
			-30, 'transform'..o..'Y-aa',
			-180, 'angle'..o..'-a',
		}
		
		ease {
			b + 233.5, .5, inCubic,
			0, 'x'..o..'-a',
			0, 'transform'..o..'Y-aa',
			-360, 'angle'..o..'-a',
		}

		set {
			b + 234,
			0, 'angle'..o..'-a',
		}
	end

	-- spot the added at last minute part of the code
	for i=0,1 do
		ease {
			b + 234 + (i * .5), .25, outCubic,
			i == 0 and -20 or 20, 'x'..'-a',
		}
		ease {
			b + 234.25 + (i * .5), .25, outCubic,
			0, 'x'..'-a',
		}
	end

	--ease {
	--	235 + b, .5, 
	--}

	for i=0,3 do
		local m = i % 2 == 0 and -1 or 1
		ease {
			b + 228 - .5 + i, .5, outCubic,
			.25 * m, 'tipZ', 
		}
	end

	ease {
		235 + b, 1, inCirc,
		0, 'tipZ',
	}
end

innerBump(192, 205)
innerBump(208, 222)
innerBump(224, 236)
innerBump(240, 252)

outerBop(256, 287, true)