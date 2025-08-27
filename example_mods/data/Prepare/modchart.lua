-- enables like.. two things
local hardMode = false

local babytangosynth = {
    {beat = 0.50000, midi = 2, length = 0.25000},
    {beat = 1.00000, midi = 2, length = 0.12500},
    {beat = 1.25000, midi = 2, length = 0.11458},
    {beat = 1.50000, midi = 0, length = 0.12500},
    {beat = 1.75000, midi = 0, length = 0.12500},
    {beat = 2.00000, midi = 0, length = 0.36458},
    {beat = 2.50000, midi = 0, length = 0.36458},
    {beat = 3.00000, midi = 2, length = 0.25000},
    {beat = 3.25000, midi = 0, length = 0.15625},
    {beat = 3.50000, midi = 3, length = 0.50000},
    {beat = 4.00000, midi = 2, length = 0.17708},
    {beat = 4.25000, midi = 2, length = 0.17708},
    {beat = 4.50000, midi = 2, length = 0.25000},
    {beat = 5.00000, midi = 2, length = 0.15625},
    {beat = 5.25000, midi = 3, length = 0.15625},
    {beat = 5.50000, midi = 2, length = 0.15625},
    {beat = 5.75000, midi = 0, length = 0.15625},
    {beat = 6.00000, midi = 0, length = 0.25000},
    {beat = 6.50000, midi = 0, length = 0.50000},
    {beat = 7.00000, midi = 2, length = 0.25000},
    {beat = 7.25000, midi = 3, length = 0.25000},
    {beat = 7.50000, midi = 2, length = 0.25000},
    {beat = 7.75000, midi = 3, length = 0.25000},
    {beat = 8.00000, midi = 1, length = 0.25000},
    {beat = 8.50000, midi = 1, length = 0.15625},
    {beat = 8.75000, midi = 1, length = 0.15625},
    {beat = 9.00000, midi = 2, length = 0.15625},
    {beat = 9.25000, midi = 2, length = 0.15625},
    {beat = 9.50000, midi = 1, length = 0.15625},
    {beat = 9.75000, midi = 0, length = 0.15625},
    {beat = 10.00000, midi = 1, length = 0.50000},
    {beat = 10.50000, midi = 1, length = 0.17708},
    {beat = 10.75000, midi = 1, length = 0.17708},
    {beat = 11.00000, midi = 2, length = 0.50000},
    {beat = 11.50000, midi = 3, length = 0.25000},
    {beat = 12.00000, midi = 1, length = 0.14583},
    {beat = 12.25000, midi = 1, length = 0.14583},
    {beat = 12.50000, midi = 1, length = 0.05208},
    {beat = 12.62500, midi = 1, length = 0.05208},
    {beat = 12.75000, midi = 1, length = 0.08333},
    {beat = 12.88542, midi = 1, length = 0.08333},
    {beat = 13.00000, midi = 2, length = 0.12500},
    {beat = 13.25000, midi = 2, length = 0.12500},
    {beat = 13.50000, midi = 0, length = 0.25000},
    {beat = 13.75000, midi = 2, length = 0.25000},
    {beat = 14.00000, midi = 1, length = 0.38542},
    {beat = 14.50000, midi = 2, length = 0.38542},
    {beat = 15.00000, midi = 3, length = 0.50000},
    {beat = 15.50000, midi = 1, length = 0.50000},
}

local nooope = -1
local function boopbopbeat(b, intense)
    ease {
        b - 0.1, 0.1, inCubic,
        1, "squish"
    }
    ease {
        b, 0.5, outCubic,
        0, "squish"
    }

    ease {
        b - 0.1, 0.1, inCubic,
        50 * nooope, "transformX"
    }
    ease {
        b, 1, outCubic,
        0, "transformX"
    }

    if intense == true then
        ease {
            b - 0.1, 0.1, inCubic,
            2.5 * nooope, "spin"
        }
        ease {
            b, 3, outElastic,
            0, "spin"
        }
    end
    nooope = 0 - nooope
end

local function funkybounce(b)
    for i = 0, 3 do
        local lol = (b % 4 == i % 2 * 2) and -45 or -15
        ease {
            b, 0.5, outQuad,
            lol, "transform"..i.."Y"
        }
        ease {
            b + 0.5, 0.5, inQuad,
            0, "transform"..i.."Y"
        }
    end
end

local bigpowFlip = 1
local function bigpow(b, intense)
    set {
        b,
        -0.35, "mini"
    }
    ease {
        b, 1, outCubic,
        0, "mini"
    }
    ease {
        b - 0.125, 0.125, outCubic,
        bigpowFlip * 40, "skewx"
    }
    ease {
        b - 0.125, 0.125, outSine,
        bigpowFlip * 10, "skewy"
    }
    ease {
        b, 0.375, inQuart,
        bigpowFlip * -10, "skewx"
    }
    ease {
        b, 0.25, inOutSine,
        bigpowFlip * -10, "skewy"
    }
    ease {
        b + 0.375, 0.125, inSine,
        0, "skewy"
    }
    ease {
        b + 0.5, 0.25, outCubic,
        0, "skewx"
    }

    if intense == true then
        ease {
            b - 0.1, 0.1, inQuad,
            0.35, "tornado",
            10 * bigpowFlip, "flip",
        }

        ease {
            b, 0.8, outQuad,
            0, "tornado",
            0, "flip"
        }
    end

    bigpowFlip = 0 - bigpowFlip
end

-- start of modchart

for b = 0, 24, 8 do
    boopbopbeat(b + 0)
    boopbopbeat(b + 2.5)
    boopbopbeat(b + 3.5)
    boopbopbeat(b + 4)
    boopbopbeat(b + 6.5)
    boopbopbeat(b + 7)
    boopbopbeat(b + 7.5)
end

-- davey wavey

set {
    29.9,
    15, "tipsySpeed",
    -10, "tipZSpeed"
}

ease {
    29.9, 0.5, outQuad,
    0.3, "tipsy",
    0.3, "tipZ",
    plr = 1
}

ease {
    31.5, 1, inOutQuad,
    0, "tipsy",
    0, "tipZ",
    plr = 1
}

for b = 18, 30, 4 do
    bigpow(b)
end

-- synth

function wiggleSquish(b, i)
    set {
        b,
        -25, "transform"..i.."Y"
    }
    ease {
        b, 2, outElastic,
        0, "transform"..i.."Y"
    }
end

for b = 32, 60, 8 do
    -- lazy
    if synthReverse then
        wiggleSquish(b, 0) -- 32
        wiggleSquish(b + 1, 1) -- 33
        wiggleSquish(b + 1.5, 2) -- 33.5
        wiggleSquish(b + 2, 3) -- 34
        wiggleSquish(b + 2.5, 2) -- 34.5
        wiggleSquish(b + 3, 1) -- 35
    else
        wiggleSquish(b, 3) -- 32
        wiggleSquish(b + 1, 2) -- 33
        wiggleSquish(b + 1.5, 1) -- 33.5
        wiggleSquish(b + 2, 0) -- 34
        wiggleSquish(b + 2.5, 1) -- 34.5
        wiggleSquish(b + 3, 2) -- 35
    end

    synthReverse = not synthReverse
end

for b = 32, 56, 4 do
    boopbopbeat(b)
    boopbopbeat(b + 2.5)
end

for b = 33, 59, 2 do
    bigpow(b)
end

-- Decending bweem bwoom boom
do
    set {
        60,
        8, "wavedensity"
    }

    set {
        60,
        0.3, "wavesteer"
    }

    ease {
        60, 3, inQuad,
        50, "waveamount",
        0.2, "tAccel"
    }

    ease {
        60, 127 - 60, linear,
        12, "waveoffset"
    }

    local flip = -1
    for b = 60, 63 do
        local p = (b - 59)
        local p_15 = p * 15

        ease {
            b, 0.5, outQuad,
            p * 25 * flip, "transformX",
            (p * 25 * flip) + p_15, "angle",
        }
        ease {
            b+0.5, 0.5, inQuad,
            0, "transformX",
            0, "angle",
        }

        ease {
            b+0.5, 0.5, outSine,
            p_15 * 0.3 * flip, "spin0",
            p_15 * 0.2 * flip, "spin1",
            p_15 * 0.2 * flip, "spin2",
            p_15 * 0.3 * flip, "spin3",
            (p_15 * 0.3 * flip) * math.pi / 180, "localrotateY",
            (p_15 * 0.15 * -flip) * math.pi / 180, "rotspiny",
            
            -1, "spinangle"
        }
        ease {
            b+1, 0.5, inSine,
            0, "spin0",
            0, "spin1",
            0, "spin2",
            0, "spin3",
            0, "localrotateY",
            0, "rotspiny",

            -1, "spinangle"
        }
        flip = 0 - flip
    end
end

-- fling back
ease {
    64, 0.5, outQuad,
    -30, "transformX",
    -5 * 2, "angle",
    -0.1, "tAccel"
}
ease {
    64.5, 0.5, inQuad,
    35, "transformX",
    0, "angle",
    0.05, "tAccel",

    0, "spin0",
    0, "spin1",
    0, "spin2",
    0, "spin3",

    -1, "spinangle"
}
ease {
    65, 1, outQuad,
    0, "transformX",
}
ease {
    65, 0.5, outQuad,
    -0.1, "tAccel"
}

ease {
    65.5, 0.5, inOutSine,
    0, "tAccel"
}

set {
    65.1,
    1, "spinangle"
}

for b = 64, 122 do
    funkybounce(b)

    if b % 2 == 1 then
        bigpow(b)
    end

    if b > 65 then
        local flipper = b % 2 == 1 and 1 or -1

        ease {
            b - 0.1, 0.1, inQuad,
            0.1 * flipper, "tAccel",
        }

        ease {
            b, 0.8, outQuad,
            0, "tAccel",
        }
    end

    if b % 4 == 0 then
        ease {
            b, 2, inOutQuad,
            25, "transformX-a"
        }

        ease {
            b + 0.5, 2.5, inOutQuad,
            0.5, "spin"
        }

        ease {
            b + 2, 2, inOutQuad,
            -25, "transformX-a"
        }

        ease {
            b + 2.5, 2.5, inOutQuad,
            -0.5, "spin"
        }
    end
end

if not hardMode then
	ease {
		122, 1, linear,
		0, 'waveamount',
	}
end

-- waa ee uhh

for b = 104, 120, 16 do
    local player = b == 104 and 2 or 1
    ease {
        b, 1, inOutQuad,
        25, "skewx-a",
        -8 * (math.pi / 180), "directionrotateZ",
        -50, "transformX-aaa",
        plr = player
    }
    
    ease {
        b + 1, 1.5, inOutQuad,
        -25, "skewx-a",
        8 * (math.pi / 180), "directionrotateZ",
        50, "transformX-aaa",
        plr = player
    }
    
    ease {
        b + 3, 1, inOutSine,
        0, "skewx-a",
        0 * (math.pi / 180), "directionrotateZ",
        0, "transformX-aaa",
        plr = player
    }
end

-- WAAH UHH

for b = 110, 126, 16 do
	if b == 126 and not hardMode then
		break
	end
    local player = b == 110 and 2 or 1
    ease {
        b, 1, outQuad,
        -15, "flip",
        0.2, "tornado",
        plr = player
    }
    ease {
        b+1, 1, inQuad,
        b == 126 and 15 or 0, "flip",
        0, "tornado",
        plr = player
    }
end

-- back to normal

if hardMode then
	ease {
		126, 1, outQuad,
		0.5, "tAccel",
		1, "squish",
	}
	
	ease {
		127, 1, outQuad,
		75, "waveamount"
	}
	
	ease {
		127, 1, inQuad,
		-0.4, "tAccel",
		-0.4, "squish",
	}
	
	ease {
		128, 1, inQuad,
		0, "waveamount"
	}
end

ease {
    128, 1, inOutSine,
    0, "tAccel",
    0, "squish",
    0, "flip"
}

-- start of mad section

for b = 128, 136, 8 do
    boopbopbeat(b + 0, true)
    boopbopbeat(b + 3.5, true)
    boopbopbeat(b + 4, true)
    boopbopbeat(b + 6.5, true)
    boopbopbeat(b + 7, true)
    boopbopbeat(b + 7.5, true)
end

set {
    128,
    0.1, "jimble"
}

set {
    128,
    12, "wavedensity"
}

-- baby tango synth
for b = 128, 223, 8 * 2 do
    for i, note in ipairs(babytangosynth) do
        if b + note.beat < 192 or b + note.beat > 194 then 
            local flipper = i % 2 == 1 and 1 or -1
            set {
                b + note.beat - 0.5,
                .3, "scalex"..note.midi,
                .3, "scaley"..note.midi,
                75 * flipper, "waveamount"..note.midi,
                0, "waveoffset"..note.midi,
            }
            ease {
                b + note.beat - 0.5, note.length * 3, outQuad,
                0, "scalex"..note.midi,
                0, "scaley"..note.midi,
                0, "waveamount"..note.midi,
                0.1 * note.length, "waveoffset"..note.midi,
            }
        end
    end
end

for b = 144, 184, 8 do
    boopbopbeat(b + 0, true)
    boopbopbeat(b + 2.5, true)
    boopbopbeat(b + 3.5, true)
    boopbopbeat(b + 4, true)
    boopbopbeat(b + 6.5, true)
    boopbopbeat(b + 7, true)
    boopbopbeat(b + 7.5, true)
end

for b = 146, 158, 4 do
    bigpow(b, true)
end

for b = 161, 191, 2 do
    bigpow(b, true)
end

-- after SLUULULULUL

set {
    192,
    4, "tipsySpeed"
}

ease {
    192, 0.5, outCubic,
    1, "tipsy",
}

ease {
    192.5, 1, inOutCubic,
    -1, "tipsy",
    -10, "flip",
    -0.25, "mini",
    3, "jimble",
    15, "spin"
}

ease {
    193.5, 0.5, inQuart,
    0.5, "tipsy",
    0, "flip",
    0, "mini",
    0, "spin"
}

ease {
    194, 5, outElastic,
    0.5, "jimble"
}
    
for i = 0, 3 do
    set {
        194,
        (i%2 == 0) and -0.05 or 0.05, "beatz"..i
    }
end

for b = 194, 223, 1 do
    local flip = b % 2 == 0 and 1 or -1

    ease {
        b - 0.1, 0.1, inQuad,
        0.75 * flip, "localrotateY",
    }

    ease {
        b, 0.9, outQuad,
        0, "localrotateY"
    }
end

-- calm down you ahh

ease {
    224, 2, outCubic,
    0, "tipsy",
    0, "flip",
    0, "mini",

    0, "beatz0",
    0, "beatz1",
    0, "beatz2",
    0, "beatz3",

    0.1, "jimble"
}

for b = 224, 255, 8 do
    boopbopbeat(b + 0, true)
    boopbopbeat(b + 3, true)
    bigpow(b + 4, true)
    boopbopbeat(b + 5, true)
    boopbopbeat(b + 6.5, true)
end

-- scream
set {
    249.75,
    50, "tipsySpeed",
    -50, "tipZSpeed",
}

ease {
    249.75, 6.25, inQuart,
    3, "jimble",
    2, "tipsy",
    2, "tipZ",
    15, "localrotateY",
    plr = 2
}

ease {
    256, 1, outQuad,
    0, "tipsy",
    0, "tipZ",
    15 - 2.43362938564, "localrotateY",
    0.1, "jimble",
    plr = 2
}

set {
    257, 
    0, "localrotateY",
}

set {
    256,
    5, "tipsySpeed",
}

for b = 256, 319, 4 do
    boopbopbeat(b + 0, true)
    boopbopbeat(b + 1, true)
    boopbopbeat(b + 2, true)
    boopbopbeat(b + 3, true)

    if b < 316 then
        ease {
            b - 0.2, 0.2, inQuad,
            1, "tipsy",
        }

        ease {
            b, 2, outQuad,
            0, "tipsy",
        }
    end
end

for b = 288, 319, 4 do
    bigpow(b + 1, true)
    bigpow(b + 3, true)
end

-- do do dod ododododoodo

set {
    316,
    -1, "tipsySpeed",
    1, "tipsy"
}

for _, b in ipairs({316, 317, 318, 318.5, 319, 319.25, 319.5, 319.75}) do
    set {
        b,
        b, "tipsyOffset",
        getRandomFloat(-0.25, 0.25), "strumrotateZ",
        getRandomFloat(-0.2, 0.2), "localrotateY",
    }

    ease {
        b - 0.1, 0.1, inQuad,
        0.2, "scalex",
        0.2, "scaley",
    }

    ease {
        b, 1, outQuad,
        0, "scalex",
        0, "scaley",
    }
end

ease {
    320 - 0.1, 0.1, outQuad,
    -0.5, "flip",
}

ease {
    320, 2, inOutSine,
    0, "strumrotateZ",
    0, "localrotateY"
}

set {
    316,
    1, "tipsySpeed",
    0.2, "tipZSpeed",

    5, "wavedensity"
}

ease {
    320, 500, linear,

    50, "waveoffset",
}

ease {
    320, 1, outQuad,
    0.6, "tipsy",
    0.1, "tipZ",

    50, "waveamount",
    -0.15, "transformZ-a",
    -25, "transformY-aa",
}

ease {
    320, 2, outQuad,

    0.5, "opponentSwap",
}

ease {
    320, 2, outQuad,

    0.75, "alpha",
	-1, "glow",
    plr = 2
}


-- forever weed brownie
for b = 320, 388, 16 do
    if b > 388 then break end

    ease {
        b, 8, inOutSine,
        -150, "transformX-a",
        0.1, "tornadoz"
    }

    if b + 8 > 388 then break end

    ease {
        b + 8, 8, inOutSine,
        150, "transformX-a",
        -0.05, "tornadoz"
    }

    -- cosine
    ease {
        b + 4, 8, inOutSine,
        -0.6, "localrotateY",
    }

    ease {
        b + 8 + 4, 8, inOutSine,
        0.6, "localrotateY",
    }
end

local flipperydoodaah = 1
for b = 320, 376, 4 do
    for i = 0, 3 do
        local offset = 0.05 * i
    
        ease {
            b - 0.5 + offset, 0.5, inQuad,
            0.5, "tAccel"..i,
            1, "squish"..i,
            15 * flipperydoodaah, "reverse"..i,
            25 * flipperydoodaah, "angle"..i,
        }
    
        ease {
            b + offset, 1, outQuad,
            0, "tAccel"..i,
            0, "squish"..i,
            0, "reverse"..i,
            0, "angle"..i,
        }

        if b > 320 then
            ease {
                b - 0.5 + offset, 0.5, inQuad,
                75, "waveamount"..i
            }

            ease {
                b + offset, 1, outQuad,
                0, "waveamount"..i
            }
        end
    end
    flipperydoodaah = 0 - flipperydoodaah
end

local function swoooon(b, len)
    ease {
        b - 0.1, 0.1, inQuad,
        0.15, "tornadoz",
    }

    ease {
        b, len, outQuad,
        0, "tornadoz",
    }

    for i = 0, 3 do
        local offset = 0.025 * i

        ease {
            b - 0.1 + offset, 0.1, inQuad,
            25 * flipperydoodaah, "angle"..i,
            (20 * (i%2) - 10) * flipperydoodaah, "transform"..i.."Y",
            25 * flipperydoodaah, "skewy"..i,
            -0.5, "mini"..i.."X",
            -0.5, "mini"..i.."Y",
        }
    
        ease {
            b + offset, len, outQuad,
            0, "angle"..i,
            0, "transform"..i.."Y",
            0, "skewy"..i,        
            0, "mini"..i.."X",
            0, "mini"..i.."Y",
        }
    end

    flipperydoodaah = 0 - flipperydoodaah
end

for b = 380, 383 do
    swoooon(b, 0.9)
end

for b = 384, 387.5, 0.5 do
    swoooon(b, 0.4)
end
swoooon(388, 2)

ease {
    388, 3, inQuad,

    -300 * downscrollFlipper, "transformY-aa",
}

ease {
    388, 3, inSine,

    1, "tAccel"
}

-- me pad?

reset {392}
set {
    392,
    20, "y"
}


for b = 1, 4 do
    set {
        391 + b,
        -1 + 0.25*b, "opponentSwap"
    }
end

set {
    395,
    0.35, "mini",
    30, "flip",
    0.5, "tAccel"
}

ease {
    395, 1, inQuart,
    0, "mini",
    0, "flip",
    0.2, "tAccel"
}

local canfliips = 1
for _, b in ipairs({395, 395.25, 395.5, 395.625, 395.75, 395.875}) do
    for i = 0, 3 do
        ease {
            b, 0.125, linear,
            0.6 * canfliips, "squish"..i,
            20 * canfliips, "angle"..i
        }
        canfliips = -canfliips
    end
    canfliips = -canfliips
end

for i = 0, 3 do
    ease {
        396, 0.125, linear,
        0, "squish"..i,
        0, "angle"..i
    }
end

for b = 396, 454, 2 do
    local bighits = b >= 428 and b % 4 == 2
    local bigflips = b % 8 > 3 and 1 or -1
    ease {
        b, 0.125, linear,
        bighits and -0.4 or 0.25, "squish",
        bighits and -0.5 or 0, "mini",
        bighits and bigflips*-0.1 or 0, "tornadoz"
    }
    ease {
        b + 1, 1, inQuad,
        0, "squish",
        0, "mini",
        0, "tornadoz"
    }

    for i = 0, 3 do
        local theta = b + i*pi
        ease {
            b, 0.125, linear,
            cos(theta) * -15, "angle"..i,
            bighits and (cos(theta) * -20) or 0, "skewx"..i,
            cos(theta)* 45, "transform"..i.."X",
            sin(theta)* 60, "transform"..i.."Y",
        }
        ease {
            b + 1, 1, inQuad,
            0, "angle"..i,
            0, "skewx"..i,
            0, "transform"..i.."X",
            0, "transform"..i.."Y",
        }
    end
end

ease {
    428, 28, inOutQuad,
    0.45, "tAccel",
}

-- out of pad
ease {
    457.5, 1, inOutQuad,
    -10, "spin",
}
ease {
    458.5, 1, inOutQuad,
    20, "spin",
}

ease {
    459, 1, inCubic,
    0, "tAccel",
    0, "y"
}

ease {
    459.5, 0.5, inQuad,
    0, "angle",
    0, "spin",
    0, "x"
}

ease {
    458, 2, inQuart,
    30, "flip",
    0.7, "stretch",
    -0.25, "mini",
    0.1, "jimble"
}


set {
    460,
    0, "stretch",
    
    0.2, "tipsy",
    7, "tipsySpeed",

    7, "tipZSpeed",
    1.2, "tipZOffset"
}

for b = 460, 473 do
    local flippies = b%2==1 and 1 or -1

    set {
        b,
        -1.6, "mini",
        -0.5, "squish",
        -5, "flip",
        40 * flippies, "skewx",
        10 * flippies, "spin",
        1.5 * flippies, "localrotateY",
    }
    ease {
        b, 0.75, outBack,
        -0.6, "mini",
        0.25, "squish",
        0.4 * flippies, "localrotateY",
    }
    ease {
        b, 0.75, outCubic,
        5, "flip",
        0, "skewx",
        0, "spin",
    }
    ease {
        b + 0.75, 0.25, inCubic,
        0, "mini",
        0.5, "squish",
    }
end

ease {
    468, 4, outQuad,
    -0.5, "localrotateX",
}
ease {
    472, 1, outQuad,
    0.5, "localrotateX",
}
ease {
    473, 1, inQuad,
    0, "localrotateX",
}

ease {
    473.75, 0.25, inCubic,
    0, "tipsy",
    0, "jimble"
}
ease {
    474, 0.75, outCubic,
    0.2, "localrotateY",
    0.2, "squish"
}

ease {
    474.5, 1, inOutCubic,
    -0.1, "localrotateX",
    0.6, "localrotateY",
}

ease {
    474, 1, inCubic,
    -5, "angle"
}
ease {
    475, 1, inQuart,
    0, "angle",
    -0.1, "squish",
}

ease {
    475.5, 0.5, inCubic,
    0, "localrotateX",
    -0.9, "localrotateY",
}
ease {
    476, 2, outCubic,
    0, "localrotateY"
}

set {
    475,
    3, "drunkSpeed",
    -0.75, "drunkPeriod",
    -1, "drunkOffset",
}

ease {
    475, 1, inCubic,
    -0.2, "tipZ",
    0.6, "drunk"
}

set {
    476,
    0, "squish"
}

--lala

local function lasters(b)
    funkybounce(b)

    ease {
        b-0.1, 0.1, linear,
        -0.5, "mini",
    }

    ease {
        b, 0.8, outCubic,
        0, "mini",
    }
end

for b=476, 491 do
    lasters(b)
end

ease {
    491, 1, inQuint,
    -0.8, "localrotateX",
    0.5, "squish"
}
ease {
    491.5, 1, inOutCubic,
    0.1, "tornadoz"
}

ease {
    492, 0.25, outCubic,
    -0.95, "localrotateX",
    0.55, "squish"
}
ease {
    492.25, 0.75, inCubic,
    0.2, "localrotateX",
    -0.4, "squish"
}
ease {
    492.5, 1, inOutCubic,
    0, "tornadoz",
    0.2, "tipZ"
}
ease {
    493, 2, outCubic,
    0, "localrotateX",
    0, "squish"
}

for b=493, 523 do
    lasters(b)
end

ease {
    523, 0.5, outCubic,
    -0.5, "localrotateY"
}

ease {
    523.5, 0.5, inCubic,
    0, "localrotateY"
}

set {
    524,
    -2 * pi, "localrotateY",
}
ease {
    524, 4, outCubic,
    0, "localrotateY",
}

set {
    524,
    1, "spinangle",
}

for b = 524, 586 do
    funkybounce(b)
    local flipper = b % 2 == 1 and 1 or -1

    if b % 2 == 1 then
        bigpow(b, true)
        ease {
            b-0.5, 0.5, inCubic,
            0.1, "reverse",
        }

        ease {
            b, 1, outCubic,
            0, "reverse",
        }
    end

    if b % 4 == 0 then
        ease {
            b, 2, inOutQuad,
            25, "transformX-a"
        }

        ease {
            b + 0.5, 2.5, inOutQuad,
            0.5, "spin"
        }

        ease {
            b + 2, 2, inOutQuad,
            -25, "transformX-a"
        }

        ease {
            b + 2.5, 2.5, inOutQuad,
            -0.5, "spin"
        }
    end
end

ease {
    587, 1, inCubic,
    0, "tipZ",
    0, "drunk",
}

for b = 587, 587.75, 0.25 do
    set {
        b,
        getRandomFloat(-0.35, 0.35), "strumrotateZ",
        getRandomFloat(-0.2, 0.2), "localrotateY",
    }

    set {
        b,
        b%1 * -1.2 - 0.2, "mini"
    }
end

ease {
    588, 1, outCubic,
    0, "mini",
    0, "strumrotateZ",
    0, "localrotateY",
}

for b = 588, 600, 4 do
    boopbopbeat(b + 0, true)
    bigpow(b + 1, true)
    boopbopbeat(b + 2.5, true)
    bigpow(b + 3, true)
end

do
    local b = 604
    boopbopbeat(b + 0)
    boopbopbeat(b + 2.5)
    boopbopbeat(b + 3.5)
    boopbopbeat(b + 4)
    boopbopbeat(b + 6.5)
    boopbopbeat(b + 7)
    boopbopbeat(b + 7.5)

    local b = 612
    boopbopbeat(b + 0)
    boopbopbeat(b + 2.5)
    boopbopbeat(b + 3.5)
end

for b = 606, 614, 4 do
    bigpow(b)
end

for _, b in ipairs({616, 617, 617.5, 618, 619}) do
    boopbopbeat(b)
    bigpow(b, true)
end

set {
    619,
    63, "drunkSpeed",
    0, "drunkPeriod",
    0, "drunkOffset",

    63, "tipZSpeed",
    0, "tipZOffset"
}

ease {
    618.75, 0.75, outCubic,
    -20, "spin",

    plr = 2
}

ease {
    619, 1, inBack,
    1.5, "drunk",
    -0.5, "tornado",
    3, "jimble",
    0.8, "alpha",
    0.5, "tipZ",
    -1.5, "mini",
    0.3, "opponentSwap",
    -0.6, "localrotateY",
    0.6, "localrotateX",
    0.25, "squish",
    -40, "flip",

    plr = 2
}

ease {
    619.5, 1.5, inOutCubic,
    10, "spin",

    plr = 2
}

ease {
    619.5, 0.5, inCubic,
    0.3, "mini",
    25, "flip",
    -0.4, "opponentSwap",
    0.5, "jimble",
    0.2, "stretch",
    0.1, "reverse",
    -8, "spin",

    plr = 1
}

set {
    620,
    -0.1, "mini",

    plr = 1
}

ease {
    620, 2, outCubic,
    0.3, "mini",

    plr = 1
}

ease {
    624, 4, inQuart,
    -200, "y",
    1, "alpha",
	0, "glow",
    1, "tAccel",

    plr = 2
}

ease {
    624, 4, inQuart,
    300, "x",
    1, "alpha",
    -60, "spin",
    0.6, "stretch",
    50, "flip",

    plr = 1
}