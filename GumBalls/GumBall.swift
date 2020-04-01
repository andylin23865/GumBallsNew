//
//  GumBall.swift
//  GumBalls
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit

struct levelMessage {
    var life:Int
    var magic:Int
    var physicAttack:Int
    var magicAttack:Int
    var prop = [floor]()
    
    static func ==(left:levelMessage,right:levelMessage)->Bool{
        if left.life == right.life && left.magic == right.magic && left.physicAttack == right.physicAttack && left.magicAttack == right.magicAttack && left.prop == right.prop{
            return true
        }
        return false
    }
    
    init(life:Int,magic:Int,physicAttack:Int,magicAttack:Int,prop:[floor]) {
        self.life = life
        self.magic = magic
        self.physicAttack = physicAttack
        self.magicAttack = magicAttack
        self.prop = prop
    }
    
    
}

class GumBall:SKSpriteNode{

    
    var frontTexture:SKTexture
    
    var lifeNode = SKSpriteNode()
    var magicNode = SKSpriteNode()
    var physicAttackNode = SKSpriteNode()
    var magicAttackNode = SKSpriteNode()
    
    var lifeNumNode = SKLabelNode()
    var magicNumNode = SKLabelNode()
    var physicAttackNumNode = SKLabelNode()
    var magicAttackNumNode = SKLabelNode()
    
    override var size:CGSize{
        didSet{
            resetLabel(node: lifeNumNode,position: CGPoint(x: -self.size.width*0.8, y: -self.size.height*(0.48)))
            resetLabel(node: physicAttackNumNode,position: CGPoint(x: -self.size.width*0.8, y: +self.size.height*(0.32)))
            
            resetLabel(node: magicNumNode,position: CGPoint(x: +self.size.width*0.8, y: -self.size.height*(0.48)))
            resetLabel(node: magicAttackNumNode,position: CGPoint(x: +self.size.width*0.8, y: +self.size.height*(0.32)))
            
            setLabelBack(back: lifeNode, size: CGSize(width: self.size.width*0.4, height: self.size.width*0.4), position: CGPoint(x: -self.size.width*0.8, y: -self.size.height*(0.4)), image: "lifeNum")
            setLabelBack(back: physicAttackNode, size: CGSize(width: self.size.width*0.4, height: self.size.width*0.4), position: CGPoint(x: -self.size.width*0.8, y: +self.size.height*(0.4)), image: "physicAttack")
            
            setLabelBack(back: magicNode, size: CGSize(width: self.size.width*0.4, height: self.size.width*0.4), position: CGPoint(x: +self.size.width*0.8, y: -self.size.height*(0.4)), image: "magicNum")
            setLabelBack(back: magicAttackNode, size: CGSize(width: self.size.width*0.4, height: self.size.width*0.4), position: CGPoint(x: +self.size.width*0.8, y: +self.size.height*(0.4)), image: "magicAttack")
        }
    }
    
    func beAttacked(blood:Int){
        var attackMessage = SKLabelNode()
        
        setLabel(node: attackMessage,text: "-\(blood)",position: CGPoint(x: 0, y: 0))
        attackMessage.fontName = "Chalkduster"
        attackMessage.fontSize = 20
        attackMessage.fontColor = .red
        
        addChild(attackMessage)
        
        let DoAction1 = SKAction.moveBy(x: 0, y: 30, duration: 0.4)
        attackMessage.run(DoAction1, completion: {() in
            self.removeChildren(in: [attackMessage])
        })
    }
    
    func resetLabel(node:SKLabelNode,position:CGPoint){
        node.position = position
        node.zPosition = NodeLevel.front.rawValue
    }
    
    func setLabel(node:SKLabelNode,text:String,position:CGPoint){
        node.fontName = "OpenSans-Bold"
        node.name = "damageLabel"
        node.fontSize = 12
        node.fontColor = SKColor.black
        node.text = text
        node.position = position
        node.zPosition = NodeLevel.front.rawValue
    }
    
    func setLabelBack(back:SKSpriteNode,size:CGSize,position:CGPoint,image:String){
        back.texture = SKTexture(imageNamed: image)
        back.size = size
        back.position = position
        back.zPosition = NodeLevel.back.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    init(life:Int,magic:Int,physicAttack:Int,magicAttack:Int,explore:Int) {
        self.frontTexture = SKTexture(imageNamed: "player1")
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        setLabel(node: lifeNumNode, text: (String)(life),position: CGPoint(x: self.position.x-self.size.width*0.8, y: self.position.y-self.size.height*(0.48)))
        setLabel(node: physicAttackNumNode, text: (String)(physicAttack),position: CGPoint(x: self.position.x-self.size.width*0.8, y: self.position.y+self.size.height*(0.32)))
        
        setLabel(node: magicNumNode, text: (String)(magic),position: CGPoint(x: self.position.x+self.size.width*0.8, y: self.position.y-self.size.height*(0.48)))
        setLabel(node: magicAttackNumNode, text: (String)(magicAttack),position: CGPoint(x: self.position.x+self.size.width*0.8, y: self.position.y+self.size.height*(0.32)))
        
        addChild(lifeNumNode)
        addChild(physicAttackNumNode)
        
        addChild(magicNumNode)
        addChild(magicAttackNumNode)
        
        addChild(lifeNode)
        addChild(physicAttackNode)
        
        addChild(magicNode)
        addChild(magicAttackNode)
        
        self.zPosition = NodeLevel.sta.rawValue
    
    }
}

class levelNode:SKSpriteNode{
    
    var backTexture:SKTexture
    var life:Int
    var magic:Int
    var physicAttack:Int
    var magicAttack:Int
    var prop = [floor]()
    var myDescription: String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    init(life:Int,magic:Int,physicAttack:Int,magicAttack:Int,prop:[floor]) {
        self.life = life
        self.physicAttack = physicAttack
        self.magicAttack = magicAttack
        self.magic = magic
        for myProp in prop
        {
            self.prop.append(myProp)
        }
        myDescription = ""
        backTexture = SKTexture(imageNamed: "player1")
        super.init(texture: backTexture, color: .clear, size: backTexture.size())
        self.size = CGSize(width: 50, height: 50)
    }
}

class levelDetailNode:SKSpriteNode{
    
    var label = SKLabelNode()
    var desLabel = SKLabelNode()
    var backTexture:SKTexture
    var firstNode:levelNode
    var secondNode:levelNode
    var life = SKLabelNode()
    var magic = SKLabelNode()
    var physicAttck = SKLabelNode()
    var magicAttack = SKLabelNode()
    var selected:SKSpriteNode
    var explore = SKLabelNode()
    var mydescription:SKSpriteNode
    var num1 = 0
    var num2 = 0
    
    func setDescrip(num:Int){
        switch num {
        case 1:
            desLabel.text = ""
        case 2:
            desLabel.text = "每层恢复HP：2点 恢复MP:1点"
        case 3:
            desLabel.text = "每层恢复HP：1点 恢复MP:2点"
        case 4:
            desLabel.text = "每层恢复HP：5点 恢复MP:3点"
        case 5:
            desLabel.text = "每层恢复HP：4点 恢复MP:4点"
        case 6:
            desLabel.text = "每层恢复HP：3点 恢复MP:5点"
        case 7:
            desLabel.text = "每层恢复HP：2点 恢复MP:6点"
        default:
            desLabel.text = ""
        }
    }
    
    func setLabel(text:String,position:CGPoint)->SKLabelNode{
        let label = SKLabelNode()
        label.fontName = "OpenSans-Bold"
        label.name = "damageLabel"
        label.fontSize = 20
        label.fontColor = SKColor.black
        label.text = text
        label.position = position
        return label
    }
    
    func display(first:levelMessage,firstNum:Int,second:levelMessage,secondNum:Int,explore:Int){
        num1 = firstNum
        num2 = secondNum
        firstNode.texture = SKTexture(imageNamed: "name\(firstNum+1)")
        firstNode.life = first.life
        firstNode.magic = first.magic
        firstNode.physicAttack = first.physicAttack
        firstNode.magicAttack = first.magicAttack
        firstNode.prop = first.prop
        
        //firstNode.size = CGSize(width:self.size.width*0.2,height: self.size.width*0.2)
        //firstNode.size = CGSize(width:self.size.width*0.3,height: self.size.width*0.3)
        
        secondNode.texture = SKTexture(imageNamed: "name\(secondNum+1)")
        secondNode.life = second.life
        secondNode.magic = second.magic
        secondNode.physicAttack = second.physicAttack
        secondNode.magicAttack = second.magicAttack
        secondNode.prop = second.prop
        if first == second{
            firstNode.position = CGPoint(x: -self.size.width*0, y: self.size.height*0.25)
            secondNode.position = CGPoint(x: self.size.width*0, y: self.size.height*0.25)
            secondNode.isHidden = true
            label.text = "升级称号"
        }else{
            firstNode.position = CGPoint(x: -self.size.width*0.25, y: self.size.height*0.25)
            secondNode.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.25)
            secondNode.isHidden = false
            label.text = "选择此称号"
        }
        self.explore.text = "需要探索点：\(explore)"
        self.isHidden = false
        selectFirst()
    }
    
    func hide(){
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    func selectWhich(position:CGPoint)->Int{
        if firstNode.contains(position) {
            return 1
        }else if secondNode.contains(position){
            return 2
        } else if selected.contains(position){
            if firstNode.position == secondNode.position{
                return 5
            }else if firstNode.alpha == 1.0
            {
                return 3
            }else if secondNode.alpha == 1.0{
                return 4
            }
        }
        return -1
    }
    
    func selectFirst() {
        life.text = "生命值：\(firstNode.life)"
        magic.text = "魔法值：\(firstNode.magic)"
        physicAttck.text = "攻击：\(firstNode.physicAttack)"
        magicAttack.text = "魔力：\(firstNode.magicAttack)"
        firstNode.alpha = 1.0
        secondNode.alpha = 0.5
        setDescrip(num: num1+1)
    }
    
    func selectSecond() {
        life.text = "生命值：\(secondNode.life)"
        magic.text = "魔法值：\(secondNode.magic)"
        physicAttck.text = "攻击：\(secondNode.physicAttack)"
        magicAttack.text = "魔力：\(secondNode.magicAttack)"
        secondNode.alpha = 1.0
        firstNode.alpha = 0.5
        setDescrip(num: num2+1)
    }
    
    func resetThePosition(){
        life.position = CGPoint(x: -self.size.width*0.25, y: -self.size.height*0.15)
        magic.position = CGPoint(x: self.size.width*0.25, y: -self.size.height*0.15)
        physicAttck.position = CGPoint(x: -self.size.width*0.25, y: -self.size.height*0.25)
        magicAttack.position = CGPoint(x: self.size.width*0.25, y: -self.size.height*0.25)
        explore.position = CGPoint(x: self.size.width*0, y: -self.size.height*0.35)
        selected.position = CGPoint(x: self.size.width*0, y: -self.size.height*0.42)
        selected.size = CGSize(width: self.size.width*0.3, height: self.size.width*0.1)
        mydescription.position = CGPoint(x: self.size.width*0, y: self.size.height*0)
        mydescription.size = CGSize(width: self.size.width*0.8, height: self.size.width*0.1)
        label.fontName = "OpenSans-Bold"
        label.name = "damageLabel"
        label.fontSize = 15
        label.fontColor = SKColor.red
        //label.text = "选择此称号"
        label.zPosition = selected.zPosition+1
        label.position = CGPoint(x: 0, y: -selected.size.height*0.20)
        
        desLabel.fontName = "OpenSans-Bold"
        desLabel.name = "damageLabel"
        desLabel.fontSize = 15
        desLabel.fontColor = SKColor.red
        //desLabel.text = "选择此称号"
        desLabel.zPosition = selected.zPosition+1
        desLabel.position = CGPoint(x: 0, y: -selected.size.height*0.20)
    }
    
    init() {
        
        firstNode = levelNode(life: 0, magic: 0, physicAttack: 0, magicAttack: 0, prop: [])
        secondNode = levelNode(life: 0, magic: 0, physicAttack: 0, magicAttack: 0, prop: [])
        
        selected = SKSpriteNode(imageNamed: "nothing")
        mydescription = SKSpriteNode(imageNamed: "nothing")
        
        backTexture = SKTexture(imageNamed: "nothing")
        super.init(texture: SKTexture(imageNamed: "nodeBack"), color: .clear, size: backTexture.size())
        self.size = CGSize(width: 50, height: 50)
        self.zPosition = NodeLevel.detail.rawValue
        
        life = setLabel(text: "生命值：\(firstNode.life)", position:CGPoint(x: 0, y: 0))
        magic = setLabel(text: "魔法值：\(firstNode.magic)", position: CGPoint(x: 0, y: 0))
        physicAttck = setLabel(text: "攻击：\(firstNode.physicAttack)", position:CGPoint(x: 0, y: 0))
        magicAttack = setLabel(text: "魔力：\(firstNode.magicAttack)", position: CGPoint(x: 0, y: 0))
        explore = setLabel(text: "", position: CGPoint(x: 0, y: 0))
        firstNode.zPosition = self.zPosition+1
        secondNode.zPosition = self.zPosition+1
        life.zPosition = self.zPosition+1
        magic.zPosition = self.zPosition+1
        physicAttck.zPosition = self.zPosition+1
        magicAttack.zPosition = self.zPosition+1
        selected.zPosition = self.zPosition+1
        mydescription.zPosition = self.zPosition+1
        explore.zPosition = self.zPosition+1
        firstNode.alpha = 0.5
        
        addChild(life)
        addChild(magic)
        addChild(physicAttck)
        addChild(magicAttack)
        addChild(explore)
        addChild(firstNode)
        addChild(secondNode)
        addChild(selected)
        addChild(mydescription)
        selected.addChild(label)
        mydescription.addChild(desLabel)
    }
}

class levelSelected: SKSpriteNode {
    var frontTexture:SKTexture
    var outLevel = [SKSpriteNode]()
    var level = 0
    var explore:Int

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    func addLevel()->Bool{
        if level < 4 && gameData.gumBallData.explore >= explore + gameData.level*50{
            level = level+1
            gameData.gumBallData.explore = gameData.gumBallData.explore - explore - gameData.level*50 + 50
        }else{
            return false
        }
        for i in 0..<level{
            outLevel[i].alpha = 1.0
        }
        return true
    }
    
    func resetThePosition(){
        for i in 0..<4{
            outLevel[i].size = CGSize(width: self.size.width*0.2, height: self.size.width*0.2)
            outLevel[i].zPosition = self.zPosition + 1
            outLevel[i].position = CGPoint(x: (CGFloat)(i-2)*0.2*self.size.width+self.size.width*0.1, y: self.size.height*0.6)
            outLevel[i].alpha = 0.5
            addChild(outLevel[i])
        }
    }
    
    init(explore:Int) {
        self.explore = explore
        outLevel.append(SKSpriteNode(imageNamed: "physicAttack"))
        outLevel.append(SKSpriteNode(imageNamed: "physicAttack"))
        outLevel.append(SKSpriteNode(imageNamed: "physicAttack"))
        outLevel.append(SKSpriteNode(imageNamed: "physicAttack"))
        
        self.frontTexture = SKTexture(imageNamed: "levelBack")

        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        self.zPosition = NodeLevel.sta.rawValue
        
    }
}

class GumBallLevelUp:SKSpriteNode{
    
    var tmpGumBall:GumBall!
    var levelDetail:levelDetailNode
    var levelmessage = [levelMessage]()
    var level1:levelSelected
    var level2:levelSelected
    var level3:levelSelected
    var selectedLevel2:Int = -1
    var allLevel = [Int]()
    var selectedLevel3:Int = -1
    var lastLevel = -1
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    func selectedWhich(position:CGPoint)->Int{
        if level1.contains(position){
            return 1
        }else if level2.contains(position){
            return 2
        }else if level3.contains(position){
            return 3
        }
        return -1
    }
    
    func selectedWhichDetail(position:CGPoint)->Int{
        return levelDetail.selectWhich(position: CGPoint(x: position.x-levelDetail.position.x, y: position.y-levelDetail.position.y))
    }
    
    func displayWhichDetail(num:Int){
        if num == 1 {
            levelDetail.selectFirst()
        }else if num == 2{
            levelDetail.selectSecond()
        }
    }
    
    func LevelUpdateTheGumBall(){
        tmpGumBall.physicAttackNumNode.text = (String)(gameData.gumBallData.physicAttack)
        tmpGumBall.lifeNumNode.text = (String)(gameData.gumBallData.life)
        tmpGumBall.magicAttackNumNode.text = (String)(gameData.gumBallData.magicAttack)
        tmpGumBall.magicNumNode.text = (String)(gameData.gumBallData.magic)
    }
    
    func myUpdateTheGumBall(num:Int){
        gameData.gumBallData.life = gameData.gumBallData.life + levelmessage[num].life
        gameData.gumBallData.magic = gameData.gumBallData.magic + levelmessage[num].magic
        gameData.gumBallData.physicAttack = gameData.gumBallData.physicAttack + levelmessage[num].physicAttack
        gameData.gumBallData.magicAttack = gameData.gumBallData.magicAttack + levelmessage[num].magicAttack
        self.LevelUpdateTheGumBall()
        gameData.updateTheGumBall = true
    }
    
    func addLevel(num:Int)->Bool{
        if num == 1 && level1.addLevel(){
            myUpdateTheGumBall(num: 0)
            return true
        }else if num == 2 && level2.addLevel(){
            myUpdateTheGumBall(num: selectedLevel2)
            return true
        }else if num == 3 && level3.addLevel(){
            myUpdateTheGumBall(num: selectedLevel3)
            return true
        }
        return false
    }
    
    func displayDetail(num:Int)->Bool{
        if num == 1{
            levelDetail.display(first: levelmessage[0], firstNum: 0, second: levelmessage[0], secondNum: 0,explore: level1.explore+level1.level*50)
            levelDetail.resetThePosition()
            return true
        }else if num == 2{
            if selectedLevel2 == -1{
                levelDetail.display(first: levelmessage[1], firstNum: 1, second: levelmessage[2], secondNum: 2,explore: level2.explore+level2.level*50)
                levelDetail.resetThePosition()
                return true
            }else{
                levelDetail.display(first: levelmessage[selectedLevel2], firstNum: selectedLevel2, second: levelmessage[selectedLevel2], secondNum: selectedLevel2,explore: level2.explore+level2.level*50)
                levelDetail.resetThePosition()
                return true
            }
        }else if num == 3 && selectedLevel2 != -1{
            if selectedLevel3 == -1{
                if selectedLevel2 == 1
                {
                    levelDetail.display(first: levelmessage[3], firstNum: 3, second: levelmessage[4], secondNum: 4,explore: level3.explore+level3.level*50)
                    levelDetail.resetThePosition()
                    return true
                }else if selectedLevel2 == 2{
                    levelDetail.display(first: levelmessage[5], firstNum: 5, second: levelmessage[6], secondNum: 6,explore: level3.explore+level3.level*50)
                    levelDetail.resetThePosition()
                    return true
                }
            }else{
                levelDetail.display(first: levelmessage[selectedLevel3], firstNum: selectedLevel3, second: levelmessage[selectedLevel3], secondNum: selectedLevel3,explore: level3.explore+level3.level*50)
                levelDetail.resetThePosition()
                return true
            }
        }
        return false
    }
    
    func setLevel(num:Int){
        if selectedLevel2 == -1{
            if num == 3{
                selectedLevel2 = 1
                gameData.lifeAdd = 2
                gameData.magicAdd = 1
            }else if num == 4{
                selectedLevel2 = 2
                gameData.lifeAdd = 1
                gameData.magicAdd = 2
            }
            level2.texture = SKTexture(imageNamed: "name\(selectedLevel2+1)")
        }else if selectedLevel3 == -1{
            if num == 3{
                if selectedLevel2 == 1{
                    selectedLevel3 = 3
                    gameData.lifeAdd = 5
                    gameData.magicAdd = 3
                }else if selectedLevel2 == 2{
                    selectedLevel3 = 5
                    gameData.lifeAdd = 3
                    gameData.magicAdd = 5
                }
            }else if num == 4{
                if selectedLevel2 == 1{
                    selectedLevel3 = 4
                    gameData.lifeAdd = 4
                    gameData.magicAdd = 4
                }else if selectedLevel2 == 2{
                    selectedLevel3 = 6
                    gameData.lifeAdd = 2
                    gameData.magicAdd = 6
                }
            }
            level3.texture = SKTexture(imageNamed: "name\(selectedLevel3+1)")
        }
    }
    
    func hideDetail(){
        levelDetail.hide()
        gameData.operationLevel = self.zPosition
    }
    
    func display(play:GumBall){
        let fadeInAction = SKAction.fadeIn(withDuration: 0.05)
        self.run(fadeInAction, withKey: "display")
        addChild(play)
        play.position = CGPoint(x: 0, y: self.size.height*0.25)
        play.zPosition = self.zPosition+1
        tmpGumBall = play
        tmpGumBall.size = CGSize(width: self.size.width*0.3, height: self.size.width*0.3)
    }
    
    func hide(){
        tmpGumBall.removeFromParent()
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
        let hideAction = SKAction.hide()
        self.run(SKAction.group([fadeOutAction,hideAction]), withKey: "hide")
        gameData.shawHide = true
    }
    
    init() {
        allLevel.append(0)
        allLevel.append(0)
        allLevel.append(0)
        
        levelmessage.append(levelMessage(life: 10, magic: 0, physicAttack: 1, magicAttack: 1, prop: []))
        levelmessage.append(levelMessage(life: 20, magic: 10, physicAttack: 3, magicAttack: 0, prop: []))
        levelmessage.append(levelMessage(life: 10, magic: 20, physicAttack: 1, magicAttack: 3, prop: []))
        levelmessage.append(levelMessage(life: 30, magic: 10, physicAttack: 4, magicAttack: 1, prop: []))
        levelmessage.append(levelMessage(life: 40, magic: 0, physicAttack: 5, magicAttack: 0, prop: []))
        levelmessage.append(levelMessage(life: 10, magic: 40, physicAttack: 1, magicAttack: 4, prop: []))
        levelmessage.append(levelMessage(life: 0, magic: 50, physicAttack: 0, magicAttack: 5, prop: []))
        
        levelDetail = levelDetailNode()
        
        level1 = levelSelected(explore: 100)
        level2 = levelSelected(explore: 200)
        level3 = levelSelected(explore: 300)
        
        super.init(texture: SKTexture(imageNamed: "nodeBack"), color: .clear, size: CGSize(width: 300, height: 300))
        self.zPosition = NodeLevel.doing.rawValue
        self.isHidden = true
        
        addChild(levelDetail)
        addChild(level1)
        addChild(level2)
        addChild(level3)
        level1.zPosition = self.zPosition+1
        level2.zPosition = self.zPosition+1
        level3.zPosition = self.zPosition+1
        level1.size = CGSize(width: self.size.width*0.1,height: self.size.width*0.1)
        level2.size = CGSize(width: self.size.width*0.1,height: self.size.width*0.1)
        level3.size = CGSize(width: self.size.width*0.1,height: self.size.width*0.1)
        level1.position = CGPoint(x: -self.size.width*0.16, y: -self.size.height*0.25)
        level2.position = CGPoint(x: -self.size.width*0, y: -self.size.height*0.25)
        level3.position = CGPoint(x: self.size.width*0.16, y: -self.size.height*0.25)
        level1.resetThePosition()
        level2.resetThePosition()
        level3.resetThePosition()
        //levelDetail.zPosition = self.zPosition+10
        level1.texture = SKTexture(imageNamed: "name1")
        levelDetail.position = CGPoint(x: 0, y: 0)
        levelDetail.size = self.size
        levelDetail.isHidden = true
    }
}
