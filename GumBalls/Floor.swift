//
//  Floor.swift
//  GumBalls
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

enum FloorType:Int{
    case isdoor
    
    case iskey
    
    case isreel
    
    case isMonster
    
    case isLifeBottle
    
    case isAttackBottle
    
    case isExplore
    
    case isGood
    
    case isNothing
}

enum NodeLevel:CGFloat{
    case sta = 1.0
    case back = 5.0
    case front = 10.0
    case moving = 100.0
    case doing = 1000.0
    case detail = 10000.0
}

enum EffectType{
    case nothing
    case life
    case magic
    case physicAttack
    case magicAttack
    case physicDamage
    case magicDamage
}

class FunType {
    var effect:EffectType
    var coeff:Double
    var fixedNum:Double
    
    init(effect:EffectType,coeff:Double,fixedNum:Double) {
        self.effect = effect
        self.coeff = coeff
        self.fixedNum = fixedNum
    }
    
    func calculateTheResult(num:Double)->Int{
        return (Int)(coeff*num + fixedNum)
    }
}

class Monster {
    var life:Int
    var attack:Int
    var index:Int!
    init(life:Int,attack:Int) {
        self.life = life
        self.attack = attack
    }
}

class floor:SKSpriteNode{
    
    var back = SKSpriteNode()
    
    var floorType:FloorType
    var frontTexture:SKTexture
    var backTexture:SKTexture
    var funType:FunType
    var coverUp = true
    
    var monster:Monster
    
    var message = ""
    
    var life = SKSpriteNode()
    var lifeNum = SKLabelNode()
    var attack = SKSpriteNode()
    var attackNum = SKLabelNode()
    
    //var attackMessage = SKLabelNode()
    
    override var position: CGPoint{
        didSet{
            setLabel(label: lifeNum, text: (String)(monster.life),position: CGPoint(x: -self.size.width*0.4, y: -self.size.height*(0.45)))
            setLabel(label: attackNum, text: (String)(monster.attack),position: CGPoint(x: -self.size.width*0.4, y: +self.size.height*(0.35)))
            
            setLabelBack(back: life, size: CGSize(width: self.size.width*0.25, height: self.size.height*0.25), position: CGPoint(x: -self.size.width*0.4, y: -self.size.height*(0.4)), image: "lifeNum")
            setLabelBack(back: attack, size: CGSize(width: self.size.width*0.25, height: self.size.height*0.25), position: CGPoint(x: -self.size.width*0.4, y: +self.size.height*(0.4)), image: "physicAttack")
        }
    }
    
    
    override var size: CGSize{
        didSet{
            back.size = self.size
            setLabel(label: lifeNum, text: (String)(monster.life),position: CGPoint(x: -self.size.width*0.4, y: -self.size.height*(0.45)))
            setLabel(label: attackNum, text: (String)(monster.attack),position: CGPoint(x: -self.size.width*0.4, y: +self.size.height*(0.35)))
            
            setLabelBack(back: life, size: CGSize(width: self.size.width*0.25, height: self.size.height*0.25), position: CGPoint(x: -self.size.width*0.4, y: -self.size.height*(0.4)), image: "lifeNum")
            setLabelBack(back: attack, size: CGSize(width: self.size.width*0.25, height: self.size.height*0.25), position: CGPoint(x: -self.size.width*0.4, y: +self.size.height*(0.4)), image: "physicAttack")
        }
    }
    
    func beAttacked(blood:Int){
        let attackMessage = SKLabelNode()
        
        setLabel(label: attackMessage, text: "-\(blood)",position: CGPoint(x: 0, y: 0))
        attackMessage.fontName = "Chalkduster"
        attackMessage.fontSize = 20
        attackMessage.fontColor = .red
        
        addChild(attackMessage)
        
        let DoAction1 = SKAction.moveBy(x: 0, y: 30, duration: 0.4)
        attackMessage.run(DoAction1, completion: {() in
            self.removeChildren(in: [attackMessage])
        })
    }
    
    func calculateGoodResult()->Int{
        if self.floorType == .isGood{
            switch funType.effect {
            case .life:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.life))
            case .magic:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.magic))
            case .magicAttack:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.magicAttack))
            case .physicAttack:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.physicAttack))
            case .magicDamage:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.magicAttack))
            case .physicDamage:
                return funType.calculateTheResult(num: (Double)(gameData.gumBallData.physicAttack))
            default:
                return -1
            }
        }else if self.floorType == .isreel{
            return funType.calculateTheResult(num: (Double)(gameData.gumBallData.magicAttack))
        }else
        {
            return -1
        }
    }
    
    func setLabel(label:SKLabelNode,text:String,position:CGPoint){
        label.fontName = "OpenSans-Bold"
        label.name = "damageLabel"
        label.fontSize = 12
        label.fontColor = SKColor.black
        label.text = text
        label.position = position
        label.zPosition = NodeLevel.front.rawValue
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
    
    init(floorType:FloorType,funType:FunType) {
        self.funType = funType
        self.floorType = floorType
        self.frontTexture = SKTexture(imageNamed: "floorCover")
        
        
        switch floorType{
        case .isMonster:
            message = "Monster1#一种奇怪的怪物"
            self.backTexture = SKTexture(imageNamed: "monster1")
            monster = Monster(life: 5+gameData.level/2, attack: 1+gameData.level/5)
        case .isLifeBottle:
            self.backTexture = SKTexture(imageNamed: "lifeBottle")
            monster = Monster(life: -1, attack: -1)
        case .isAttackBottle:
                self.backTexture = SKTexture(imageNamed: "attackBottle")
                monster = Monster(life: -1, attack: -1)
        case .isExplore:
                self.backTexture = SKTexture(imageNamed: "explore")
                monster = Monster(life: -1, attack: -1)
        case .isNothing:
            self.backTexture = SKTexture(imageNamed: "nothing")
            monster = Monster(life: -1, attack: -1)
        case .isdoor:
            self.backTexture = SKTexture(imageNamed: "door")
            monster = Monster(life: -1, attack: -1)
        case .iskey:
            self.backTexture = SKTexture(imageNamed: "key")
            monster = Monster(life: -1, attack: -1)
        case .isGood:
            monster = Monster(life: -1, attack: -1)
            switch funType.effect {
                case .life:
                    message = "血瓶#血量增加"
                    self.backTexture = SKTexture(imageNamed: "lifeGood")
                case .magic:
                    message = "魔瓶#魔法值增加"
                    self.backTexture = SKTexture(imageNamed: "magicGood")
                case .magicAttack:
                    message = "魔攻瓶#魔法攻击增加"
                    self.backTexture = SKTexture(imageNamed: "magicAttackGood")
                case .physicAttack:
                    message = "物理瓶#物理攻击增加"
                    self.backTexture = SKTexture(imageNamed: "physicAttackGood")
                case .magicDamage:
                    message = "魔法伤害#造成魔法伤害"
                    self.backTexture = SKTexture(imageNamed: "magicDamageGood")
                case .physicDamage:
                    message = "物理伤害#造成物理伤害"
                    self.backTexture = SKTexture(imageNamed: "physicDamageGood")
                default:
                    self.backTexture = SKTexture(imageNamed: "nothing")
            }
        case .isreel:
            monster = Monster(life: -1, attack: -1)
            switch funType.effect {
                case .life:
                    message = "血瓶#血量增加"
                    self.backTexture = SKTexture(imageNamed: "lifeReel")
                case .magic:
                    message = "魔瓶#魔法值增加"
                    self.backTexture = SKTexture(imageNamed: "magicReel")
                case .magicDamage:
                    message = "魔法伤害#造成魔法伤害"
                    self.backTexture = SKTexture(imageNamed: "magicDamageReel")
                default:
                    self.backTexture = SKTexture(imageNamed: "nothing")
            }
        default:
            self.backTexture = SKTexture(imageNamed: "nothing")
            monster = Monster(life: -1, attack: -1)
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        back = SKSpriteNode(imageNamed: "nothing")
        back.zPosition = self.zPosition - 1
        addChild(back)
        
        addChild(lifeNum)
        addChild(attackNum)
        
        addChild(life)
        addChild(attack)
        
        //addChild(attackMessage)
        
        disableTheNum()
        //self.attackMessage.isHidden = true
        
        self.zPosition = NodeLevel.sta.rawValue
    }
    
    func disableTheNum(){
        self.life.isHidden = true
        self.lifeNum.isHidden = true
        self.attack.isHidden = true
        self.attackNum.isHidden = true
    }
    
    func flip(){

        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.2)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.2)
        
        setScale(1.0)
        
        if coverUp {
          run(firstHalfFlip, completion: {
            self.texture = self.backTexture
            if(self.floorType == .isMonster){
                self.life.isHidden = false
                self.lifeNum.isHidden = false
                self.attack.isHidden = false
                self.attackNum.isHidden = false
                
                //self.lifeNum.zPosition = self.zPosition + 1
            }
            self.run(secondHalfFlip)
          })
        }
        coverUp = false
    }
    
    func flipImmediately(){
        if coverUp {
            self.texture = self.backTexture
            if(self.floorType == .isMonster){
                self.life.isHidden = false
                self.lifeNum.isHidden = false
                self.attack.isHidden = false
                self.attackNum.isHidden = false
            }
        }
        coverUp = false
    }
    
}
