function createColorFrame(numFrame, r, g, b) 
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetFrameStrata("BACKGROUND")
    frame:SetWidth(15) 
    frame:SetHeight(15) 
    frame.texture = frame:CreateTexture(nil,"BACKGROUND")
    frame.texture:SetAllPoints(frame)
    frame:SetPoint("TOPLEFT", numFrame * 15, 0)
    frame:Show()
    frame.texture:SetColorTexture(r, g, b)

    return frame
end

function integerToColor(i)
    local b = i % 256
    i = math.floor(i / 256)
    local g = i % 256
    i = math.floor(i / 256)
    local r = i % 256

    return r / 255, g / 255, b / 255
end

function getPlayerPosition()
    local map = C_Map.GetBestMapForUnit("player")
    local position = C_Map.GetPlayerMapPosition(map, "player")
    return position
end

SLASH_HELLO_WORLD1 = '/test';
function SlashCmdList.HELLO_WORLD(msg, editbox)
    local facing = GetPlayerFacing()
	local position = getPlayerPosition()
	print(format("x: %.2f y: %.2f facing: %.2f", position.x*100, position.y*100, facing)); 
end

createColorFrame(1, 1, 0, 1) -- calibration
local playerXPos = createColorFrame(2, 0.5, 0.5, 0.5)
createColorFrame(3, 1, 0, 1) -- calibration
local playerYPos = createColorFrame(4, 0.5, 0.5, 0.5)
createColorFrame(5, 1, 0, 1) -- calibration
local playerHealth = createColorFrame(6, 0.1, 0.1, 0.1)
createColorFrame(7, 1, 0, 1) -- calibration
local playerMaxHealth = createColorFrame(8, 0.1, 0.1, 0.1)
createColorFrame(9, 1, 0, 1) -- calibration
local generalInfo = createColorFrame(10, 0.1, 0.1, 0.1)
createColorFrame(11, 1, 0, 1) -- calibration
local targetHealth = createColorFrame(12, 0.1, 0.1, 0.1)
createColorFrame(13, 1, 0, 1) -- calibration
local targetMaxHealth = createColorFrame(14, 0.1, 0.1, 0.1)
createColorFrame(15, 1, 0, 1) -- calibration

playerXPos:SetScript("OnUpdate", function () 
    local position = getPlayerPosition()
    local x1, x2 = math.modf(position.x * 255)
    local y1, y2 = math.modf(position.y*255)
    local inCombat = 0
    local canAttack = 0
    if (UnitAffectingCombat("player")) then
        inCombat = 1
    end

    if (UnitCanAttack("player", "target")) then
        canAttack = 1
    end

    playerXPos.texture:SetColorTexture(x1/255, x2, GetPlayerFacing() / 7)
    playerYPos.texture:SetColorTexture(y1/255, y2, inCombat)
    playerHealth.texture:SetColorTexture(integerToColor(UnitHealth("player")))
    targetHealth.texture:SetColorTexture(integerToColor(UnitHealth("target")))
    targetMaxHealth.texture:SetColorTexture(integerToColor(UnitHealthMax("target")))
end)

-- General info
generalInfo.texture:SetColorTexture(UnitLevel("player") / 255, UnitLevel("target") / 255, _)

-- Player health
playerMaxHealth.texture:SetColorTexture(integerToColor(UnitHealthMax("player")))
playerMaxHealth:RegisterEvent("PLAYER_LEVEL_UP")
playerMaxHealth:SetScript("Onevent", function (_, _, _) 
    generalInfo.texture:SetColorTexture(UnitLevel("player") / 255, _, _)
    playerMaxHealth.texture:SetColorTexture(integerToColor(UnitHealthMax("player")))
end)
