PlayState = Class{__includes = BaseState}



function PlayState:init()
    gPlayer = Player()

    self.enemies = {}
    self.objects = {} -- Bombs and any other similar objects that may be created in the future

    -- Game starts with 3 enemies
    for i = 1, 3, 1 do
    
        InstantiateNewEnemy(self.enemies, self.objects)
    end
    self.enemySpawnTime = math.random(1, 3)


    self.stopwatch = 0
end



function PlayState:update(dt)

    self.stopwatch = self.stopwatch + dt

    -- Enemies handling:
    -- -> Spawn/Instantiate
    -- -> Update
    -- -> Removal
    self.enemySpawnTime = self.enemySpawnTime - dt
    if self.enemySpawnTime <= 0 then
        
        InstantiateNewEnemy(self.enemies, self.objects)
        self.enemySpawnTime = math.random(1, 3)
    end

    --[[
        Collisions check

        First -> Checks collision between Player and enemies (damage Player + Game Over checking)
        Second -> Checks collision between Player Projectiles and enemies (damage enemies)
        Third -> Checks collision between Player and objects (damage Player + Game Over checking)
   
        -------------

        Enemies/Objects removal
    ]]
    -- player update
    gPlayer:update(dt)

    -- Enemies handling
    local toRemove = {} -- Indexes of enemies/objects to be removed
    local removed = 0   -- Number os removed enemies/objects
    for i, enemy in pairs(self.enemies) do

        enemy:update(dt)
    
        if enemy:collides(gPlayer) then
            
            gPlayer.healthBar:damage(1)
        end

        ----------------

        for j, projectile in pairs(gPlayer.projectiles) do
        
            if enemy:collides(projectile) then
                
                enemy.healthBar:damage(1)
                if enemy.healthBar.currentHealth == 0 then
                    
                    table.insert(toRemove, i --[[enemy index]])
                end

                break -- It isn't possible for an enemy to collide with more than one projectile at a time
            end
        end
    end

    for i, index in pairs(toRemove) do
    
        table.remove(self.enemies, index - removed)
        removed = removed + 1
    end

    
    -- Objects handling
    toRemove = {}
    removed = 0
    for i, object in pairs(self.objects) do
    
        object:update(dt)

        if object:collides(gPlayer) then
            
            gPlayer.healthBar:damage(1)
        end

        if object.remove then
            
            table.insert(toRemove, i)
        end
    end

    for i, index in pairs(toRemove) do
    
        table.remove(self.objects, index - removed)
        removed = removed + 1
    end
    
    ---------------------
    ---------------------
end



function PlayState:render()

    for i, object in pairs(self.objects) do
    
        object:render()
    end

    for i, enemy in pairs(self.enemies) do
    
        enemy:render()
    end

    gPlayer:render()


    -- Stopwatch rendering
    local min = string.format("%d", self.stopwatch / 60)
    local sec = string.format("%d", self.stopwatch % 60)
    local ms = string.format("%d", (self.stopwatch - math.floor(self.stopwatch)) * 1000)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(min .. 'min ' .. sec .. 'sec ' .. ms .. 'ms', 10, 10)
end


---------------------------------------------
---------------------------------------------
---------------------------------------------


function InstantiateNewEnemy(enemiesTable, objectsTable)

    local enemies = {
        function() return Follower() end,
        function() return Bomber(objectsTable) end
    }

    table.insert(enemiesTable, enemies[math.random(1, #enemies)]())
end