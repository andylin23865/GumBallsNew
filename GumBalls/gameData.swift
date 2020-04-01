//
//  gameControl.swift
//  GumBalls
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

/*some function*/

/*var mainMusic:SKAction = {
  return SKAction.playSoundFileNamed("bgm_forest.mp3", waitForCompletion: false)
}()

var startMusic:SKAction = {
  return SKAction.playSoundFileNamed("bgm_workshop.mp3", waitForCompletion: false)
}()*/

class TheGumBallData{
    var life:Int
    var magic:Int
    var physicAttack:Int
    var magicAttack:Int
    var explore:Int
    
    init(life:Int,magic:Int,physicAttack:Int,magicAttack:Int,explore:Int) {
        self.life = life
        self.magic = magic
        self.physicAttack = physicAttack
        self.magicAttack = magicAttack
        self.explore = explore
    }
}

class dataManager{
    
    var magicAdd = 0
    var lifeAdd = 0

    var allProp = [FloorType]()
    var level:Int = 1{
        didSet{
            if level > maxLevel {
                maxLevel = level
            }
        }
    }
    var maxLevel:Int{
        didSet{
            UserDefaults.standard.removeObject(forKey: "level")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(level, forKey: "level")
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
        if let maxl = UserDefaults.standard.value(forKey: "level") as! Int?{
            maxLevel = maxl
        }else{
            maxLevel = 1
        }
    }
    var gumBallData = TheGumBallData(life: 50, magic: 20, physicAttack: 3, magicAttack: 1, explore: 1000000)
    var gameStatus = GameStatus.idle
    var isPackage = true
    var selectedDamage = 0
    var propNum = -1
    var TheKey = -1
    var nextGame = false
    var openTheDoor = false
    var operationLevel:CGFloat = 0.0
    var shawHide = true
    var updateTheGumBall = false
    var monsterNum = 5
    
    func deleteTheProSet(){
        while !allProp.isEmpty{
            allProp.removeAll()
        }
    }

    func createThePropSet(){
        for _ in 0..<30{
            allProp.append(.isNothing)
        }
    }

    func calculateTheProp(allFloorNum:Int,allPropNum:Int,kind:FloorType){
        var num = 0
        while(num < allPropNum){
            let randomNum = Int(arc4random()%(UInt32)(allFloorNum))
            if allProp[randomNum] == .isNothing {
                allProp[randomNum] = kind
                num = num+1
            }
        }
    }
    
    func calculateTheKey(allFloorNum:Int){
        var num = 0
        while(num < 1){
            let randomNum = Int(arc4random()%(UInt32)(allFloorNum))
            if allProp[randomNum] == .isNothing  || allProp[randomNum] == .isMonster{
                TheKey = randomNum
                num = num+1
            }
        }
    }
    
    func createTheLevelData(){
        deleteTheProSet()
        createThePropSet()
        calculateTheProp(allFloorNum: 30, allPropNum: monsterNum, kind: .isMonster)
        calculateTheProp(allFloorNum: 30, allPropNum: 2, kind: .isLifeBottle)
        calculateTheProp(allFloorNum: 30, allPropNum: 1, kind: .isAttackBottle)
        calculateTheProp(allFloorNum: 30, allPropNum: 3, kind: .isExplore)
        calculateTheProp(allFloorNum: 30, allPropNum: 4, kind: .isGood)
        calculateTheProp(allFloorNum: 30, allPropNum: 3, kind: .isreel)
        calculateTheProp(allFloorNum: 30, allPropNum: 1, kind: .isdoor)
        calculateTheKey(allFloorNum: 30)
    }
    
    
       /*  使用NSUserDefaults对普通数据对象储存   */
       /**
        储存
        - parameter key:   key
        - parameter value: value
        */
       func setNormalDefault(key:String, value:AnyObject?){
           if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
           }
           else{
            UserDefaults.standard.set(value, forKey: key)
               // 同步
            UserDefaults.standard.synchronize()
           }
       }
    
       /**
        通过对应的key移除储存
        - parameter key: 对应key
        */
       func removeNormalUserDefault(key:String?){
           if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
           }
       }
    
       /**
        通过key找到储存的value
        - parameter key: key
        - returns: AnyObject
        */
       func getNormalDefult(key:String)->AnyObject?{
        return UserDefaults.standard.value(forKey: key) as AnyObject?
       }
}

var gameData = dataManager()
var music = SoundManager()
