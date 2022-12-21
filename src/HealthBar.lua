HealthBar = Class{}


function HealthBar:init(maxHealth, currentHealth, autoHeal_Amount, autoHeal_Cooldown)

    self.maxHealth = maxHealth
    self.currentHealth = currentHealth or maxHealth

    self.autoHeal_Amount = autoHeal_Amount -- Healing per second
    self.autoHeal_Cooldown = autoHeal_Cooldown
    self.autoHeal_Timer = self.autoHeal_Cooldown
end


function HealthBar:update(dt)

    if not self.autoHeal_Cooldown or self.currentHealth == self.maxHealth then
        return
    end

    self.autoHeal_Timer = math.max(0, self.autoHeal_Timer - dt)
    if self.autoHeal_Timer == 0 then
        
        self:heal(self.autoHeal_Amount * dt)
        self.autoHeal_Timer = self.autoHeal_Cooldown
    end
end


function HealthBar:render(x, y, width, height)

    love.graphics.setColor(255/255, 6/255, 0/255, 1)

    love.graphics.rectangle('fill', x, y, (self.currentHealth/self.maxHealth) * width, height)
end


---------------------------------------
---------------------------------------
---------------------------------------


function HealthBar:damage(amount)

    self.currenthealth = math.max(0, self.currenthealth - amount)
    self.autoHealTimer = self.autoHeal_Cooldown
end


function HealthBar:heal(amount)

    self.currenthealth = math.min(self.currenthealth + amount, self.maxHealth)
    if self.currentHealth == self.maxHealth then
        
        self.autoHeal_Timer = self.autoHeal_Cooldown
    end
end