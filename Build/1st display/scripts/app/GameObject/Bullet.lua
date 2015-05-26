require("app.GameFunction")

local Bullet = class("Bullet", function ()
	return display.newScene("Bullet")
end)

function Bullet:ctor()
	local imgBullet = display.newSprite("mybullet.png")
	local scale = 0.1
	self:setScale(scale)
	self._r = GameData.bulletR * scale
	self:setPosition(GameData.bulletStartPos)
	self:setAnchorPoint(ccp(0,0))
	self:addChild(imgBullet)
end

function Bullet:init(desPos)
	self._initPos = desPos
	self:setState(State.prepare)

end

function Bullet:setState(state)
	self._state = state
	if state == State.burst then
		self:toBurst()
	end
end

function Bullet:prepare(curPos)
	if self._state == State.prepare then
		self:setPosition(curPos)
		print("move",curPos.x,curPos.y)
	end
end

function Bullet:eject(curPos)
	self._endPos = curPos
	local sinValue
	local cosValue
	local distance
	local isUp = 1
	if  self._endPos.y >= GameData.bulletStartPos.y then
		isUp = -1
	end
	sinValue,cosValue,distance = getDistanceParams(self._endPos, GameData.bulletStartPos)
	self._initSpeed = distance * 0.5
	self._initSpeedX = math.abs(self._initSpeed * cosValue)
	self._initSpeedY = math.abs(self._initSpeed * sinValue )* isUp
	self:setState(State.move)
	print("end",curPos.x,curPos.y)
end


function Bullet:update()
	if self._state == State.move then
		self._initSpeedY = self._initSpeedY - GameData.bulletAcc
		ejectCCNode(self, self._initSpeedX, self._initSpeedY)
		self:hitEnemy()
		if not hitR2P(GameData.rectScreen, self:getPositionInCCPoint()) then		
			self:setState(State.null)
		end
	elseif self._state == State.null then
		return true
	end
end

function Bullet:toBurst()
	local function callback()
		self:setState(State.null)
	end
    local seq = transition.sequence({
        CCScaleTo:create(0.5, 0)
        , CCCallFunc:create(callback)
        })
    self:runAction(seq)
end

function Bullet:hitEnemy()
	for i,enemy in ipairs(gameDirector._listEnemy) do
		if enemy._state == State.move then
			local distance = getDistance(self,enemy)
			if distance < self._r + enemy._r then
				enemy:setState(State.burst)
				self:setState(State.burst)
				return true
			end
		end
	end
	return false
end

return Bullet