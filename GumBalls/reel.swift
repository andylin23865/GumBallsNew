//
//  reel.swift
//  GumBalls
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit

class Reel: SKSpriteNode {
    var frontTexture:SKTexture

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    init() {
        self.frontTexture = SKTexture(imageNamed: "reel")

        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        self.zPosition = NodeLevel.sta.rawValue
        
    }
}


class ReelDetail: PackageDetail {
    override func useProp(num: Int) {
        switch prop[num].funType.effect {
        case .life:
            if gameData.gumBallData.magic >= 10{
                gameData.gumBallData.life = gameData.gumBallData.life + prop[num].calculateGoodResult()
                gameData.gumBallData.magic = gameData.gumBallData.magic - 20
                gameData.updateTheGumBall = true
                removeFromPackage(num: num)
                music.playAddHp()
            }
        case .magic:
            gameData.gumBallData.magic = gameData.gumBallData.magic + prop[num].calculateGoodResult()
            gameData.updateTheGumBall = true
            removeFromPackage(num: num)
        case .magicDamage:
            gameData.selectedDamage = prop[num].calculateGoodResult()
            gameData.isPackage = false
            gameData.propNum = num
        default:
            print("error")
        }
    }
}
