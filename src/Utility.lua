--[[
    This file contains functions that may be used anywhere
]]


-- Checks collision between a circle and a rectangle
-- Based on: https://www.jeffreythompson.org/collision-detection/circle-rect.php
function CircleRect_Collision(circle, rect)

    local testX, testY = circle.x, circle.y

    if circle.x < rect.x then
        testX = rect.x
    elseif circle.x > rect.x + rect.width then
        testX = rect.x + rect.width
    end

    if circle.y < rect.y then
        testY = rect.y
    elseif circle.y > rect.y + rect.height then
        testY = rect.y + rect.height
    end


    local distX = circle.x - testX
    local distY = circle.y - testY
    local distance = math.sqrt(distX*distX + distY*distY)

    return distance <= circle.radius - 2 -- 2 pixels of tolerance
end


-- Checks collision between two circles
function CircleCircle_Collision(c1, c2)

    return distance(c1.x, c1.y, c2.x, c2.y) <= (c1.radius + c2.radius) - 2 -- 2 pixels of tolerance
end


-- Return the distance between two points
function distance(x1, y1, x2, y2)

    local diff_X = x2 - x1
    local diff_Y = y2 - y1

    return math.sqrt(diff_X*diff_X + diff_Y*diff_Y)
end