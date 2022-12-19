FollowerFollowState = Class{__includes = BaseState}


function FollowerFollowState:init(follower)

    self.follower = follower

    local diff_X = gPlayer.x - follower.x
    local diff_Y = gPlayer.y - follower.y
    local hypot = math.sqrt(diff_X*diff_X + diff_Y*diff_Y)

    local velocity = math.random(200, 500)
    self.xVelocity = velocity * (diff_X/hypot)
    self.yVelocity = velocity * (diff_Y/hypot)

    self.destination_X = gPlayer.x
    self.destination_Y = gPlayer.y
end


function FollowerFollowState:update(dt)

    self.follower.x = self.follower.x + self.xVelocity * dt
    self.follower.y = self.follower.y + self.yVelocity * dt

    -- Only one axis needs to be looked at
    if (self.xVelocity < 0 and self.follower.x <= self.destination_X)
    or (self.xVelocity > 0 and self.follower.x >= self.destination_X) then
        
        self.follower.x = self.destination_X
        self.follower.y = self.destination_Y
        self.follower.state:change('idle')
    end
end