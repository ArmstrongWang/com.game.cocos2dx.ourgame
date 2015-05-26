ClassBullet = require("app.GameObject.Bullet")
ClassEnemy = require("app.GameObject.Enemy")

local GameDirector = class("GameDirector")

function GameDirector:ctor()

end

function GameDirector:init(scene)
	self:initBullet(scene)
	self:initEnemy(scene)
	self._addEnemyInterval = GameData.addEnemyInterval
end

function GameDirector:initBullet(scene)
	self._listBullet = {}
	self._layerBullet = display.newNode()
	scene:addChild(self._layerBullet)
end

function GameDirector:addBullet(desPos)
	local bullet = ClassBullet.new()
	table.insert(self._listBullet, bullet)
	bullet:init(desPos)
	self._layerBullet:addChild(bullet)
	print("began",desPos.x,desPos.y)
end

function GameDirector:prepareBullet(desPos)
	self._listBullet[#self._listBullet]:prepare(desPos)
end

function GameDirector:ejectBullet(desPos)
	self._listBullet[#self._listBullet]:eject(desPos)
end


function GameDirector:initEnemy(scene)
	self._listEnemy = {}
	self._layerEnemy = display.newNode()
	scene:addChild(self._layerEnemy)
end

function GameDirector:addEnemy()
	local enemy = ClassEnemy.new()
	table.insert(self._listEnemy, enemy)
	enemy:init();
	self._layerEnemy:addChild(enemy)
end

function GameDirector:update()
	-- Add Enemy dynamicly
	self._addEnemyInterval = self._addEnemyInterval - 1
	if self._addEnemyInterval <= 0 then
		self._addEnemyInterval = GameData.addEnemyInterval
		self:addEnemy()
	end
	-- Bullet update
	updateObjectList(self._listBullet)
	-- Enemy update
	updateObjectList(self._listEnemy)
end

return GameDirector