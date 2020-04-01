//
//  GameScene.swift
//  GumBalls
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameStatus{
    case idle
    
    case running
    
    case next
    
    case over
}

class GameScene: SKScene {
    
    var backGround = SKSpriteNode()
    var floorSize = CGSize()
    //var music = SKAction.playSoundFileNamed("bgm_workshop.mp3", waitForCompletion: false)
    
    /*before the level the data should be exsited*/

    var gumBall = GumBall(life: gameData.gumBallData.life, magic: gameData.gumBallData.magic, physicAttack: gameData.gumBallData.physicAttack, magicAttack: gameData.gumBallData.magicAttack, explore: gameData.gumBallData.explore)
    var gumBallLevelUp = GumBallLevelUp()
    var package = Package()
    var reel = Reel()
    var packageDetail = PackageDetail()
    var reelDetail = ReelDetail()
    let shadowNode = SKSpriteNode()
    let tempPropNode = SKSpriteNode()
    var allFloor = [floor]()

    /*the data should be exsited all the way*/

    var gameStartNode = SKLabelNode()
    
    func stopAllAction(){
        for node in self.children{
            node.removeAllActions()
        }
        self.removeAllChildren()
    }
    
    func addStartNode(){
        gameStartNode.fontName = "Chalkduster"
        gameStartNode.text = """
        开始游戏
        """
        gameStartNode.fontSize = 30
        gameStartNode.fontColor = SKColor.black
        gameStartNode.position = CGPoint(x: frame.midX, y: frame.midY-self.size.width*0.24)
        //gameStartNode.numberOfLines = 2
           
        addChild(gameStartNode)
    }
    
    func shuffle(){
        //游戏的初始化过程
        addStartNode()
        gameData.gameStatus = .idle
        
    }
    
    func searchOneFloor(num:Int)->Int{
        if allFloor[num].coverUp{
            return 1
        }else if allFloor[num].floorType == .isMonster{
            return 2
        }else{
            return 3
        }
    }
    
    func calculateTheFloorStatus(num:Int)->Bool{
        var coverUp = 0
        if num == 0{
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+6) == 2{return false}else if searchOneFloor(num: num+6) == 1{coverUp = coverUp + 1}
            if coverUp == 3{return false}
        }else if num == 4{
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+4) == 2{return false}else if searchOneFloor(num: num+4) == 1{coverUp = coverUp + 1}
            if coverUp == 3{return false}
        }else if num == 25{
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-4) == 2{return false}else if searchOneFloor(num: num-4) == 1{coverUp = coverUp + 1}
            if coverUp == 3{return false}
        }else if num == 29{
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-6) == 2{return false}else if searchOneFloor(num: num-6) == 1{coverUp = coverUp + 1}
            if coverUp == 3{return false}
        }else if num > 25 && num < 29 {
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-6) == 2{return false}else if searchOneFloor(num: num-6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-4) == 2{return false}else if searchOneFloor(num: num-4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if coverUp == 5{return false}
        }else if num%5 == 0{
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+6) == 2{return false}else if searchOneFloor(num: num+6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-4) == 2{return false}else if searchOneFloor(num: num-4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if coverUp == 5{return false}
        }else if num%5 == 4{
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+4) == 2{return false}else if searchOneFloor(num: num+4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-6) == 2{return false}else if searchOneFloor(num: num-6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if coverUp == 5{return false}
        }else if num > 0 && num < 4{
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+4) == 2{return false}else if searchOneFloor(num: num+4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+6) == 2{return false}else if searchOneFloor(num: num+6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if coverUp == 5{return false}
        }else{
            if searchOneFloor(num: num-1) == 2{return false}else if searchOneFloor(num: num-1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+1) == 2{return false}else if searchOneFloor(num: num+1) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+4) == 2{return false}else if searchOneFloor(num: num+4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+6) == 2{return false}else if searchOneFloor(num: num+6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-6) == 2{return false}else if searchOneFloor(num: num-6) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-4) == 2{return false}else if searchOneFloor(num: num-4) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num-5) == 2{return false}else if searchOneFloor(num: num-5) == 1{coverUp = coverUp + 1}
            if searchOneFloor(num: num+5) == 2{return false}else if searchOneFloor(num: num+5) == 1{coverUp = coverUp + 1}
            if coverUp == 8{return false}
        }
        return true
    }
    
    func setTheFloorOpenStatus(){
        for i in 0..<30{
            if allFloor[i].coverUp == true{
                if !calculateTheFloorStatus(num: i){
                    allFloor[i].alpha = 0.6
                }else{
                    allFloor[i].alpha = 1.0
                }
            }else{
                allFloor[i].alpha = 1.0
            }
        }
    }
    
    func createTheFloorInterface(){
        for i in 0..<30{
            allFloor[i].size = CGSize(width: self.size.width*0.20, height: self.size.width*0.21)
            allFloor[i].position = CGPoint(x: (Double)(self.size.width)*(0.2*(Double)(i%5+1)-0.1), y: (Double)(self.size.height)*((Double)(i/5+1)*0.10+0.15))
            addChild(allFloor[i])
            if allFloor[i].floorType == .isdoor{
                allFloor[i].flipImmediately()
            }
        }
        setTheFloorOpenStatus()
    }
    
    func creatTheLevelInterFace(){
        
        backGround.isHidden = false
        
        gameStartNode.numberOfLines = 2
        gameStartNode.text = """
        迷宫第\(gameData.level)层          探索点：\(gameData.gumBallData.explore)
              您的最大探索层数为：\(gameData.maxLevel)层
        """
        gameStartNode.fontSize = 20
        gameStartNode.fontColor = SKColor.green
        gameStartNode.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.9)
        
        gumBall.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.08)
        gumBall.size = CGSize(width: self.size.width*0.18, height: self.size.width*0.18)
        addChild(gumBall)
        
        gumBallLevelUp.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        gumBallLevelUp.size = CGSize(width: self.size.width*0.5, height: self.size.width*0.5)
        addChild(gumBallLevelUp)
        
        package.position = CGPoint(x: self.size.width*0.2, y: self.size.height*0.08)
        package.size = CGSize(width: self.size.width*0.18, height: self.size.width*0.18)
        addChild(package)
        
        reel.position = CGPoint(x: self.size.width*0.8, y: self.size.height*0.08)
        reel.size = CGSize(width: self.size.width*0.18, height: self.size.width*0.18)
        addChild(reel)
        
        packageDetail.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        packageDetail.size = CGSize(width: self.size.width*0.8, height: self.size.width*0.8)
        addChild(packageDetail)
        packageDetail.isHidden = true
        
        reelDetail.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        reelDetail.size = CGSize(width: self.size.width*0.8, height: self.size.width*0.8)
        addChild(reelDetail)
        reelDetail.isHidden = true
        
        shadowNode.color = SKColor.black
        shadowNode.alpha = 0.6
        shadowNode.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        shadowNode.size = self.size
        shadowNode.zPosition = 999
        addChild(shadowNode)
        shadowNode.isHidden = true
    }
    
    func startGame(){
        //游戏的开始过程
        creatTheLevelInterFace()
        //backGround.isHidden = false
        self.removeChildren(in: [backGround])
        backGround = SKSpriteNode(imageNamed: "background")
        backGround.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        backGround.zPosition = -1
        addChild(backGround)
        music.playBackMusic()
        createTheFloor()
        createTheFloorInterface()
        gameData.gameStatus = .running
    }
    
    func recreateTheData(){
        gameData.allProp.removeAll()
        allFloor.removeAll()
        gameData.createTheLevelData()
        createTheFloor()
        gameData.openTheDoor = true
    }
    
    func nextGame(){
        if gameData.monsterNum <= 0{
            gameData.gumBallData.explore = gameData.gumBallData.explore + (Int)((Double)(gameData.level/3+1)*1.35*30)
            updateTheGumBall()
        }
        gameData.monsterNum = 5
        music.plalVictoryMusic()
        gameData.level = gameData.level+1
        gameData.gameStatus = .next
        self.removeChildren(in: allFloor)
        recreateTheData()
        createTheFloorInterface()
        gameData.gameStatus = .running
        gameData.openTheDoor = false
        gameData.nextGame = false
        gameData.gumBallData.life = gameData.gumBallData.life + gameData.lifeAdd
        gameData.gumBallData.magic = gameData.gumBallData.magic + gameData.magicAdd
        updateTheGumBall()
    }
    
    func restartGame(){
        //self.removeAllChildren()
        gameData = dataManager()
        addChild(music)
        music.playLogin()
        backGround = SKSpriteNode(imageNamed: "startBack")
        backGround.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        backGround.size = self.size
        backGround.zPosition = -1
        addChild(backGround)
        floorSize = CGSize(width: self.size.width*0.20, height: self.size.width*0.21)
        addStartNode()
        gameData.gameStatus = .idle

        recreateTheData()
        //createTheFloorInterface()
        //creatTheLevelInterFace()
        //gameData.gameStatus = .running
    }
    
    func gameOver(){
        //游戏失败
        gameData.gameStatus = .over
        self.removeAllChildren()
        removeAllActions()
        addStartNode()
        gameStartNode.numberOfLines = 1
        gameStartNode.text = "Game Over"
    }
    
    func MoveUpDown(node:SKNode){
        let DoAction1 = SKAction.moveBy(x: 0, y: 2, duration: 0.7)
        let DoAction2 = SKAction.moveBy(x: 0, y: -2, duration: 0.5)
        let action = SKAction.sequence([DoAction1,DoAction2])
        node.run(SKAction.repeatForever(action))
    }
    
    func MoveOut(node:SKNode)
    {
        //let rotateAction = SKAction.rotate(byAngle: 1.0, duration: 0.4)
        //node.run(SKAction.repeatForever(rotateAction),withKey: "rotate")
        let DoAction1 = SKAction.moveBy(x: node.position.x, y: node.position.y, duration: 1)
        node.run(DoAction1, completion: {() in
            node.removeAllActions()
            self.removeChildren(in: [node])
        })
    }
    
    func moveTo(node:SKNode,dest:CGPoint,duration:TimeInterval){
        let rotateAction = SKAction.rotate(byAngle: 1.0, duration: 0.4)
        node.run(SKAction.repeatForever(rotateAction),withKey: "rotate")
        let action = SKAction.move(to: dest, duration: duration)
        node.run(action, completion: { () in
            node.removeAllActions()
            self.removeChildren(in: [node])
        })
    }
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        //run(music, withKey: "MainMusic")
        //mainMusic.playBackgroundMusic(filename: "bgm_workshop")
        //addChild(mainMusic)
        addChild(music)
        music.playLogin()
        backGround = SKSpriteNode(imageNamed: "startBack")
        backGround.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        backGround.zPosition = -1
        //backGround.isHidden = true
        addChild(backGround)
        backGround.size = self.size
        floorSize = CGSize(width: self.size.width*0.20, height: self.size.width*0.21)
        if gameData.gameStatus == .idle{
            shuffle()
        }else{
            creatTheLevelInterFace()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameData.gameStatus {
        case .idle:
            for touch in touches{
                if gameStartNode.contains(touch.location(in: self)){
                    startGame()
                }
            }
        case .running:
            //GumBallData.life = GumBallData.life-1
            for touch in touches{
                let tmp = touch.location(in: self)
                let floorNum = whichFloor(touch: tmp)
                if(floorNum != -1) {
                    if allFloor[floorNum].alpha == 1.0{
                        if allFloor[floorNum].zPosition >= gameData.operationLevel{
                            if(allFloor[floorNum].coverUp){
                                allFloor[floorNum].flip()
                                setTheFloorOpenStatus()
                                music.playOpenFloor()
                            }else{
                                switch allFloor[floorNum].floorType {
                                case .isMonster:
                                    if gameData.selectedDamage <= 0{
                                        physicAttack(floorNum: floorNum)
                                    }else{
                                        attackMonster(floorNum: floorNum, damage: gameData.selectedDamage)
                                        if(gameData.propNum >= 0){
                                            if gameData.isPackage{
                                                packageDetail.removeFromPackage(num: gameData.propNum)
                                            }else{
                                                if gameData.gumBallData.magic >= 10{
                                                    reelDetail.removeFromPackage(num: gameData.propNum)
                                                }else{
                                                    gameData.selectedDamage = 0
                                                    shadowHide()
                                                }
                                            }
                                        }
                                    }
                                    updateTheMonster(floorNum: floorNum)
                                    updateTheGumBall()
                                    if allFloor[floorNum].monster.life <= 0{
                                        allFloor[floorNum].disableTheNum()
                                        removeTheMonster(floorNum: floorNum)
                                    }
                                case .isLifeBottle:
                                    gameData.gumBallData.life = gameData.gumBallData.life + 5
                                    updateTheGumBall()
                                    removeTheBottle(floorNum: floorNum)
                                    music.playPickHp()
                                case .isAttackBottle:
                                    gameData.gumBallData.physicAttack = gameData.gumBallData.physicAttack + 1
                                    updateTheGumBall()
                                    removeTheBottle(floorNum: floorNum)
                                    music.playPickAttackBottle()
                                case .isExplore:
                                    gameData.gumBallData.explore = gameData.gumBallData.explore + 30
                                    updateTheGumBall()
                                    removeTheBottle(floorNum: floorNum)
                                    music.playPickExplore()
                                case .isGood:
                                    let tmp = floor(floorType: allFloor[floorNum].floorType, funType: allFloor[floorNum].funType)
                                    packageDetail.addGood(good: tmp)
                                    removeTheGood(floorNum: floorNum)
                                    music.playReceiveGood()
                                case .isdoor:
                                    if gameData.nextGame{
                                        nextGame()
                                    }else if gameData.openTheDoor {
                                        let action = SKAction.animate(with: [SKTexture(imageNamed: "doorOpen")], timePerFrame: 0.5)
                                        allFloor[floorNum].run(action,completion: {
                                            gameData.nextGame = true
                                        })
                                        music.playOpenDoor()
                                    }else{
                                        music.playOpenDoorFaild()
                                    }
                                case .isreel:
                                    let tmp = floor(floorType: allFloor[floorNum].floorType, funType: allFloor[floorNum].funType)
                                    reelDetail.addGood(good: tmp)
                                    removeTheReel(floorNum: floorNum)
                                    music.playPickReel()
                                case .iskey:
                                    removeTheBottle(floorNum: floorNum)
                                    gameData.openTheDoor = true
                                    music.playPickKey()
                                default:
                                    print("nothing")
                                }
                            }
                        }
                    }else{
                        
                    }
                }
                gameData.selectedDamage = 0
                if gameData.operationLevel <= shadowNode.zPosition{
                    shadowHide()
                }
                if package.contains(touch.location(in: self)){
                    if package.zPosition >= gameData.operationLevel{
                        packageDetail.isHidden = false
                        gameData.operationLevel = packageDetail.zPosition
                        shadowDisplay()
                    }
                    gameData.selectedDamage = 0
                    //shadowHide()
                }else if !packageDetail.contains(touch.location(in: self)) && !packageDetail.isHidden{
                    if packageDetail.zPosition >= gameData.operationLevel{
                        packageDetail.hide()
                        gameData.operationLevel = 0
                    }
                    gameData.selectedDamage = 0
                    //shadowHide()
                }else if packageDetail.contains(touch.location(in: self)) && !packageDetail.isHidden{
                    if packageDetail.zPosition >= gameData.operationLevel{
                        let tmp = packageDetail.whichProp(point: CGPoint(x: touch.location(in: self).x-packageDetail.position.x, y: touch.location(in: self).y-packageDetail.position.y))
                        if tmp >= 0{
                            gameData.operationLevel = 0
                            packageDetail.useProp(num:tmp)
                            packageDetail.hide()
                        }
                    }
                }else if gumBall.contains(touch.location(in: self)){
                    if gumBall.zPosition >= gameData.operationLevel{
                          gumBallLevelUp.isHidden = false
                          gameData.operationLevel = gumBallLevelUp.zPosition
                          let tmp = GumBall(life: gameData.gumBallData.life, magic: gameData.gumBallData.magic, physicAttack: gameData.gumBallData.physicAttack, magicAttack: gameData.gumBallData.magicAttack, explore: gameData.gumBallData.explore)
                        
                          gumBallLevelUp.display(play: tmp)
                          shadowDisplay()
                      }
                    gameData.selectedDamage = 0
                }else if !gumBallLevelUp.contains(touch.location(in: self)) && !gumBallLevelUp.isHidden{
                    if gumBallLevelUp.zPosition >= gameData.operationLevel{
                        gumBallLevelUp.hide()
                        //gumBallLevelUp.hideDetail()
                        gameData.operationLevel = 0
                    }else if gumBallLevelUp.levelDetail.zPosition >= gameData.operationLevel{
                        gumBallLevelUp.hideDetail()
                        gameData.operationLevel = gumBallLevelUp.zPosition
                    }
                    gameData.selectedDamage = 0
                    //shadowHide()
                }else if gumBallLevelUp.contains(touch.location(in: self)) && !gumBallLevelUp.isHidden{
                    if gumBallLevelUp.zPosition >= gameData.operationLevel{
                        let tmp = gumBallLevelUp.selectedWhich(position: CGPoint(x: touch.location(in: self).x-gumBallLevelUp.position.x, y: touch.location(in: self).y-gumBallLevelUp.position.y))
                        if gumBallLevelUp.displayDetail(num: tmp){
                            gameData.operationLevel = gumBallLevelUp.levelDetail.zPosition
                            gumBallLevelUp.lastLevel = tmp
                        }
                    }else if gumBallLevelUp.levelDetail.zPosition >= gameData.operationLevel{
                        let tmp = gumBallLevelUp.selectedWhichDetail(position: CGPoint(x: touch.location(in: self).x-gumBallLevelUp.position.x, y: touch.location(in: self).y-gumBallLevelUp.position.y))
                        if tmp < 3 {
                            gumBallLevelUp.displayWhichDetail(num: tmp)
                        }else if tmp > 2 && tmp < 5{
                            gumBallLevelUp.setLevel(num: tmp)
                            if !gumBallLevelUp.addLevel(num: gumBallLevelUp.lastLevel){
                                if gumBallLevelUp.selectedLevel3 == -1{
                                    gumBallLevelUp.selectedLevel2 = -1
                                }else{
                                    gumBallLevelUp.selectedLevel3 = -1
                                }
                            }
                            gumBallLevelUp.hideDetail()
                        }else if tmp > 4{
                            gumBallLevelUp.hideDetail()
                            if gumBallLevelUp.addLevel(num: gumBallLevelUp.lastLevel){
                                music.playLevelUp()
                            }
                        }
                    }
                }else if reel.contains(touch.location(in: self)){
                    if reel.zPosition >= gameData.operationLevel{
                    reelDetail.isHidden = false
                    gameData.operationLevel = reelDetail.zPosition
                    shadowDisplay()
                    }
                    gameData.selectedDamage = 0
                }else if !reelDetail.contains(touch.location(in: self)) && !reelDetail.isHidden{
                    if reelDetail.zPosition >= gameData.operationLevel{
                        reelDetail.hide()
                        gameData.operationLevel = 0
                    }
                    gameData.selectedDamage = 0
                }else if reelDetail.contains(touch.location(in: self)) && !reelDetail.isHidden{
                    if packageDetail.zPosition >= gameData.operationLevel{
                        let tmp = reelDetail.whichProp(point: CGPoint(x: touch.location(in: self).x-packageDetail.position.x, y: touch.location(in: self).y-packageDetail.position.y))
                        if tmp >= 0{
                            gameData.operationLevel = 0
                            reelDetail.useProp(num:tmp)
                            reelDetail.hide()
                        }
                    }
                }
            }
            //print("runing")
            if gameData.shawHide {
                shadowHide()
                gameData.shawHide = false
            }
            if gameData.updateTheGumBall{
                updateTheGumBall()
                gameData.updateTheGumBall = false
            }
        case .over:
            print("return\n")
            self.removeAllChildren()
            restartGame()
        default:
            print("error")
        }
    }
    
    func removeTheMonster(floorNum:Int){
        let tmp = allFloor[floorNum]
        let positionTmp = allFloor[floorNum].position
        MoveOut(node: tmp)
        //self.removeChildren(in: [tmp])
        if floorNum == gameData.TheKey{
            allFloor[floorNum] = floor(floorType: .iskey,funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0))
        }else{
            allFloor[floorNum] = floor(floorType: .isNothing,funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0))
        }
        allFloor[floorNum].flipImmediately()
        allFloor[floorNum].position = positionTmp
        allFloor[floorNum].size = floorSize
        addChild(allFloor[floorNum])
        setTheFloorOpenStatus()
        gameData.monsterNum = gameData.monsterNum - 1
    }
    
    func removeTheGood(floorNum:Int){
        let tmp = allFloor[floorNum]
        let positionTmp = allFloor[floorNum].position
        moveTo(node: tmp, dest: package.position, duration: 1)
        //self.removeChildren(in: [tmp])
        
        allFloor[floorNum] = floor(floorType: .isNothing,funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0))
        allFloor[floorNum].flipImmediately()
        allFloor[floorNum].position = positionTmp
        allFloor[floorNum].size = floorSize
        addChild(allFloor[floorNum])
    }

    func removeTheReel(floorNum:Int){
        let tmp = allFloor[floorNum]
        let positionTmp = allFloor[floorNum].position
        moveTo(node: tmp, dest: reel.position, duration: 1)
        //self.removeChildren(in: [tmp])
        
        allFloor[floorNum] = floor(floorType: .isNothing,funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0))
        allFloor[floorNum].flipImmediately()
        allFloor[floorNum].position = positionTmp
        allFloor[floorNum].size = floorSize
        addChild(allFloor[floorNum])
    }
    
    func removeTheBottle(floorNum:Int){
        let tmp = allFloor[floorNum]
        let positionTmp = allFloor[floorNum].position
        moveTo(node: tmp, dest: gumBall.position, duration: 1)
        //self.removeChildren(in: [tmp])
        
        allFloor[floorNum] = floor(floorType: .isNothing,funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0))
        allFloor[floorNum].flipImmediately()
        allFloor[floorNum].position = positionTmp
        allFloor[floorNum].size = floorSize
        addChild(allFloor[floorNum])
    }
    
    func deleteTheFloorSet(){
        while !allFloor.isEmpty{
            allFloor.removeAll()
        }
    }

    func createTheFloor(){
        for i in 0..<6{
            for j in 0..<5{
                if(gameData.allProp[i*5+j] != .isGood && gameData.allProp[i*5+j] != .isreel){
                    allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0)))
                }else if gameData.allProp[i*5+j] == .isGood{
                    switch Int(arc4random()%(UInt32)(6)) {
                    case 0:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .life, coeff: 0, fixedNum: 10)))
                    case 1:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .magic, coeff: 0, fixedNum: 15)))
                    case 2:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .physicAttack, coeff: 0, fixedNum: 2)))
                    case 3:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .magicAttack, coeff: 0, fixedNum: 2)))
                    case 4:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .physicDamage, coeff: 1.2, fixedNum: 3)))
                    case 5:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .magicDamage, coeff: 1.6, fixedNum: 5)))
                    default:
                       allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0)))
                    }
                } else if gameData.allProp[i*5+j] == .isreel{
                    switch Int(arc4random()%(UInt32)(3)) {
                    case 0:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .life, coeff: 1.2, fixedNum: 10)))
                    case 1:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .magic, coeff: 1.2, fixedNum: 15)))
                    case 2:
                        allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .magicDamage, coeff: 2, fixedNum: 2)))
                    default:
                       allFloor.append(floor(floorType: gameData.allProp[i*5+j],funType: FunType(effect: .nothing, coeff: 0, fixedNum: 0)))
                    }
                }
            }
        }
        if allFloor[gameData.TheKey].floorType == .isNothing{
            allFloor[gameData.TheKey].backTexture = SKTexture(imageNamed: "key")
            allFloor[gameData.TheKey].monster = Monster(life: -1, attack: -1)
            allFloor[gameData.TheKey].floorType = .iskey
        }
    }


    func physicAttack(floorNum:Int){
        if allFloor[floorNum].floorType == FloorType.isMonster{
            allFloor[floorNum].monster.life = allFloor[floorNum].monster.life - gameData.gumBallData.physicAttack
            allFloor[floorNum].beAttacked(blood: gameData.gumBallData.physicAttack)
            music.playDamage()
            gameData.gumBallData.life = gameData.gumBallData.life - allFloor[floorNum].monster.attack
            gumBall.beAttacked(blood: allFloor[floorNum].monster.attack)
        }
    }

    func attackMonster(floorNum:Int,damage:Int){
        if allFloor[floorNum].floorType == FloorType.isMonster{
            allFloor[floorNum].monster.life = allFloor[floorNum].monster.life - damage
            allFloor[floorNum].beAttacked(blood: damage)
        }
    }

    func shadowDisplay(){
        shadowNode.isHidden = false
    }

    func shadowHide(){
        shadowNode.isHidden = true
    }


    func inTheFloor(index:CGPoint,center:CGPoint,size_x:Double,size_y:Double)->Bool{
        return ((Double)(index.x) > (Double)(center.x)-size_x/2 && (Double)(index.x) < (Double)(center.x)+size_x/2) && ((Double)(index.y) > (Double)(center.y)-size_y/2 && (Double)(index.y) < (Double)(center.y)+size_y/2)
    }

    func whichFloor(touch:CGPoint)->Int{
        for i in 0..<30{
            if(inTheFloor(index: touch, center: allFloor[i].position, size_x: Double(allFloor[i].size.width),size_y: Double(allFloor[i].size.height))){
                return i
            }
        }
        return -1
    }

    func updateTheMonster(floorNum:Int){
        if allFloor[floorNum].monster.life > 0{
            allFloor[floorNum].attackNum.text = (String)(allFloor[floorNum].monster.attack)
            allFloor[floorNum].lifeNum.text =  (String)(allFloor[floorNum].monster.life)
        }else{
            allFloor[floorNum].attackNum.text = (String)(allFloor[floorNum].monster.attack)
            allFloor[floorNum].lifeNum.text =  (String)(0)
            allFloor[floorNum].monster.life = 0
        }
    }

    func setLabel(text:String,position:CGPoint)->SKLabelNode{
        let label = SKLabelNode()
        label.fontName = "OpenSans-Bold"
        label.name = "damageLabel"
        label.fontSize = 12
        label.fontColor = SKColor.black
        label.text = text
        label.position = position
        label.zPosition = NodeLevel.front.rawValue
        return label
    }
    
    func numUpdate(num:Int,node:SKNode){
        if num == 0{
            return
        }
        var attackMessage = SKLabelNode()
        if num > 0{
            attackMessage = setLabel(text: "+\(num)",position: CGPoint(x: 0, y: 0))
        }else{
            attackMessage = setLabel(text: "\(num)",position: CGPoint(x: 0, y: 0))
        }
        attackMessage.fontName = "Chalkduster"
        attackMessage.fontSize = 10
        attackMessage.fontColor = .red
        
        node.addChild(attackMessage)
        
        let DoAction1 = SKAction.moveBy(x: 0, y: 30, duration: 0.4)
        attackMessage.run(DoAction1, completion: {() in
            node.removeChildren(in: [attackMessage])
        })
    }
    
    func updateTheGumBall(){
        if gameData.gumBallData.life <= 0{
            let DoAction1 = SKAction.moveBy(x: 0, y: 0, duration: 1)
            run(DoAction1,completion: {
                self.gameOver()
            })
            music.playFail()
            gameData.operationLevel = 1000000000
            return
        }
        var num = gameData.gumBallData.physicAttack - (Int)(gumBall.physicAttackNumNode.text!)!
        numUpdate(num: num, node: gumBall.physicAttackNumNode)
        gumBall.physicAttackNumNode.text = (String)(gameData.gumBallData.physicAttack)
        
        num = gameData.gumBallData.life - (Int)(gumBall.lifeNumNode.text!)!
        numUpdate(num: num, node: gumBall.lifeNumNode)
        gumBall.lifeNumNode.text = (String)(gameData.gumBallData.life)
        
        num = gameData.gumBallData.magicAttack - (Int)(gumBall.magicAttackNumNode.text!)!
        numUpdate(num: num, node: gumBall.magicAttackNumNode)
        gumBall.magicAttackNumNode.text = (String)(gameData.gumBallData.magicAttack)
        
        num = gameData.gumBallData.magic - (Int)(gumBall.magicNumNode.text!)!
        numUpdate(num: num, node: gumBall.magicNumNode)
        gumBall.magicNumNode.text = (String)(gameData.gumBallData.magic)
        
        updateTheExploreAndLevel()
    }

    func updateTheExploreAndLevel(){
        gameStartNode.text = """
        迷宫第\(gameData.level)层          探索点：\(gameData.gumBallData.explore)
              您的最大探索层数为：\(gameData.maxLevel)层
        """
    }

    func updateTheLevelAndMonsterNum(){
        gameData.level = gameData.level+1
        updateTheExploreAndLevel()
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //updateTheGumBall()
    }
}
