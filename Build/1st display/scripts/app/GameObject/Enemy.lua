local Enemy = class("Enemy", function ()
	return display.newScene("Enemy")
end)

function Enemy:ctor()
	local imgEnemy = display.newSprite("myenemy.png")
	local scale = getRandomFloat(0.2, 0.4)
	self:setScale(scale)
	self._r = GameData.enemyR * scale
	self:addChild(imgEnemy)
	self:setAnchorPoint(ccp(0,0))
	self._speed = getRandomFloat(6,9)
	local y = 50
	local x = CONFIG_SCREEN_WIDTH
	self:setState(State.move)
	self:pos(x,y)
end

function Enemy:init()
	-- body
end

function Enemy:setState(state)
	self._state = state
	if state == State.burst then
		self:toBurst()
	end
end

function Enemy:toBurst()
	local function callback()
		self:setState(State.null)
	end
    local seq = transition.sequence({
        CCScaleTo:create(0.5, 0)
        , CCCallFunc:create(callback)
        })
    self:runAction(seq)
end

function Enemy:update()
	if self._state == State.move then
		moveCCnode(self, -self._speed, 0)
		if not hitR2P(GameData.rectScreen, self:getPositionInCCPoint()) then		
			self:setState(State.null)
		end
	elseif self._state == State.null then
		return true
	end
end

return Enemy