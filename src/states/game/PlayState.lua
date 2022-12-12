PlayState = Class{__includes = BaseState}



function PlayState:init()
    gPlayer = Player()

    self.enemies = {
        Follower()
    }
    self.enemySpawnTime = math.random(5, 8)
end



function PlayState:update(dt)
    -- player update
    gPlayer:update(dt)


    -- Enemies handling:
    -- -> Spawn
    -- -> Update
    -- -> Removal (TODO)
    self.enemySpawnTime = self.enemySpawnTime - dt
    if self.enemySpawnTime <= 0 then
        
        InstantiateNewEnemy(self.enemies)
        self.enemySpawnTime = math.random(1, 3)
    end

    for i, enemy in pairs(self.enemies) do

        enemy:update(dt)
    end
end



function PlayState:render()
    gPlayer:render()

    for i, enemy in pairs(self.enemies) do
    
        enemy:render()
    end
end



function InstantiateNewEnemy(enemiesTable)

    local enemies = {
        [1] = function() return Follower() end
    }

    table.insert(enemiesTable, enemies[math.random(1, #enemies)]())
end