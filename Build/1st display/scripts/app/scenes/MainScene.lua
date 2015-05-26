require("app.GameData")
ClassGameDirector = require("app.GameObject.GameDirector")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:initControl()
    self:initBack()
    gameDirector = ClassGameDirector.new()
    gameDirector:init(self);
    self:initUpdate()
end

function MainScene:initControl()
	local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
        function(event)
            return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
        end
        )
    layer:setTouchSwallowEnabled(false)
    self:addChild(layer)
end

function MainScene:initBack()
	local imgBack = display.newSprite("myback.png")
	imgBack:setAnchorPoint(ccp(0,0))
	self:addChild(imgBack)
end

function MainScene:initUpdate()
	self._scheduler = require("framework.scheduler")
    self._scheduler.scheduleGlobal(handler(self, self.update), 1/GameData.fps)
end

function MainScene:update()
	gameDirector:update()
end

function MainScene:onTouch(name,x,y,prevX,prevY)
	if name == TouchEventString.began then
        gameDirector:addBullet(ccp(x,y))
    end

    if name == TouchEventString.moved then
        gameDirector:prepareBullet(ccp(x,y))
    end
    if name == TouchEventString.ended then
        gameDirector:ejectBullet(ccp(x,y))
    end
	return true
end

--Call when create if no start action in onExitTransitionDidStart()
function MainScene:onEnter()
end

--Call when exit the current layer, mainly do some work to clear
function MainScene:onExit()
end

return MainScene
