FollowerIdleState = Class{__includes = BaseState}


function FollowerIdleState:init(follower)

    self.follower = follower

    self.idleTime = math.random(2, 5) -- Time in seconds
    self.timer = 0
end


function FollowerIdleState:update(dt)

    self.timer = self.timer + dt
    if self.timer >= self.idleTime then

        self.follower.state:change('follow')
    end
end