Zombie = {}
Zombie.__index = Zombie
local frameDelay = 100
local totalFrames = 4

function Zombie:Init(x, y, fH, fV, direction)

    local _zombie = {
        hitRect = NewRect( x, y, SpriteSize().X, SpriteSize().Y * 2 ),
        flipH = fH or false,
        flipV = fV or false,
        drawMode = DrawMode.Sprite,
        type = TYPE_ZOMBIE,
        speed = .3,
        movement = {
            Up = false,
            Down = false,
            Left = false,
            Right = false
        },
        -- out of display flag
        outBound = false,
        metaSprite = "zombie-",
        frame = 1,
        frameTime = 0,
    }


    if direction == 1 then
        _zombie.movement.Up = true
    end

    if direction == 2 then
        _zombie.movement.Down = true
    end

    if direction == 3 then
        _zombie.movement.Left = true
    end

    if direction == 4 then
        _zombie.movement.Right = true
    end

    setmetatable(_zombie, Zombie)

    return _zombie

end

function Zombie:GetPosition()
    return self.hitRect
end

function Zombie:Update(timeDelta)

    if self.movement.Up then
        self.hitRect.Y = self.hitRect.Y - 1
    end

    if self.movement.Down then
        self.hitRect.Y = self.hitRect.Y + 1
    end

    if self.movement.Left then
        self.hitRect.X = self.hitRect.X - 1
    end

    if self.movement.Right then
        self.hitRect.X = self.hitRect.X + 1
    end
  
    if self.hitRect.X < CANVASX_MIN or self.hitRect.X > CANVASX_MAX + 20 or
       self.hitRect.Y < CANVASY_MIN or self.hitRect.Y > CANVASY_MAX + 20 then
        self.outBound = true
    end

    -- process frame
    self.frameTime += timeDelta
    if( self.frameTime > frameDelay) then
        self.frameTime = 0
        self.frame += 1
        if( self.frame > totalFrames ) then
            self.frame = 1
        end
    end
end

function Zombie:Draw()
    DrawMetaSprite( self.metaSprite .. self.frame, self.hitRect.X, self.hitRect.Y )
end