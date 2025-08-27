-- free bops

local toRad = math.pi / 180;
local function rotYBop(from, to)
	for i=from,to do
		if i % 4 == 0 then
			local m = i % 8 == 0 and -1 or 1
			ease {
				i - 2, 2, outCirc,
				m * 360 * toRad, 'localrotateY-a',
			}
			set {
				i,
				0, 'localrotateY-a',
			}
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

local function rotBop(from, to)
	for i=from,to,4 do
		ease {
			i, 4, inOutCirc,
			math.pi, 'localrotateX',
			math.pi, 'localrotateY',
			math.pi, 'localrotateZ',
		}
		set {
			i + 4,
			0, 'localrotateX',
			0, 'localrotateY',
			0, 'localrotateZ',
		}
	end
end

-- this one just kinda ended up weird
-- looking at it again THIS GOES HARD???? someone use this please i couldnt use it in crud cause of angle restrictions (cant rotate in ms paint)
local function cubleClassic(from, to)
	local angle = 0
	for beat=from,to do
		local m = beat % 2 == 0 and -1 or 1
		angle = angle + (45 * .5)
		
		ease {
			beat, 1, outCirc,
			angle, 'angle',
		}
		ease {
			beat, .5, outCubic,
			-15, 'y',
			-15 * m, 'spin',
		}
		ease {
			beat + .5, .5, inCubic,
			0, 'y',
			0, 'spin',
		}
		if beat % 2 == 0 then
			set {
				beat,
				500, 'pulse',
			}
			ease {
				beat, 1, outCubic,
				0, 'pulse',
			}
			for o=0,3 do
				local b = beat + (o * .5)
				ease {
					b, 1, inOutSine,
					-20, 'y'..o,
				}
				ease {
					b + 1, 1, inOutSine,
					20, 'y'..o,
				}
				for i=0,1 do
					local s = i == 0 and -.1 or .1
					ease {
						b + i, .5, outSine,
						s, 'scalex'..o,
						s, 'scaley'..o,
						centerOffset(o, swagWidth * s), 'x'..o,
					}
					ease {
						b + .5 + i, .5, inSine,
						0, 'scalex'..o,
						0, 'scaley'..o,
						0, 'x'..o,
					}
				end
			end
		end
	end
end


-- thrown together thing that puts all the strums in one position and gradually 
setModProperty('lerp', 'ease', inSine)
set {
	-5,
	-.5, 'lerpscalex',
	-.5, 'lerpscaley',
	swagWidth, 'lerpdistance',
}

set {
	-5,
	swagWidth * 4, 'lerpx0',
	swagWidth * 3, 'lerpx1',
	swagWidth * 2, 'lerpx2',
	swagWidth * 1, 'lerpx3',
	plr = 2,
}

set {
	-5,
	-swagWidth * 1, 'lerpx0',
	-swagWidth * 2, 'lerpx1',
	-swagWidth * 3, 'lerpx2',
	-swagWidth * 4, 'lerpx3',
	plr = 1,
}




local function random2DSpin(from, to)
	for i=from,to do
		local m = i % 4 == 0 and -1 or 1
		for o=0,3 do
			local t = i - 2 + (o * .25)
			ease {
				t, 1, inOutSine,
				1, 'rotspinx'..o,
			}
			set {
				t + 1,
				0, 'rotspinx'..o,
			}
			if i % 2 == 0 then
				ease {
					i + (o * .5) - 2, 2, inBack,
					35 * m, 'y'..o,
				}
				ease {
					i - .5, .5, inCubic,
					-swagWidth * m, 'x'..o,
				}
				ease {
					i, 1.5, outCubic,
					0, 'x'..o,
				}
			end
		end
	end
end

-- sidescroll fun
do
	local toRad = math.pi / 180

	set {
		-5,
		-swagWidth * 1.5, 'strumrx',
		swagWidth * 1.5, 'x',
		--200, 'y',
		plr = 1,
	}
	set {
		-5,
		swagWidth * 1.5, 'strumrx',
		-swagWidth * 1.5, 'x',
		--200, 'y',
		plr = 2,
	}
	ease {
		1, 1, outCubic,
		-90 * toRad, 'strumrotateZ',
		-90, 'angle',
		plr = 1,
	}
	ease {
		1, 1, outCubic,
		90 * toRad, 'strumrotateZ',
		90, 'angle',
		plr = 2,
	}

	ease {
		1, 1, outCubic,
		(180 + 75) * toRad, 'strumrotateY',
		0 * toRad, 'strumrotateX',
		plr = 1,
	}

	ease {
		1, 1, outCubic,
		(180 - 75) * toRad, 'strumrotateY',
		0 * toRad, 'strumrotateX',
		plr = 2,
	}
end