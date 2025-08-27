local runStepChart = {}

function forAllStrums(func)
    if disableModcharts then return end

    for i=0,7 do
        func(i)
    end
end

-- REMEMBER TO INVERT THE SIGN WHEN PUTTING THIS IN GAME
-- i remembered :)
local posChart = {
    [0] = {
        ["x"] = {
            [0] = 22.9,
            [1] = 21.6,
            [2] = -45.75,
            [3] = 118.2
        },
        ["y"] = {
            [0] = 21.6,
            [1] = -24.05,
            [2] = 19.2,
            [3] = 50.85
        }
    },
    [1] = {
        ["x"] = {
            [0] = 29.15,
            [1] = 12.7,
            [2] = -39.35,
            [3] = 73.75
        },
        ["y"] = {
            [0] = -24,
            [1] = 39.4,
            [2] = -34.3,
            [3] = -71.1
        }
    },
    [2] = {
        ["x"] = {
            [0] = -19.15,
            [1] = -31.75,
            [2] = 15.25,
            [3] = -74.9
        },
        ["y"] = {
            [0] = 29.2,
            [1] = -25.4,
            [2] = 67.35,
            [3] = 81.35
        }
    },
    [3] = {
        ["x"] = {
            [0] = -19.05,
            [1] = 0.1,
            [2] = 43.15,
            [3] = -165.15
        },
        ["y"] = {
            [0] = -25.45,
            [1] = 39.3,
            [2] = 17.75,
            [3] = -39.45
        }
    }
}

function glitchDrum(pos)
    forAllStrums(function(note)
        local modNote = note % 4
        setPropertyFromGroup('strumLineNotes', note, 'x', defaultStrumValues[note + 1].x + (posChart[modNote].x[pos] * -1))
        setPropertyFromGroup('strumLineNotes', note, 'y', defaultStrumValues[note + 1].y + (posChart[modNote].y[pos] * -1))
    end)
end