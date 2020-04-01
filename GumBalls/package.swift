//
//  package.swift
//  GumBalls
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit

class Package: SKSpriteNode {
    var frontTexture:SKTexture
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }

    init() {
        self.frontTexture = SKTexture(imageNamed: "package")

        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        self.zPosition = NodeLevel.sta.rawValue
    
    }
}

class PackageDetail: SKSpriteNode {
    var backgroundTexture:SKTexture
    var prop = [floor]()
    var maxProp = 25
    var nowProp = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }

    init() {
        
        backgroundTexture = SKTexture(imageNamed: "nodeBack")
        
        super.init(texture: backgroundTexture, color: .darkGray, size: backgroundTexture.size())
        
        self.zPosition = NodeLevel.doing.rawValue
    }
    
    func resetThePosition(){
        self.removeAllChildren()
        nowProp = 0
        for each in prop{
            addChild(each)
            let i = nowProp/5
            let j = nowProp%5
            each.position = CGPoint(x: (CGFloat)(j-2)*0.2*self.size.width, y:(CGFloat)(2-i)*0.2*self.size.height)
            each.size = CGSize(width: self.size.width*0.18, height: self.size.height*0.18)
            each.zPosition = self.zPosition + 1
            each.flipImmediately()
            nowProp = nowProp+1
        }
    }
    
    func addGood(good:floor){
        if nowProp < maxProp{
            prop.append(good)
            addChild(good)
            let i = nowProp/5
            let j = nowProp%5
            good.position = CGPoint(x: (CGFloat)(j-2)*0.2*self.size.width, y:(CGFloat)(2-i)*0.2*self.size.height)
            good.size = CGSize(width: self.size.width*0.18, height: self.size.height*0.18)
            good.zPosition = self.zPosition + 1
            good.flipImmediately()
            nowProp = nowProp+1
        }
    }
    
    func removeFromPackage(num:Int){
        prop[num].removeFromParent()
        prop.remove(at: num)
        nowProp = nowProp - 1
        resetThePosition()
        if gameData.selectedDamage > 0{
            gameData.shawHide = true
        }
    }
    
    func useProp(num:Int){
        switch prop[num].funType.effect {
        case .life:
            gameData.gumBallData.life = gameData.gumBallData.life + prop[num].calculateGoodResult()
            removeFromPackage(num: num)
            gameData.updateTheGumBall = true
            gameData.shawHide = true
            music.playAddHp()
        case .magic:
            gameData.gumBallData.magic = gameData.gumBallData.magic + prop[num].calculateGoodResult()
            removeFromPackage(num: num)
            gameData.updateTheGumBall = true
            gameData.shawHide = true
        case .magicAttack:
            gameData.gumBallData.magicAttack = gameData.gumBallData.magicAttack + prop[num].calculateGoodResult()
            removeFromPackage(num: num)
            gameData.updateTheGumBall = true
            gameData.shawHide = true
        case .physicAttack:
            gameData.gumBallData.physicAttack = gameData.gumBallData.physicAttack + prop[num].calculateGoodResult()
            removeFromPackage(num: num)
            gameData.updateTheGumBall = true
            gameData.shawHide = true
        case .magicDamage:
            gameData.selectedDamage = prop[num].calculateGoodResult()
            gameData.isPackage = true
            gameData.propNum = num
        case .physicDamage:
            gameData.selectedDamage = prop[num].calculateGoodResult()
            gameData.isPackage = true
            gameData.propNum = num
        default:
            print("error")
        }
    }
    
    func whichProp(point:CGPoint)->Int{
        for i in 0..<nowProp{
            if prop[i].contains(point){
                return i
            }
        }
        return -1
    }
    
    func hide(){
        self.isHidden = true
        if gameData.selectedDamage <= 0{
            gameData.shawHide = true
        }
    }
}
