local ohungiSorted = {
	normals = {},
	alts = {},
}

function onCreatePost()
	ohungis = getLoadingValue 'ohungisLoaded'
	for _,v in pairs(ohungis) do
		if v then
			if v.hasNormal then table.insert(ohungiSorted.normals, v.name) end
			if v.hasAlt then table.insert(ohungiSorted.alts, v.name) end
			addCharacterToList(v.name, "dad")
		end
	end

    math.randomseed(os.time())

    -- STUPID SHIT GOING ON RN

    local lastEventTime = 0
    local lastIsAlt = false
    local lastOhungi = ohungis[0]

    for i = 0, getProperty("noteDataArray.length") - 1 do
        local note = getProperty("noteDataArray["..i.."]")
        
        if note.gottaHit == false then
            local isAlt = (note["noteType"] == "Alt Animation")
			local table = isAlt and ohungiSorted.alts or ohungiSorted.normals
            local eventTime = note.time - 5
            local typeData = note.typeData

            if eventTime - lastEventTime > crochet or isAlt ~= lastIsAlt or typeData ~= nil then
                addEvent("Change Character", "Dad", typeData or table[math.random(#table)], eventTime)
                
                if isAlt == lastIsAlt then lastEventTime = eventTime end
                lastIsAlt = isAlt
                lastOhungi = chosenOhungi
            end
        end
    end

    sortEvents()
end

function getOhungiViaName(name)
    for _, ohungi in pairs(ohungis) do
        if ohungi.name == name then return ohungi end
    end

    return nil
end