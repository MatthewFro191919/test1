-- i was asked to nerf certain parts of this modchart
-- the code for the "old" version as well as some new challenges
-- can be reactivated by setting this to true!
local hardMode = false

if not set or not ease or not add then
	print "Fun yayyyy"
	return
end

local toRad = math.pi / 180
local EIGHTH = .25 * .5
set {
	-5,
	5, 'pulseperiod',
	5, 'bumpyPeriod',
	16, 'jimbleSpread',
}

for o=0,3 do
	set {
		-5,
		centerOffset(o, 300), 'x'..o,
	}
	ease {
		0, 4, linear,
		0, 'x'..o,
	}
end

local function leftrighthi(from, to)
	for i=from,to do
		local m = i % 2 == 0 and -1 or 1
		for o=0,3 do
			set {
				i,
				centerOffset(o, swagWidth * .1), 'x'..o,
				i >= 36 and 50 * m or 0, 'x'..o..'-a',
				.1, 'scalex'..o,
				.1, 'scaley'..o,
			}
			ease {
				i, 1, outCubic,
				0, 'x'..o,
				0, 'x'..o..'-a',
				0, 'scalex'..o,
				0, 'scaley'..o,
			}
		end
	end
end
leftrighthi(4, 65)

ease {
	66.5, .25, outCubic,
	-.3, 'scalex0',
	-.3, 'scaley0',
	-45, 'angle0',
	plr = 1,
}

ease {
	66.75, .25, outCubic,
	-.3, 'scalex3',
	-.3, 'scaley3',
	45, 'angle3',
	plr = 1,
}

ease {
	67, 1, outCubic,
	0, 'scalex3',
	0, 'scaley3',
	0, 'scalex0',
	0, 'scaley0',
	0, 'angle0',
	0, 'angle3',
	math.pi * 2, 'localrotateY',
	plr = 1,
}
ease {
	67, .5, outCubic,
	-50, 'y',
}
ease {
	67.5, .5, inCubic,
	0, 'y',
}

local function notFormatBop(from, to)
	for i=from,to do
		for o=0,3 do
			local ofs = splitOffset(o, i % 2 == 0 and -1 or 1)
			local m = ofs * ((o > 0 and o < 3) and .5 or 1)
			local s = .25 * m
			ease {
				i, .5, outCubic,
				centerOffset(o, swagWidth * s), 'x'..o..'-aa',
				-30, 'y'..o..'-aa',
				s, 'scalex'..o..'-aa',
				s, 'scaley'..o..'-aa',
				centerOffset(o, ofs * 35 * .25), 'skewx'..o,
			}
			ease {
				i + .5, .5, inCubic,
				0, 'x'..o..'-aa',
				0, 'y'..o..'-aa',
				0, 'scalex'..o..'-aa',
				0, 'scaley'..o..'-aa',
				0, 'skewx'..o,
			}
		end
	end
end
notFormatBop(68, 99)
leftrighthi(68, 99)

for i=0,1 do
	local plr = i + 1
	local ofs = (i == 0) and 16 or 0
	ease {
		75 + ofs, .5, outBack,
		-15 * toRad, 'strumrotateZ',
		plr = plr,
	}
	ease {
		76 + ofs, .5, outBack,
		0, 'strumrotateZ',
		plr = plr,
	}
	ease {
		79 + ofs, .5, outBack,
		15 * toRad, 'strumrotateZ',
		plr = plr,
	}
	ease {
		80 + ofs, .5, outBack,
		0, 'strumrotateZ',
		plr = plr,
	}

	--for o=0,4 do
	--	set {
	--		108 + ofs + (.25 * o),
	--		.1 * o, 'tAccel',
	--		plr = plr,
	--	}
	--	ease {
	--		109.5 + ofs, 1, outCubic,
	--		0, 'tAccel',
	--		plr = plr,
	--	}
	--end
end

local function rotYBop(from, to)
	for i=from,to do
		if i % 2 == 0 then
			local m = i % 4 == 0 and -1 or 1
			ease {
				i - 2, 1, outCirc,
				m * 360 * toRad, 'localrotateY-a',
			}
			set {
				i,
				0, 'localrotateY-a',
			}
		else
			for o=0,3 do
				local b = i + (o * .25)
				set {
					b,
					.6, 'scalex'..o,
					.6, 'scaley'..o,
					(i % 4) == (o % 2) and -45 or 45, 'angle'..o,
				}
				ease {
					b, 1, outCubic,
					0, 'scalex'..o,
					0, 'scaley'..o,
					0, 'angle'..o,
				}
			end
		end
		ease {
			i, .5, outCubic,
			-20, 'y',
		}
		ease {
			i + .5, .5, inCubic,
			0, 'y',
		}
	end
end

rotYBop(100, 130)

-- oh boy

local toRad = math.pi / 180
local function jump(b, l, s, p)
	local ll = l * .5
	ease {
		b, ll, outCubic,
		s or -25, 'y',
		plr = p,
	}
	ease {
		b + ll, ll, inCubic,
		0, 'y',
		plr = p,
	}
end

local function ploopyJump(b, l, s, p)
	local ll = l * .5
	for o=0,3 do
		ease {
			b, ll, outCubic,
			s[o + 1], 'y'..o,
			s[o + 4 + 1] or 0, 'skewy'..o,
			plr = p,
		}
		ease {
			b + ll, ll, inCubic,
			0, 'y'..o,
			0, 'skewy'..o,
			plr = p,
		}
	end
end

local ok = false
local function lockPlayer(func, plr, beatOfs, noob)
	return function(p)
		p[1] = p[1] + beatOfs
		--print('locked', p[1])
		if not noob and p[1] >= 306 then
			if ok then
				print('no no', p[1])
			end
			return
		end
		p.plr = plr
		func(p)
	end
end

for p=0,1 do
	for h=0,1 do
		local bb = 144 * h
		-- first duo part
		do
			local plr = p + 1
			local ofs = bb + (p * 16)
			local ease = lockPlayer(ease, plr, ofs)
			local set = lockPlayer(set, plr, ofs)
			local j = jump
			local function jump(b, l, s)
				j(b + ofs, l, s, plr)
			end

			for z=0,1 do
				local beat = (z * 8)
				jump(beat + 132, 1)
				ease {
					beat + 133 - .25, .25, inCubic,
					-15 * toRad, 'strumrotateZ',
				}
				ease {
					beat + 133, .25, outCubic,
					0, 'strumrotateZ',
				}
				ease {
					beat + 133.25, .25, inCubic,
					15 * toRad, 'strumrotateZ',
				}
				ease {
					beat + 133.25 + .25, .25, outCubic,
					0, 'strumrotateZ',
				}
				jump(beat + 133.5, .5, -10)
				ease {
					beat + 133.5, .5, outCubic,
					360 * toRad, 'localrotateY',
				}
				set {
					beat + 133.5 + .5,
					0, 'localrotateY',
				}
				for i=1,3 do
					for o=0,3 do
						ease {
							beat + ((i == 3) and 134.75 or (134 + ((i - 1) * .25))), .05, linear,
							centerOffset(o, -15 * i), 'x'..o,
							5 * i, 'y'..o,
						}
					end
				end
				jump(beat + 135, 1, -30)
				for o=0,3 do
					ease {
						beat + 135, 1, outExpo,
						-360, 'angle'..o,
						0, 'x'..o,
						0, 'y'..o,
					}
					set {
						beat + 136,
						0, 'angle'..o,
					}
				end
			end
			for i=0,1 do
				jump(136 + i, 1)
				ease {
					136 + i, .5, outCubic,
					20 * toRad * (i == 0 and -1 or 1), 'strumrotateZ',
				}
				ease {
					136 + i + .5, .5, inCubic,
					0, 'strumrotateZ',
				}
				
				for o=0,3 do
					ease {
						138 + (i * .5), .5, outCubic,
						centerOffset(o, 20 * (i + 1)), 'x'..o,
					}
				end
			end

			for o=0,3 do
				ease {
					139, 1, outExpo,
					0, 'x'..o,
				}
			end
			ease {
				139, 1, outExpo,
				360 * 4 * toRad, 'localrotateY',
			}
			set {
				140,
				0, 'localrotateY',
			}

			ease {
				144, .5, outExpo,
				70, 'x',
				37 * toRad, 'strumrotateZ',
			}
			ease {
				144.5, .5, inExpo,
				0, 'x',
				0, 'strumrotateZ',
			}
			for o=0,3 do
				ease {
					145, .5, outExpo,
					-35, 'x'..o,
					-180, 'angle'..o,
				}
				ease {
					145.5, .5, outCubic,
					centerOffset(o, 50), 'x'..o,
					-50, 'y'..o,
					0, 'angle'..o,
				}
				ease {
					146 + (o * .25), .25, outBounce,
					25, 'y'..o,
				}
				ease {
					147, 1, outCubic,
					0, 'x'..o,
					0, 'y'..o,
				}
			end
			ease {
				147, 1, outExpo,
				360 * 4 * toRad, 'localrotateY',
			}
			set {
				148,
				0, 'localrotateY',
			}
		end
		-- first duo part but the other side
		do
			local plr = p + 1
			local ofs = bb + (p * -16)
			local ease = lockPlayer(ease, plr, ofs)
			local set = lockPlayer(set, plr, ofs)
			local j = jump
			local function jump(b, l, s)
				j(b + ofs, l, s, plr)
			end

			for b=0,3 do
				local beat = b * 4
				local m = (b % 2 == 0) and 1 or -1
				jump(beat + 148, 1, -50)
				ease {
					beat + 148, 1, linear,
					-40 * m, 'x',
				}
				ease {
					beat + 149, .25, outCubic,
					-30 * m, 'x',
					-30, 'y',
				}
				ease {
					beat + 149.25, .25, outCubic,
					-20 * m, 'x',
					30, 'y',
				}
				ease {
					beat + 149.5, .25, outCubic,
					-10 * m, 'x',
					-30, 'y',
				}
				ease {
					beat + 149.75, .25, outCubic,
					0, 'x',
					0, 'y',
				}
				for o=0,3 do
					ease {
						beat + 150, .5, outSine,
						centerOffset(o, 75), 'x'..o,
					}
					ease {
						beat + 150.5, .5, inSine,
						0, 'x'..o,
					}
					ease {
						beat + 150, 1, linear,
						100, 'y'..o,
					}
					ease {
						beat + 151, .5, outCubic,
						0, 'y'..o,
					}
				end
				ease {
					beat + 151, .5, outSine,
					360 * toRad, 'strumrotateX',
				}
				set {
					beat + 151 + .5,
					0, 'strumrotateX',
				}
			end
		end
	end
	-- first math part
	do
		local plr = p + 1
		local ease = lockPlayer(ease, plr, p * -8)
		local set = lockPlayer(set, plr, p * -8)
		local j = jump
		local function jump(b, l, s)
			j(b + (p * -8), l, s, plr)
		end
		local pj = ploopyJump
		local function ploopyJump(b, l, s)
			pj(b + (p * -8), l, s, plr)
		end

		jump(173, .5, -20)
		ease {
			173, .5, linear,
			-30, 'x',
		}
		
		jump(173.5, .25, -20)
		ease {
			173.5, .25, linear,
			-15, 'x',
		}
		jump(173.75, .25, -20)
		ease {
			173.75, .25, linear,
			0, 'x',
		}
		jump(174, 1, 30)
		ploopyJump(175, 1, {-15, -45, -35, -50, -15, 15, -15, 15})

		for i=0,1 do
			local m = (i == 0) and -1 or 1
			local b = (i * .75)
			ease {
				176 + b, .5, outQuint,
				m * 40, 'x',
				m * 15 * toRad, 'strumrotateX',
				m * 35 * toRad, 'strumrotateZ',
			}
			ease {
				176 + b + .5, .5, inQuint,
				0, 'x',
				0, 'strumrotateX',
				0, 'strumrotateZ',
			}
		end
		ease {
			177.5, .5, outQuint,
			15 * toRad, 'localrotateX',
		}
		ease {
			178, .5, inQuint,
			0, 'localrotateX',
		}
		ploopyJump(178, .5, {-10, -30, -25, -15})
		for i=0,1 do
			for o=0,3 do
				set {
					178.5 + (i * .25),
					centerOffset(o, 10 + (5 * i)), 'x'..o,
				}
			end
			local b = 179 + (i * .25)
			set {
				b,
				centerOffset(0, 15) - 10, 'x0',
			}
			ease {
				b, .25, outCubic,
				0, 'x0',
			}
		end	

		for o=0,3 do
			ease {
				179.5, .5, outSine,
				0, 'x'..o,
			}
		end

		ploopyJump(188, 1, {-25, -35, -30, -45})
		ease {
			188, 1, linear,
			100, 'x',
		}
		ploopyJump(189, 1, {-45, -30, -34, -25})
		ease {
			189, 1, linear,
			0, 'x',
		}
		
		for i=0,2 do
			local b = 190.5 + (i * .5)
			local m = (i % 2 == 0) and -1 or 1
			for o=0,3 do
				ease {
					b - .25, .25, inCirc,
					centerOffset(o, swagWidth * -.3), 'x'..o,
					m * -45 * toRad, 'strumrotateZ'..o,
					-.3, 'scalex'..o,
					-.3, 'scaley'..o,
				}
				ease {
					b, .25, outCirc,
					0, 'x'..o,
					0, 'strumrotateZ'..o,
					0, 'scalex'..o,
					0, 'scaley'..o,
				}
			end
		end

		ploopyJump(192.5, .25, {3 * 3, 7 * 3, 10 * 3, 25 * 3})
		ploopyJump(192.75, .25, {5 * 3, 9 * 3, 15 * 3, 35 * 3})

		for i=0,3 do
			local m = (i % 2 == 0) and -1 or 1
			jump(193 + i, 1)
			ease {
				193 + i, .5, outCubic,
				25 * m * toRad, 'strumrotateZ',
				40 * m, 'x',
			}
			ease {
				193 + i + .5, .5, inCubic,
				0, 'strumrotateZ',
				0, 'x',
			}
		end
	end
end

-- cuble final before 3d
ease {
	188, 1.5, outCubic,
	-40, 'y',
	plr = 2,
}

ease {
	188, 1.5, linear,
	50, 'x',
	plr = 2,
}

ease {
	188 + 1.5, 1, inCubic,
	-20, 'y',
	-swagWidth * 6, 'x',
	plr = 2,
}

ease {
	188, 2.25, inExpo,
	-90 * toRad, 'strumrotateZ',
	plr = 2,
}


-- bf final before 3d
ease {
	196, 4, linear,
	360 * 2, 'localrotateY',
	plr = 1,
}

reset {200}
for p=1,2 do
	for o=0,3 do
		local n = (p == 1) and 3 - o or o
		set {
			200.01,
			90 * toRad, 'localrotateX'..n,
			500, 'y'..n,
			plr = p,
		}
	
		ease {
			210 + (o * .5), .75, inCubic,
			0, 'localrotateX'..n,
			0, 'y'..n,
			plr = p,
		}
	end
end

for p=1,2 do
	ease {
		210.5, 1.5, linear,
		25, 'furiosity',
		1, 'furiositySpread',
		(p ~= 2 or flashingLights) and 15 * toRad or 0, 'strumwavyY',
		.5 / 115.384, 'strumwavyperiodY',
		plr = p,
	}
end
-- bop based on furiosity but actually ended up looking more like cuberoot lol
local ofs = 0
local function classicCuberoot(from, to)
	for beat=from,to do
		ofs = ofs + 2
		ease {
			beat, 1, outCubic,
			ofs, 'furiosityOffset',
		}
	end
end
classicCuberoot(212, 228)
classicCuberoot(240, 260)
classicCuberoot(272, 276)
ease {
	276, .5, linear,
	15, 'furiosity',
}
set {
	306,
	0, 'furiosity',
	0, 'strumwavyY',
}

local THIRD = 1/3
for i=0,1 do
	local plr = i + 1
	local m = (i % 2 == 0) and -1 or 1
	local b = i * -32
	local ease = lockPlayer(ease, plr, b, true)
	local set = lockPlayer(set, plr, b, true)
	local add = lockPlayer(add, plr, b, true)
	local l = 8 - (THIRD * 2)
	for i=0,7 do
		ease {
			260 + i - .5, .5, inCubic,
			.5, 'tAccel',
		}
		ease {
			260 + i, .5, outCubic,
			0, 'tAccel',
		}
	end
	for o=0,2 do
		add {
			254 + (o * .25),
			-10, 'x',
		}
	end

	jump(255 + b, .75, -25, plr)
	ease {
		255, .75, linear,
		0, 'x',
	}
	ease {
		255, .75, outCubic,
		360, 'angle',
	}
	set {
		255 + .75,
		0, 'angle',
	}
	for o=0,3 do
		local b = o * (THIRD / 2)
		ease {
			260 + b, 2, outSine,
			-15 * toRad, 'localrotateX'..o,
			-25 * toRad * m, 'localrotateY'..o,
			-5 * toRad, 'localrotateZ'..o,
		}
		ease {
			262 + b, 2, outSine,
			35 * toRad, 'localrotateX'..o,
			-35 * toRad * m, 'localrotateY'..o,
			15 * toRad, 'localrotateZ'..o,
		}
		ease {
			264 + b, 2, outSine,
			20 * toRad, 'localrotateX'..o,
			35 * toRad * m, 'localrotateY'..o,
			-20 * toRad, 'localrotateZ'..o,
		}
		ease {
			266 + b, 2, outSine,
			-45 * toRad, 'localrotateX'..o,
			0, 'localrotateY'..o,
			0, 'localrotateZ'..o,
		}
		ease {
			268 + b, .5, outCubic,
			0, 'localrotateX'..o,
		}
	end
	ease {
		268, .5, outExpo,
		2, 'otherfuriosityOffset',
	}
	ease {
		268.5, .5, outExpo,
		4, 'otherfuriosityOffset',
	}
	ease {
		269, 1, linear,
		-16, 'otherfuriosityOffset',
	}
end

ease {
	306, .5, outCubic,
	-90, 'y',
	plr = 2,
}

ease {
	306.5, .5, inCubic,
	720, 'y',
	plr = 2,
}

ease {
	306, 1, linear,
	100, 'x',
	67 * toRad, 'localrotateX',
	25 * toRad, 'localrotateY',
	-35 * toRad, 'localrotateZ',
	plr = 2,
}

reset {308}
set {
	308,
	720, 'y',
	plr = 2,
}

ease {
	308, 1, outExpo,
	0, 'y',
	plr = 2,
}

local function jimbleBop(from, to)
	for beat=from,to do
		local t = lerp(.75, 1, inExpo((beat - from) / (to - from)))
		--print(t)
		set {
			beat,
			t, 'jimble',
		}
		ease {
			beat, .5, outCubic,
			.5, 'jimble',
		}
	end
end

jimbleBop(308, 403)

local function jimbleIntro(from, to, plr)
	for b=from,to,8 do
		if b < 338 or plr then
			for o=0,3 do
				local s = (3 - o) * .1
				ease {
					b - .25, .25, inExpo,
					s, 'scalex'..o..'-a',
					s, 'scaley'..o..'-a',
					plr = plr,
				}

				ease {
					b + 1.5, .25, outElastic,
					0, 'scalex'..o..'-a',
					0, 'scaley'..o..'-a',
					plr = plr,
				}

				ease {
					b + 1.75, .25, outElastic,
					-s, 'scalex'..o..'-a',
					-s, 'scaley'..o..'-a',
					plr = plr,
				}

				ease {
					b + 2, .5, outExpo,
					0, 'scalex'..o..'-a',
					0, 'scaley'..o..'-a',
					centerOffset(o, 50), 'x'..o,
					360, 'angle'..o,
					plr = plr,
				}

				ease {
					b + 2.5, .5, outExpo,
					0, 'x'..o,
					0, 'angle'..o,
					plr = plr,
				}

				local r = centerOffset(o, 15) * toRad
				ease {
					b + 3.5, 1, outExpo,
					r, 'strumrotateX'..o,
					plr = plr,
				}
				ease {
					b + 4.5, 1, outExpo,
					-r, 'strumrotateX'..o,
					plr = plr,
				}

				set {
					b + 5.5,
					-r * .5, 'strumrotateX'..o,
					plr = plr,
				}
				set {
					b + 5.75,
					0, 'strumrotateX'..o,
					plr = plr,
				}

				ease {
					b + 6, .75, outExpo,
					centerOffset(o, 30), 'strumrx'..o,
					plr = plr,
				}

				ease {
					b + 6.75, .75, outExpo,
					centerOffset(o, 50), 'strumrx'..o,
					plr = plr,
				}

				ease {
					b + 6.75 + .75, .5, outExpo,
					centerOffset(o, 80), 'strumrx'..o,
					plr = plr,
				}
				ease {
					b + 8, .5, outExpo,
					0, 'strumrx'..o,
					plr = plr,
				}
			end
		end
	end
end

jimbleIntro(308, 339)
jimbleIntro(340, 340 + 8, 1)
jimbleIntro(356, 356 + 8, 2)
jimbleIntro(372, 372, 1)
jimbleIntro(380, 380, 2)

ease {
	315, .5, outElastic,
	-45 * toRad, 'strumrotateZ',
	plr = 2,
}
ease {
	315.5, .5, outElastic,
	45 * toRad, 'strumrotateZ',
	plr = 2,
}
ease {
	316, 1, outExpo,
	0, 'strumrotateZ',
	plr = 2,
}

ease {
	323, .5, inOutCubic,
	45 * toRad, 'strumrotateZ',
	plr = 1,
}
ease {
	323.5, .5, inOutCubic,
	-45 * toRad, 'strumrotateZ',
	plr = 1,
}
ease {
	324, .5, outElastic,
	0, 'strumrotateZ',
	plr = 1,
}

ease {
	330, 1, linear,
	360, 'strumrotateY',
	plr = 2,
}
set {
	331, 
	0, 'strumrotateY',
	plr = 2,
}

for o=0,3 do
	for i=0,1 do
		local s = .25 + (i * .25)
		ease {
			331 + (i * .5), .5, outCubic,
			s, 'scalex'..o,
			-s, 'scaley'..o,
			centerOffset(o, swagWidth * s), 'x'..o,
			plr = 2,
		}
	end
	ease {
		332, 6, linear,
		0, 'scalex'..o,
		0, 'scaley'..o,
		0, 'x'..o,
		plr = 2
	}
end

for i=0,1 do
	local b = 335.5 + (i * .25)
	set {
		b,
		50, 'x',
		plr = 1,
	}
	set {
		b + EIGHTH,
		-50, 'x',
		plr = 1,
	}
end
set {
	336,
	0, 'x',
	plr = 1,
}

for o=0,3 do
	ease {
		337.5, .5, inElastic,
		.5, 'scalex'..o,
		-.5, 'scaley'..o,
		centerOffset(o, swagWidth * .5), 'strumrx'..o,
		swagWidth * .5, 'y'..o,
		plr = 1,
	}
	ease {
		338, .5, outBack,
		-.5, 'scalex'..o,
		.5, 'scaley'..o,
		plr = 1,
	}
	ease {
		338, .5, linear,
		centerOffset(o, swagWidth * -.5) + 40, 'strumrx'..o,
		plr = 1,
	}
	ease {
		338, .5, outSine,
		35 * toRad, 'strumrotateZ'..o,
		35, 'angle'..o,
		-15 * toRad, 'strumrotateY'..o,
		-70, 'y'..o,
		plr = 1,
	}
	ease {
		338.5, 1, linear,
		0, 'strumrx'..o,
		plr = 1,
	}
	ease {
		338.5, .5, inSine,
		-15 * toRad, 'strumrotateZ'..o,
		-15, 'angle'..o,
		5 * toRad, 'strumrotateY'..o,
		50, 'y'..o,
		0, 'scalex'..o,
		0, 'scaley'..o,
		plr = 1,
	}
	ease {
		339, .5, outSine,
		0, 'strumrotateZ'..o,
		0, 'strumrotateY'..o,
		0, 'y'..o,
		plr = 1,
	}
	ease {
		339, .5, inElastic,
		.25, 'scalex'..o,
		-.25, 'scaley'..o,
		centerOffset(o, swagWidth * .25), 'x'..o..'-a',
		swagWidth * .25, 'y'..o..'-a',
		plr = 1,
	}
	ease {
		339.5, .5, outCubic,
		360, 'angle'..o,
		-50, 'y'..o..'-a',
		-.25, 'scalex'..o,
		.25, 'scaley'..o,
		centerOffset(o, swagWidth * -.25), 'x'..o..'-a',
		plr = 1,
	}
	ease {
		340, .5, inCubic,
		0, 'x'..o..'-a',
		0, 'y'..o..'-a',
		0, 'scalex'..o,
		0, 'scaley'..o,
		plr = 1,
	}
	set {
		340,
		0, 'angle'..o,
		plr = 1,
	}
	ease {
		340, 2.5, outCubic,
		360 * 2 * toRad, 'localrotateY'..o,
		plr = 1,
	}
	set {
		342.5,
		0, 'localrotateY'..o,
		plr = 1,
	}
end

local function funJump(beat, plr, scale, angle, introSquish, fallSquish)
	for o=0,3 do
		if introSquish then
			ease {
				beat - .25, .25, inElastic,
				scale, 'scalex'..o,
				-scale, 'scaley'..o,
				swagWidth * scale, 'y'..o,
				plr = plr,
			}
		end
		ease {
			beat, .25, outCubic,
			-scale, 'scalex'..o,
			scale, 'scaley'..o,
			plr = plr,
		}
		if fallSquish then
			ease {
				beat + .25, .75, inCubic,
				scale * .25, 'scalex'..o,
				-scale * .25, 'scaley'..o,
				swagWidth * (scale * .25), 'y'..o..'-a',
				plr = plr,
			}
			ease {
				beat + 1, .25, outCubic,
				0, 'scalex'..o,
				0, 'scaley'..o,
				0, 'y'..o..'-a',
				plr = plr,
			}
		end
		ease {
			beat, .5, outCubic,
			angle * toRad, 'strumrotateZ'..o,
			angle, 'angle'..o,
			-50 + math.random(-15, 15), 'y'..o,
			plr = plr,
		}
		ease {
			beat + .5, .5, inCubic,
			0, 'angle'..o,
			0, 'y'..o,
			0, 'strumrotateZ'..o,
			plr = plr,
		}
		if not fallSquish then
			ease {
				beat + .5, .5, inCubic,
				0, 'scalex'..o,
				0, 'scaley'..o,
				plr = plr,
			}
		end
	end
end

ok = true
for p=0,1 do
	local plr = p + 1
	local ofs = (p == 0) and 16 or 0
	local easy = p == 0 and not hardMode
	print(easy)
	local s = easy and .1 or .5
	print(s)
	funJump(340 + ofs, plr, s, easy and 5 or 15, true)
	funJump(341 + ofs, plr, s, easy and -10 or -35, false, true)
	
	local y = easy and 50 or 150
	local function fall(b, l, m)
		ease {
			b + ofs, l, linear,
			y * (l/.5), m or 'y',
			plr = plr,
		}
	end
	local function dumb(p1, p2)
		local num = (p == 0) and p1 or p2
		if easy then
			return num * .25
		end
		return num
	end
	set {
		342 + ofs,
		20 * toRad, 'localrotateX',
		dumb(-40, 40) * toRad, 'localrotateY',
		dumb(-70, 70) * toRad, 'localrotateZ',
		dumb(-70, 70), 'angle',
		plr = plr,
	}
	fall(342, .5)
	local a = easy and -15 or -60
	set {
		342.5 + ofs,
		34 * toRad, 'localrotateX',
		(easy and 15 or 56) * toRad, 'localrotateY',
		a * toRad, 'localrotateZ',
		a, 'angle',
		0, 'y',
		plr = plr,
	}
	set {
		343 + ofs,
		0, 'localrotateX',
		0, 'localrotateY',
		0, 'localrotateZ',
		0, 'angle',
		0, 'y',
		plr = plr,
	}
	for o=0,3 do
		for i=0,1 do
			local s = -(.25 * (i + 1))
			set {
				343 + (.25 * i) + ofs,
				s, 'scalex'..o..'-a',
				s, 'scaley'..o..'-a',
				centerOffset(o, swagWidth * s), 'x'..o,
				plr = plr,
			}
		end
		ease {
			ofs + 343.5, .5, outCubic,
			.2, 'scalex'..o..'-a',
			.2, 'scaley'..o..'-a',
			0, 'x'..o,
			plr = plr,
		}
		ease {
			ofs + 344, .5, inCubic,
			0, 'scalex'..o..'-a',
			0, 'scaley'..o..'-a',
			plr = plr,
		}
	end
	fall(342.5, .5)
	funJump(344 + ofs, plr, s, easy and -15 or -40, true)
	funJump(345 + ofs, plr, s, easy and 20 or 60, false, true)

	for o=0,3 do
		set {
			ofs + 346,
			35 * toRad, 'localrotateX'..o,
			15 * toRad, 'localrotateY'..o,
			2 * toRad, 'localrotateZ'..o,
			2, 'angle'..o,
			plr = plr,
		}
		fall(346, .5, 'y'..o)
		set {
			ofs + 346.5,
			60 * toRad, 'localrotateX'..o,
			dumb(40, -40) * toRad, 'localrotateY'..o,
			-2 * toRad, 'localrotateZ'..o,
			-2, 'angle'..o,
			0, 'y'..o,
			plr = plr,
		}
		fall(346.5, .5, 'y'..o)
		set {
			ofs + 347,
			120 * toRad, 'localrotateX'..o,
			dumb(30, -30) * toRad, 'localrotateY'..o,
			2 * toRad, 'localrotateZ'..o,
			-2, 'angle'..o,
			0, 'y'..o,
			plr = plr,
		}
		fall(347, .25, 'y'..o)
		set {
			ofs + 347.25,
			160 * toRad, 'localrotateX'..o,
			15 * toRad, 'localrotateY'..o,
			-2 * toRad, 'localrotateZ'..o,
			2, 'angle'..o,
			0, 'y'..o,
			plr = plr,
		}
		fall(347.25, .25, 'y'..o)
		set {
			ofs + 347.5,
			180 * toRad, 'localrotateX'..o,
			0, 'localrotateY'..o,
			0, 'localrotateZ'..o,
			0, 'angle',
			0, 'y'..o,
			plr = plr,
		}
		ease {
			ofs + 347.5, .5, linear,
			-150, 'y'..o..'-a',
			plr = plr,
		}
		ease {
			ofs + 348, .5, outCubic,
			0, 'y'..o..'-a',
		}
		ease {
			350 + ofs, 1, linear,
			easy and 360 * toRad or 0, 'localrotateX'..o,
			plr = plr,
		}
		ease {
			350 + ofs, .5, linear,
			dumb(.5, -.75), 'localrotateY'..o,
			plr = plr,
		}
		ease {
			350 + ofs + .5, .5, linear,
			0, 'localrotateY'..o,
			plr = plr,
		}

		set {
			352 + ofs,
			centerOffset(o, -50), 'y'..o,
			plr = plr,
		}
		set {
			352.5 + ofs,
			centerOffset(o, 25), 'x'..o,
			0, 'y'..o,
			plr = plr,
		}
		set {
			352.75 + ofs,
			centerOffset(o, 50), 'x'..o,
			0, 'y'..o,
			plr = plr,
		}
		ease {
			353 + ofs, .5, outBack,
			0, 'x'..o,
			360, 'angle'..o,
			plr = plr
		}
		set {
			353 + ofs + .5,
			0, 'angle'..o,
			plr = plr,
		}
		if not easy then
			ease {
				353.5 + ofs, .5, linear,
				360 * toRad, 'strumrotateY'..o,
				plr = plr,
			}
		end
		set {
			353.5 + ofs,
			0, 'strumrotateY'..o,
		}
		ease {
			354 + ofs + (.1 * o), .5, outCubic,
			-15 * toRad, 'strumrotateZ'..o,
			plr = plr,
		}
		ease {
			354.75 + ofs + (.1 * o), .5, outCubic,
			15 * toRad, 'strumrotateZ'..o,
			plr = plr,
		}
		ease {
			355 + ofs, .5, outCubic,
			30 * toRad, 'strumrotateX'..o,
			plr = plr,
		}
		ease {
			355.5 + ofs, .5, outCubic,
			0, 'strumrotateX'..o,
			0, 'strumrotateZ'..o,
			plr = plr,
		}
	end
	funJump(348 + ofs, plr, s, dumb(40, 15), true)
	funJump(349 + ofs, plr, s, dumb(-15, -40), false, true)
end

ease {
	358, 3, linear,
	30 * toRad, 'localrotateX',
	-25 * toRad, 'localrotateY',
	5 * toRad, 'localrotateZ',
	plr = 2,
}

ease {
	362.5, 1, linear,
	-5 * toRad, 'localrotateX',
	60 * toRad, 'localrotateY',
	-25 * toRad, 'localrotateZ',
	plr = 2,
}

ease {
	365, 3, linear,
	0, 'localrotateX',
	0, 'localrotateY',
	0, 'localrotateZ',
	plr = 2,
}

set {
	368,
	180 * toRad, 'localrotateX',
	180 * toRad, 'localrotateY',
	plr = 2,
}

set {
	368.5,
	0, 'localrotateX',
	plr = 2,
}

set {
	369,
	180 * toRad, 'localrotateX',
	0, 'localrotateY',
	plr = 2,
}

set {
	369.5,
	0, 'localrotateX',
	plr = 2,
}

for i=0,3 do
	set {
		370 + (i * .5),
		((i % 2 == 0) and 180 or 0) * toRad, 'localrotateY',
		plr = 2,
	}
end

for p=0,1 do
	local plr = p + 1
	local ofs = (p == 0) and 8 or 0
	local s = easy and -.025 or -.1
	local easy = p == 0 and not hardMode
	local angang = easy and 15 or 35
	for o=0,2 do
		s = s - (easy and .025 or .1)
		for n=0,3 do
			ease {
				ofs + 372 + (o), 1, outElastic,
				toRad * ((o % 2 == 0) and -angang or angang), 'strumrotateY'..n,
				s, 'scalex'..n,
				s, 'scaley'..n,
				centerOffset(n, swagWidth * s), 'strumrx'..n,
				(not flashingLights and plr == 2) and 0 or (5 * o) * toRad, 'strumwavyX'..n,
				plr = plr,
			}
		end
	end
	for o=0,3 do
		set {
			372,
			100 * o, 'strumwavyoffsetX'..o,
			1 / 100, 'strumwavyperiodX'..o,
			plr = plr,
		}
		ease {
			ofs + 375, 1, linear,
			0, 'strumrotateY'..o,
			0, 'scalex'..o,
			0, 'scaley'..o,
			0, 'strumrx'..o,
			plr = plr,
		}
	end
	ease {
		ofs + 375, .25, outCubic,
		-30, 'y',
		plr = plr,
	}
	ease {
		ofs + 375.25, .25, inCubic,
		0, 'y',
		plr = plr,
	}
	ease {
		ofs + 375.5, .25, outCubic,
		-60, 'y',
		plr = plr,
	}
	ease {
		ofs + 375.75, .25, inCubic,
		0, 'y',
		plr = plr,
	}
	ease {
		ofs + 376, .5, outCubic,
		-15, 'y',
		-5 * toRad, 'strumrotateZ',
		-5, 'angle',
		plr = plr,
	}
	local anger = easy and 15 or 45
	ease {
		ofs + 376.5, .5, inCubic,
		easy and 100 or 250, 'y',
		anger * toRad, 'strumrotateZ',
		anger, 'angle',
		plr = plr,
	}
	ease {
		ofs + 377, .5, outBack,
		0, 'y',
		0, 'strumrotateZ',
		0, 'angle',
		plr = plr,
	}

	local seven = easy and 2.5 or 7.5
	for o=0,3 do
		for i=0,1 do
			set {
				377.5 + (i * .25) + ofs,
				centerOffset(o, seven + (seven * i)) * toRad, 'strumrotateZ'..o,
				plr = plr,
			}
		end
		for i=0,3 do
			local s = -.1 * (i + 1)
			ease {
				ofs + 378 + (i * .25), .25, outCubic,
				toRad * ((i % 2 == 0) and -15 or 15), 'strumrotateZ'..o..'-a',
				s, 'scalex'..o,
				s, 'scaley'..o,
				centerOffset(o, s * swagWidth), 'strumrx'..o,
				plr = plr,
			}
		end

		ease {
			ofs + 379, .5, outBack,
			-.2, 'scalex'..o,
			-.2, 'scaley'..o,
			centerOffset(o, -.2 * swagWidth), 'strumrx'..o,
			0, 'strumrotateZ'..o..'-a',
			centerOffset(o, 3.5) * toRad, 'strumrotateZ'..o,
			plr = plr,
		}
		ease {
			ofs + 379.5, .5, outBack,
			.2, 'scalex'..o,
			.2, 'scaley'..o,
			0, 'strumrx'..o,
			0, 'strumrotateZ'..o,
			plr = plr,
		}
		ease {
			ofs + 380, 1, outCubic,
			0, 'scalex'..o,
			0, 'scaley'..o,
		}
	end

	local lmao = easy and 15 or 45
	for i=0,1 do
		set {
			ofs + 388 + (i * .5),
			lmao * toRad * ((i % 2 == 0) and -1 or 1), 'localrotateX',
			plr = plr,
		}
		set {
			ofs + 388.25 + (i * .5),
			0, 'localrotateX',
			plr = plr,
		}
	end
	for o=0,3 do
		set {
			ofs + 389.25,
			centerOffset(o, 50), 'x'..o,
			plr = plr,
		}
		set {
			ofs + 389.5,
			centerOffset(o, 25), 'x'..o,
			plr = plr,
		}
		set {
			ofs + 389.75,
			0, 'x'..o,
			plr = plr,
		}
	end
	set {
		ofs + 390,
		-lmao * toRad, 'strumrotateZ',
		plr = plr,
	}
	set {
		ofs + 390.25,
		-lmao * toRad * .5, 'strumrotateZ',
		plr = plr,
	}
	set {
		ofs + 390.5,
		0, 'strumrotateZ',
		plr = plr,
	}
	local t = {-5, -.25, -.25, -5}
	for o=0,3 do
		set {
			ofs + 173.99,
			t[o], 'strumrz',
		}
	end
	if not easy then
		ease {
			ofs + 391, 1, linear,
			-360 * toRad, 'localrotateX',
			plr = plr,
		}
		set {
			ofs + 391 + 1,
			0, 'localrotateX',
		}
	end
	for o=0,3 do
		ease {
			ofs + 392, .75, outBack,
			centerOffset(o, -.1), 'z'..o,
			plr = plr,
		}
		ease {
			ofs + 392 + .75, .75, outBack,
			centerOffset(o, .1), 'z'..o,
			plr = plr,
		}
		ease {
			ofs + 393.5, .5, outCirc,
			0, 'z'..o,
			plr = plr,
		}
		for i=0,3 do
			set {
				ofs + 394.5 + EIGHTH + (EIGHTH * i),
				.05 * (i % 2 == 0 and -1 or 1), 'tornadoz',
				plr = plr,
			}
		end
		set {
			395 + EIGHTH,
			0, 'tornadoz',
			plr = plr,
		}
		for o=0,3 do
			--print(o, plr)
			ease {
				395.5, .25, linear,
				.5 * (o % 2 == 0 and -1 or 1), 'beatz'..o,
				plr = 2,
			}	
		end
	end
end
ease {
	379.5, .5, inCubic,
	.25, 'z',
	plr = 1,
}
ease {
	380, .5, outCubic,
	0, 'z',
	plr = 1,
}

for o=0,3 do
	local s = -.5
	ease {
		402, 2, inExpo,
		centerOffset(o, swagWidth * s), 'strumrx'..o,
		s, 'scalex'..o,
		s, 'scaley'..o,
		360 * toRad, 'strumrotateY'..o,
		plr = 2,
	}
	set {
		404,
		0, 'strumrotateY'..o,
		plr = 2,
	}
	ease {
		404, 1, outBack,
		0, 'strumrx'..o,
		.5, 'scalex'..o,
		.5, 'scaley'..o,
		-15 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	set {
		404.75,
		.1 * (o % 2 == 0 and -1 or 1), 'beatz'..o,
		plr = 2,
	}
	set {
		405,
		0, 'scalex'..o,
		0, 'scaley'..o,
		5 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	local a = {-300, -23, 200, 370}
	set {
		405.25,
		a[o + 1], 'strumrx'..o,
		-5 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	local a = {-10, -300, 400, 10}
	set {
		405.5,
		a[o + 1], 'strumrx'..o,
		5 * toRad, 'strumrotateZ'..o,
		.3, 'scalex'..o,
		.3, 'scaley'..o,
		plr = 2,
	}
	local a = {-100, 100, -200, 100}
	set {
		405.75,
		a[o + 1], 'strumrx'..o,
		-5 * toRad, 'strumrotateZ'..o,
		.5, 'scalex'..o,
		.5, 'scaley'..o,
		plr = 2,
	}
	ease {
		406.25, .5, outCubic,
		0, 'strumrx'..o,
		-300, 'x'..o,
		100, 'y'..o,
		10 * toRad, 'strumrotateZ'..o,
		0, 'scalex'..o,
		0, 'scaley'..o,
		plr = 2,
	}
	set {
		406.75,
		-10 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	ease {
		407, .5, outCubic,
		0, 'x'..o,
		0, 'strumrotateZ'..o,
		plr = 2,
	}
	ease {
		407.5, .5, outCubic,
		10 * toRad, 'strumrotateZ'..o,
		300, 'x'..o,
		plr = 2,
	}
	local s = -.4
	set {
		408,
		0, 'strumrotateY'..o,
	}
	ease {
		408, .25, outSine,
		s, 'scalex'..o,
		s, 'scaley'..o,
		centerOffset(o, swagWidth * s), 'strumrx'..o,
		plr = 2,
	}
	ease {
		408.25, .25, inSine,
		0, 'scalex'..o,
		0, 'scaley'..o,
		0, 'strumrx'..o,
		plr = 2,
	}
	ease {
		408, .5, linear,
		0, 'x'..o,
		5 * toRad, 'strumrotateZ'..o,
		360 * toRad, 'strumrotateY'..o,
		plr = 2,
	}
	set {
		408.5,
		15 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	set {
		408.75,
		25 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	ease {
		409, .5, linear,
		0, 'strumrotateZ'..o,
		180 * toRad, 'strumrotateY'..o,
		plr = 2,
	}
	ease {
		409.75, .5, linear,
		0, 'strumrotateY'..o,
		centerOffset(o, -250), 'strumrx'..o..'-a',
		math.random(-25, 25), 'x'..o..'-a',
		math.random(-100, 100), 'y'..o..'-a',
		math.random(-360, 360), 'angle'..o..'-a',
		plr = 2,
	}
	ease {
		410.5, .5, linear,
		5, 'jimble',
		plr = 2,
	}
	set {
		411,
		0, 'jimble',
		plr = 2,
	}
	ease {
		411, 1, inExpo,
		800, 'y'..o,
		plr = 2,
	}
	set {
		412,
		0, 'strumrx'..o..'-a',
		0, 'x'..o..'-a',
		0, 'y'..o..'-a',
		0, 'angle'..o..'-a',
		1, 'jimble',
		plr = 2,
	}
	ease {
		412 + (o * .25), .5, outCubic,
		-25, 'y'..o,
		plr = 2,
	}
	ease {
		412 + (o * .25) + .5, .5, inCubic,
		0, 'y'..o,
		plr = 2,
	}
	local s = .25
	ease {
		413, .5, outBack,
		centerOffset(o, swagWidth * s), 'x'..o,
		s, 'scalex'..o,
		s, 'scaley'..o,
		-25 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	local s = .5
	ease {
		413.5, .5, outBack,
		centerOffset(o, swagWidth * s), 'x'..o,
		s, 'scalex'..o,
		s, 'scaley'..o,
		25 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	ease {
		414, 1, outSine,
		centerOffset(o, swagWidth * 2), 'x'..o,
		0, 'scalex'..o,
		0, 'scaley'..o,
		0, 'strumrotateZ'..o,
		plr = 2,
	}
	
	ease {
		416, .5, outBack,
		5 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}

	ease {
		416.5, .25, outElastic,
		0, 'x'..o,
		plr = 2,
	}
	
	ease {
		416, .5, outBack,
		-5 * toRad, 'strumrotateZ'..o,
		plr = 2,
	}
	
	ease {
		416.5, .5, outBack,
		0, 'strumrotateZ'..o,
		plr = 2,
	}
end

ease {
	404, 1, outBack,
	.5, 'opponentSwap',
	plr = 2,
}

ease {
	404, 1, outBack,
	-.25, 'opponentSwap',
	-1, 'z',
	15 * toRad, 'strumrotateZ',
	15, 'angle',
	--.5, 'darkness',
	plr = 1,
}
ease {
	414, 1, outSine,
	100, 'furiosity',
	plr = 2,
}
ease {
	416, .5, outBack,
	0, 'furiosity',
	5, 'drunk',
	plr = 2,
}
ease {
	417.5, .5, linear,
	0, 'drunk',
	plr = 2,
}
if flashingLights then
	ease {
		418, .75, linear,
		50 * toRad, 'strumspiralX',
		500, 'strumspiralperiodX',
		plr = 2,
	}
end
ease {
	418 + .75, .75, linear,
	flashingLights and -50 * toRad or 0, 'strumspiralX',
	0, 'opponentSwap',
	plr = 2,
}
ease {
	418 + .75, .75, linear,
	0, 'opponentSwap',
	0, 'z',
	0, 'angle',
	0, 'strumrotateZ',
	plr = 1,
}
for o=0,3 do
	ease {
		420, 5 * .25, outExpo,
		300, 'x'..o,
		300, 'y'..o,
		plr = 2,
	}
	for p=1,2 do
		local easy = p == 1 and not hardMode
		local s = easy and -.4 or -.8
		local xa = easy and -30 or -60
		local za = easy and -15 or -45
		ease {
			420, 5 * .25, outExpo,
			s, 'scalex'..o..'-aa',
			s, 'scaley'..o..'-aa',
			centerOffset(o, swagWidth * s), 'localrx'..o..'-aa',
			za * toRad, 'localrotateZ'..o..'-aa',
			xa * toRad, 'strumrotateX'..o..'-aa',
			za, 'angle'..o..'-aa',
			plr = p,
		}
		local m = (o % 2 == 0 and -1 or 1)
		ease {
			420 + (5 * .25), (5 * .25), inOutCubic,
			0, 'scalex'..o..'-aa',
			0, 'scaley'..o..'-aa',
			0, 'localrx'..o..'-aa',
			0, 'localrotateZ'..o..'-aa',
			0, 'strumrotateX'..o..'-aa',
			0, 'angle'..o..'-aa',
			(easy and .1 or .25) * m, 'beatz'..o,
			(easy and 1 or 5) * m * toRad, 'strumwavyZ'..o,
			1 / 200, 'strumwavyperiodZ',
			plr = p,
		}
	end
	ease {
		420 + (5 * .25), 5 * .25, inOutCubic,
		0, 'x'..o,
		0, 'y'..o,
		plr = 2,
	}
end

ease {
	441.45, (11 * .25), linear,
	360 * toRad, 'centerrotateZ',
	360, 'angle'
}
set {
	441.45 + (11 * .25),
	0, 'angle',
}

local function bumply(from, to, s)
	s = s or 1
	for i=from,to do
		local m = i % 2 == 0 and -1 or 1
		ease {
			i, .5, outCubic,
			-25 * s, 'y',
			5 * m * toRad * s, 'strumrotateZ',
			plr = 1,
		}
		ease {
			i + .5, .5, inCubic,
			0, 'y',
			0, 'strumrotateZ',
			plr = 1,
		}
	end
end
bumply(420, 435)

ease {
	436, 1, linear,
	(flashingLights and 4 or 1) * 360 * toRad, 'strumrotateY',
	plr = 2,
}

ease {
	437, .5, outCubic,
	-100, 'y',
	plr = 2,
}

ease {
	437.5, .5, inCubic,
	0, 'y',
	plr = 2,
}

ease {
	438, .5, outCubic,
	(720 * .5) - 50 - (swagWidth * .5), 'y',
	plr = 2,
}

ease {
	438.5, .5, inCubic,
	100, 'y',
	plr = 2,
}

ease {
	438, 1, linear,
	(flashingLights and 4 or 1) * 360 * (flashingLights and 1 or toRad), 'strumrotateX',
	plr = 2,
}

ease {
	441.45, (11 * .25), linear,
	0, 'strumrotateX',
	0, 'y',
	0, 'localrotateZ',
	plr = 2,
}

ease {
	439, 1, inOutCubic,
	-15 * toRad, 'localrotateZ',
	plr = 2,
}

ease {
	440, 1, inOutCubic,
	35 * toRad, 'localrotateZ',
	plr = 2,
}

for i=0,3 do
	local m = i % 2 == 0 and -1 or 1
	ease {
		444 + i, 1, inOutCirc,
		toRad * 45 * m, 'centerrotateY',
	}
end
ease {
	444 + 4, .5, outCubic,
	0, 'centerrotateY',
}

ease {
	451, .5, outCubic,
	-100, 'y',
	plr = 2,
}

ease {
	451.5, .5, inCubic,
	200, 'y',
	plr = 2,
}

ease {
	451, 1, linear,
	200, 'x',
	-2, 'z',
	-45 * toRad, 'strumrotateX',
	-50 * toRad, 'strumrotateZ',
	plr = 2,
}

bumply(452, 466, .4)

for mod,percent in pairs(default_mods[2]) do
	ease {
		466, 2, inCirc,
		mod == 'x' and 300 or percent, mod,
		plr = 2,
	}
end

for o=0,3 do
	ease {
		468, 1, outCubic,
		centerOffset(o, swagWidth * -.3), 'x'..o,
		-.3, 'scalex'..o,
		-.3, 'scaley'..o,
		plr = 1,
	}
	if hardMode then
		ease {
			468, 1, outCubic,
			90 * toRad, 'localrotateZ',
			90, 'angle',
			plr = 1,
		}
	else
		local m = (o % 2 == 0 and -1 or 1)
		ease {
			468, 1, linear,
			--.4, 'tAccel',
			.015 * m, 'beatz'..o,
			.3 * m * toRad, 'strumwavyZ'..o,
			5 * m * toRad, 'strumwavyX'..o,
			plr = 1,
		}
	end
end

local jimbleStrength = flashingLights and 1 or .1

local focused = false
local function swapFocus(beat)
	focused = not focused
	for p=1,2 do
		local inFocus = focused == (p == 1)
		ease {
			beat, 1, outCubic,
			p == 1 and (inFocus and .5 or -.1) or (inFocus and 0 or -.6), 'opponentSwap',
			plr = p,
		}
		for o=0,3 do
			local s = inFocus and 0 or -.3
			ease {
				beat, 1, outCubic,
				centerOffset(o, swagWidth * s), 'x'..o,
				s, 'scalex'..o,
				s, 'scaley'..o,
				plr = p,
			}
		end
	end
end

for i=0,6 do
	swapFocus(476 + (i * 8))
end

ease {
	472, 4, inExpo,
	jimbleStrength * 10, 'jimble',
	plr = 2,
}
ease {
	472 + 4, 1, outExpo,
	0, 'jimble',
	plr = 2,
}

bumply(476, 476 + 7, .4)

set {
	484,
	jimbleStrength * 5, 'jimble',
	plr = 2,
}

ease {
	484, 2, outExpo,
	jimbleStrength * 1, 'jimble',
	plr = 2,
}

ease {
	486, 3, inExpo,
	jimbleStrength * 8, 'jimble',
	plr = 2,
}

set {
	492,
	jimbleStrength * 3, 'jimble',
	plr = 2,
}

set {
	493.25,
	0, 'jimble',
	plr = 2,
}

set {
	499,
	jimbleStrength * 3, 'jimble',
	plr = 2,
}

ease {
	499, 1, outExpo,
	0, 'jimble',
	plr = 2,
}

local function mapJimbles(arr)
	for i,v in pairs(arr) do
		set {
			v[1], 
			jimbleStrength * v[2], 'jimble',
			plr = 2,
		}
	end
end

mapJimbles {
	{500, 3},
	{500.6, 5},
	{500.75, 7},
	{501, 0},
	{501.25, 3},
	{501.5, 5},
	{502.75, 0},
	{503, 1},
}

ease {
	508, 1, linear,
	0, 'jimble',
	plr = 2,
}

mapJimbles {
	{516, 1},
	{520, 0},
	{522, 2},
}

ease {
	519, 1, linear,
	jimbleStrength * 8, 'jimble',
	plr = 2,
}

ease {
	523, 1, linear,
	jimbleStrength * 8, 'jimble',
	plr = 2,
}

ease {
	524, 1, linear,
	0, 'jimble',
	plr = 2,
}


for mod,percent in pairs(default_mods[1]) do
	ease {
		532, 3.5, inOutCirc,
		percent, mod,
		plr = 1,
	}
end

for o=0,3 do
	ease {
		532, 8, outSine,
		100 * toRad, 'localrotateZ'..o,
		1000, 'x'..o,
		plr = 2,
	}
end

reset {540}
for o=0,3 do
	local s = .3
	set {
		540,
		720, 'y'..o,
		centerOffset(o, swagWidth * s), 'x'..o,
		s, 'scalex'..o,
		s, 'scaley'..o,
		plr = 2,
	}
	local b = 544 + (o * .1)
	ease {
		b, 1, linear,
		0, 'x'..o,
		0, 'scalex'..o,
		0, 'scaley'..o,
		plr = 2,
	}
	ease {
		b, .5, outCubic,
		-30, 'y'..o,
		plr = 2,
	}
	ease {
		b + .5, .5, inCubic,
		0, 'y'..o,
		plr = 2,
	}
end

local function periodicBump(beat, len)
	for o=0,3 do
		set {
			beat,
			math.random(-50, 50), 'x'..o,
			math.random(-50, 50), 'y'..o,
		}
		ease {
			beat, len or 1, outExpo,
			0, 'x'..o,
			0, 'y'..o,
		}
	end
end

periodicBump(546.5)
periodicBump(547 + THIRD, .75)
periodicBump(548)


ease {
	548, .5, linear,
	25, 'furiosity',
	1, 'furiositySpread',
}
ofs = 0
classicCuberoot(549, 581)

print('everything is fine', flashingLights)