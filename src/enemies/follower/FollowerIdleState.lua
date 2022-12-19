FollowerIdleState = Class{__includes = BaseState}


function FollowerIdleState:init(follower)

    self.follower = follower

    self.timer = math.random(2, 5) -- Time in seconds
end


function FollowerIdleState:update(dt)

    self.timer = self.timer - dt
    if self.timer <= 0 then

        self.follower.state:change('follow')
    end
end