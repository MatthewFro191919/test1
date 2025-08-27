local portalFrequency = 10
local portalCount = 0
local portalTimerStarted = false

local portalXStart = 500
local portalXEnd = 2400
local portalYStart = 200
local portalYEnd = 500
local sizeStart = 0.5
local sizeEnd = 1.7

local portalList = {}

function onCreatePost()
   if not isStoryMode then
      close(false)
      return
   end

   preloadPortals()
end

function onUpdate(elapsed)
   for key, value in pairs(portalList) do
      local curAnimName = value[1]..'.animation.curAnim.name'

      if getProperty(curAnimName) == 'open' and getProperty(value[1]..'.animation.curAnim.finished') == true then
         playAnim(value[1], 'loop', true)
      end
      if getProperty(curAnimName) == 'loop' and value[2] < 0 then
         playAnim(value[1], 'end', true)
      end
      if getProperty(curAnimName) == 'end' and getProperty(value[1]..'.animation.curAnim.finished') == true then
         removeLuaSprite(value[1], false)
         table.remove(portalList, key)
      end

      if value[2] > 0 and getProperty(curAnimName) == 'loop' then
         value[2] = value[2] - elapsed
      end
   end
   if getProperty('preloadPortal.animation.curAnim.finished') == true then
      removeLuaSprite('preloadPortal')
   end
end

local firstPortal = false
local firstPortalStep = 816
function onStepHit()
	if curStep < firstPortalStep then
		return
	end
	if not firstPortal and curStep >= firstPortalStep then
		firstPortal = true
		generatePortal(lerp(portalXStart, portalXEnd, .5), lerp(portalYStart, portalYEnd, .75), stepsToSeconds(20))
		return
	end
   if curStep > 784 and portalTimerStarted == false then
	local portalFrequency = portalFrequency * 1.3
      portalTimerStarted = true
      runTimer("portal", getRandomFloat(portalFrequency / getRandomFloat(1, 1.8), portalFrequency * getRandomFloat(1, 1.5)), 0)
   end
   if curStep > 1871 then
      cancelTimer('portal')
      close(false)
   end
   if curStep > 784 and curStep < 1200 then
      portalFrequency = 8
   end
   if curStep > 1199 and curStep < 1472 then
      portalFrequency = 6
   end
   if curStep > 1471 and curStep < 1728 then
      portalFrequency = 5
   end
   if curStep > 1727 and curStep < 1744 then
      portalFrequency = 4
   end
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'portal' and curStep < 1216 then
      generatePortal()
   end
end

function generatePortal(posx, posy, time)
   local portalName = 'portal'..portalCount
   local portalData = {portalName, time or getRandomFloat(3, 6)}
   
   portalCount = portalCount + 1

   makeAnimatedLuaSprite(portalName, 'stages/daveBackyard/unstable_portal', posx or getRandomFloat(portalXStart, portalXEnd), posy or getRandomFloat(portalYStart, portalYEnd))

   addAnimationByIndices(portalName, 'open', 'unstableportalfinal instance 1', getPortalIndices('open'), 24, false)
   addAnimationByIndicesLoop(portalName, 'loop', 'unstableportalfinal instance 1', getPortalIndices('loop'), 24)
   addAnimationByIndices(portalName, 'end', 'unstableportalfinal instance 1', getPortalIndices('end'), 24, false)

   setGraphicSize(portalName, getProperty(portalName..'.width') * getRandomFloat(sizeStart, sizeEnd), getProperty(portalName..'.height') * getRandomFloat(sizeStart, sizeEnd))
   
   playAnim(portalName, 'open', true)
   addLuaSprite(portalName)
   
   table.insert(portalList, portalData)
end

function preloadPortals()
   makeAnimatedLuaSprite('preloadPortal', 'stages/daveBackyard/unstable_portal', 100, 100)
   addAnimationByPrefix('preloadPortal', 'test', 'unstableportalfinal instance 1', 24, false)
   playAnim('preloadPortal', 'test', true)

   setScrollFactor('preloadPortal', 0, 0)
   screenCenter('preloadPortal')
   setProperty('preloadPortal.alpha', 0.0001)

   addLuaSprite('preloadPortal')
end

function getPortalIndices(value)
   local sValue = 0
   local eValue = 0
   local numbers = {}

   if value == 'open' then 
      sValue = 0
      eValue = 61 
   elseif value == 'loop' then
      sValue = 62
      eValue = 120
   elseif value == 'end' then
      sValue = 120
      eValue = 143
   end

   for i = sValue, eValue do
      table.insert(numbers, i)
   end
   return numbers
end