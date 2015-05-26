function getRandomInt(s,e)
	return math.random(s,e)
end

function getRandomFloat(s,e)
	return math.random()*(e-s)+s
end

function arcSin(sinValue,x)
	if x and x >= 0 then
		return math.deg(math.asin(sinValue))
	else
		return -math.deg(math.asin(sinValue)) + 180
	end
end

function arcCos(cosValue,y)
	if y and y >=0 then
		return math.deg(math.acos(cosValue))
	else
		return -math.deg(math.acos(cosValue))
	end
end

function getDistance(node1,node2)
	local detX = node1:getPositionX() - node2:getPositionX()
	local detY = node1:getPositionY() - node2:getPositionY()
	local distance = math.sqrt(detX * detX + detY * detY)
	return distance
end

function getAngle(fromPos,toPos,distance)
	local detX = toPos.x - fromPos.x
	local detY = toPos.y - fromPos.y	
	if not distance then
		distance = math.sqrt(detX * detX + detY * detY)
	end
	local sinValue = detY/distance
	return arcSin(sinValue,detX)
end

function moveCCnode(ccnode,x,y)
	local pos = ccnode:getPositionInCCPoint()
	pos.x = pos.x + x
	pos.y = pos.y + y
	ccnode:setPosition(pos)
	return pos
end

function ejectCCNode(ccnode,x,y)
	local pos = ccnode:getPositionInCCPoint()
	pos.x = pos.x + x
	pos.y = pos.y + y
	ccnode:setPosition(pos)
end

function getDistanceParams(fromPos,toPos)
	local detX = toPos.x - fromPos.x
	local detY = toPos.y - fromPos.y
	local distance = math.sqrt(detX * detX + detY * detY)
	if distance == 0 then
		return 0,1,0
	end
	local sinValue = detY/distance
	local cosValue = detX/distance
	return sinValue,cosValue,distance
end

function getSpeedXY(fromPos,toPos,speed)
	local sin,cos,distance = getDistanceParams(fromPos,toPos)
	local spdX = speed * cos
	local spdY = speed * sin
	return spdX,spdY,distance
end

function hitR2R(rect1,rect2)
	if rect1 and rect2 then
		if rect1.right > rect2.left and rect1.left < rect2.right and rect1.top > rect2.bottom and rect1.bottom < rect2.top then
			return true
		end
	end
	return false
end

function hitR2P(rect,pos)
	if pos.x >= rect.left and pos.x <= rect.right and pos.y >= rect.bottom and pos.y <= rect.top then
		return true
	end
	return false
end

function updateObjectList(list)
    local i = 1
    local count = #list
    while i <= count do
        local obj = list[i]
        if obj:update() then
            table.remove(list,i)
            obj:removeSelf()
            print("remove")
            count = count - 1
        else
            i = i + 1
        end
    end
    return count
end