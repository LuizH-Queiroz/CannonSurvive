--[[
    This file contains functions that may be used anywhere
]]


-- Checks collision between a circle and a rectangle
function RectCircle_Collision(rect, circle)

    local testX, testY = rect.x, rect.y

    if rect.x < circle.x then
        testX = circle.x
    elseif rect.x > circle.x + circle.width then
        testX = circle.x + circle.width
    end

    if rect.y < circle.y then
        testY = circle.y
    elseif rect.y > circle.y + circle.height then
        testY = circle.y + circle.height
    end


    local distX = rect.x - testX
    local distY = rect.y - testY
    local distance = math.sqrt(distX*distX + distY*distY)

    return distance <= rect.radius - 2 -- 2 pixels of tolerance
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