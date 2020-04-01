//
//  Music.swift
//  GumBalls
//
//  Created by apple on 2019/12/10.
//  Copyright © 2019 andy. All rights reserved.
//

/*import AVFoundation

class music{
    	var backgroundMusicPlayer: AVAudioPlayer!

       func playBackgroundMusic(filename: String) {
        
        let myurl = Bundle.main.path(forResource: filename, ofType: "mp3")
        
        let url = URL(fileURLWithPath: myurl!)
        
        if (url == nil) {
            
        print("Could not find file: \(filename)")
        return
        
        }
        

        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        
        
        if backgroundMusicPlayer == nil {
         print("no nusic")
         return
        }
        //backgroundMusicPlayer.numberOfLoops = -1
        //backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.volume = 0.2
        backgroundMusicPlayer.play()
    }
}*/

import SpriteKit
//引入多媒体框架
import AVFoundation
 
class SoundManager :SKNode{
    //申明一个播放器
    var bgMusicPlayer = SKAction.playSoundFileNamed("bgm_forest.mp3", waitForCompletion: true)
    var victoryPlayer = SKAction.playSoundFileNamed("bgm_victory.mp3", waitForCompletion: true)

    func playBackMusic(){
        self.run(SKAction.repeatForever(bgMusicPlayer))
    }
    
    func playLogin(){
        let music = SKAction.playSoundFileNamed("login2.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playFail(){
        let music = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playDamage(){
        let music = SKAction.playSoundFileNamed("bat_damage.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playOpenDoor(){
           let music = SKAction.playSoundFileNamed("open_door.mp3", waitForCompletion: true)
           self.run(music)
    }
    
    func playOpenDoorFaild(){
           let music = SKAction.playSoundFileNamed("push_door.mp3", waitForCompletion: true)
           self.run(music)
    }
    
    func playOpenFloor(){
        let music = SKAction.playSoundFileNamed("button_bag.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playPickHp(){
           let music = SKAction.playSoundFileNamed("pick_hp.mp3", waitForCompletion: true)
           self.run(music)
    }
    
    func playPickExplore(){
           let music = SKAction.playSoundFileNamed("star.mp3", waitForCompletion: true)
           self.run(music)
    }
    
    func playPickReel(){
        let music = SKAction.playSoundFileNamed("pick_spell.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playPickKey(){
        let music = SKAction.playSoundFileNamed("button_recruit.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playAddHp(){
        let music = SKAction.playSoundFileNamed("drink_hp.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func playPickAttackBottle(){
           let music = SKAction.playSoundFileNamed("pick_mp.mp3", waitForCompletion: true)
           self.run(music)
    }
    
    func playReceiveGood(){
        let music = SKAction.playSoundFileNamed("button_receive.mp3", waitForCompletion: true)
        self.run(music)
    }
    
    func plalVictoryMusic(){
        self.run(victoryPlayer)
    }
    
    func playLevelUp(){
        let music = SKAction.playSoundFileNamed("immolation.mp3", waitForCompletion: true)
        self.run(music)
    }
        
}
