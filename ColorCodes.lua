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
createColorFrame(6, 0.1, 0.1, 0.1)
createColorFrame(7, 1, 0, 1) -- calibration


playerXPos:SetScript("OnUpdate", function () 
    local position = getPlayerPosition()
    local x1, x2 = math.modf(position.x * 255)
    local y1, y2 = math.modf(position.y*255)
    local inCombat = 0
    if (UnitAffectingCombat("player")) then
        inCombat = 1
    end

    playerXPos.texture:SetColorTexture(x1/255, x2, GetPlayerFacing() / 7)
    playerYPos.texture:SetColorTexture(y1/255, y2, inCombat)
end)
