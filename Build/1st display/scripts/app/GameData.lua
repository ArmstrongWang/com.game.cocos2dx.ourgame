TouchEventString = TouchEventString or {} --------鼠标事件名称
TouchEventString.began = "began"
TouchEventString.moved = "moved"
TouchEventString.ended = "ended"
TouchEventString.canceled = "canceled"

GameData = GameData or {}
GameData.fps = 30
GameData.bulletStartPos = ccp(100,CONFIG_SCREEN_HEIGHT*2/3)
GameData.bulletAcc = 10
GameData.addEnemyInterval = 80
GameData.enemyR = 100
GameData.bulletR = 105
GameData.rectScreen = {left = -10, right = CONFIG_SCREEN_WIDTH+10, top = CONFIG_SCREEN_HEIGHT, bottom = -10}



State = State or {}
State.prepare = 1
State.move = 2
State.burst = 3
State.null = 4