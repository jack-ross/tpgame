//
//  JDSimpleScene.swift
//  Trump Punch
//
//  Created by Jared Downing on 2/4/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

import AudioToolbox

class JDSimpleScene: SKScene, SKPhysicsContactDelegate {
    
  
    //CLASSES
    var trump: JDTrump!
    var quote: JDTrumpQuotes!
 
    var home: JDHomeButtons!
    var arrow: JDArrows!
    var bArrow: JDArrows!
    var twoArrow: JDTwoArrows!
    var boom: JDBoom!
    var medal: JDMedals!
    var label: JDRunningLabels!
    var toMinus: Int = 7
    
    var fishUnlocked: Bool = false
    var tomatoUnlocked: Bool = false
    
    var trumpName: String = ""

    var generationTimer: NSTimer!
    var bombSoundEffect: AVAudioPlayer!
    var timeDial: JDHomeButtons!

    var high: Bool = false
    
    let leftBoom = JDArrows(sizeOf: CGSizeMake(150, 140))
    let rightBoom = JDArrows(sizeOf: CGSizeMake(150, 140))
    
    let leftUp = JDArrows(sizeOf: CGSizeMake(30, 50))
    let rightUp = JDArrows(sizeOf: CGSizeMake(30, 50))
    var timeGone: Int = 0
    
    var timeCount: Int = 300
    
    var doAgain: Int = 1
    var reachedGold: Bool = false
    
    //VARIABLES
    var trumpCount: Int = 0
    var choose = Int(arc4random_uniform(2))
    var genHit = Int(arc4random_uniform(3))
    var continueHit = 0
    var oneHit = false
    var boomGo: Int = 10
    var hitChoice: Int = 0
    var tutorial: Int = 3
    
    var freepunch: Bool = false
    
    var isRunning = true
    var isOnChoose = true
    var isGameOver = false
    var tapUp = false
    var started = 0
    var isGamePaused = false
    var pointText = ""
    var isTimerGoing = false
    var medalToAdd = true
    
    var isSelected = false
    
    var timerStarted = false
    
    var medalType = "Bronze"
    var button = 0
    var startGame: Bool = false
    
    //Gesture Recognizers
    func swipedRight(sender:UISwipeGestureRecognizer){
        print("swiped right")
        if isGameOver == false && isGamePaused == false && startGame == true{
            print("Right Tapped")
            if isGamePaused == false && isGameOver == false && isRunning == true {
                
                
                if isTimerGoing == false {
                   
                    isTimerGoing = true
                  
                }
                
                
                //Render
                let homething = childNodeWithName("Points") as! JDHomeButtons
                
                let pointsLabel = homething.childNodeWithName("pointsLabelNumber") as! JDRunningLabels
                
                let timer = childNodeWithName("Time") as! JDHomeButtons
                
                let timeDial = timer.childNodeWithName("timeDial")
                
                let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                if choose == 0{
                    
                    hitChoice = 1
                    boomGo = 5
                    if oneHit == false{
                        continueHit = 0
                        oneHit = true
                    }
                    else {
                        
                        continueHit = genHit
                        
                    }
                    runAction(playPunch(1))
                    trump.zPosition = 1
                   // genHit = Int(arc4random_uniform(3))
                    
                    
                    if timeCount <= 600{
                        timeDial!.runAction(rotateDial())
                    }
                    
                    isSelected = true
                    button = 7
                    
                   self.trump.fallRight(0)
                    
                    if trumpEx == true {
                        
                        
                        let trumpFell = childNodeWithName("trumpFell") as! JDTrump
                        
                        trumpFell.removeFromParent()
                        trumpEx = false
                        
                    }
                   
                    
                    
                    if weaponNumber.number == 0 {
                        timeCount += 60
                        
                    }
                    else if weaponNumber.number == 1{
                        timeCount += 70
                        
                    }
                    else if weaponNumber.number == 2 {
                        timeCount += 90
                    }
                    
                    
                    tutorial -= 1
                    timeGone = 5
                    
                    
             
                    self.trump.size = CGSizeMake(400,300)
                    
                    
                    if self.timerStarted == false{
                        self.timerStarted = true
                        
                        
                    }
                    
                    
                    
                    pointsLabel.increment()
                    
                    
                    self.medal.runAction(self.growMedal())
                    
                    if Int(pointsLabel.text!)! == silverMedal {
                        self.runAction(self.playMedalSound(1))
                        self.medalType = "Silver"
                        self.medal.removeFromParent()
                        self.addMedal(1)
                        self.medal.zPosition = -2
                        toMinus = 9
                        
                        defaults.setInteger(1, forKey:"fishState")
                        loadWepaonUnlocked()
                        
                        if fishUnlocked == false {
                            let unlocked = SKLabelNode(text:"FISH UNLOCKED!")
                            unlocked.name = "unlocked"
                            unlocked.position = CGPointMake(view!.center.x, view!.center.y)
                            unlocked.fontName = "Helvetica"
                            unlocked.fontSize = 20.0
                            addChild(unlocked)
                            
                            unlocked.runAction(blinkAnimationU())
                        }
                    
                    }
                    else if Int(pointsLabel.text!)! == goldMedal {
                        
                        self.runAction(self.playMedalSound(2))
                        self.medalType = "Gold"
                        self.medal.removeFromParent()
                        self.addMedal(2)
                        self.medal.zPosition = -2
                       
                        self.toMinus = 10
                       
                       
                    }
                    else if Int(pointsLabel.text!)! == crystalMedal {
                        self.reachedGold = true
                        self.runAction(self.playMedalSound(3))
                        self.medalType = "Crystal"
                        self.medal.removeFromParent()
                        self.addMedal(3)
                        self.medal.zPosition = -2
                        toMinus = 12
                        defaults.setInteger(1, forKey:"tomatoState")
                        loadWepaonUnlocked()
                        
                        if tomatoUnlocked == false {
                            let unlocked = SKLabelNode(text:"GLOVES UNLOCKED!")
                            unlocked.name = "unlocked"
                            unlocked.position = CGPointMake(view!.center.x, view!.center.y)
                            unlocked.fontName = "Helvetica"
                            unlocked.fontSize = 20.0
                            addChild(unlocked)
                            
                            unlocked.runAction(blinkAnimationU())
                            
                        }
                    }
                    else if Int(pointsLabel.text!)! == masterMedal {
                        self.runAction(self.playMedalSound(4))
                        self.medalType = "Master"
                        self.medal.removeFromParent()
                        self.addMedal(4)
                        self.medal.zPosition = -2
                        toMinus = 13
                        
                    }
                    
                    
                    choose = Int(arc4random_uniform(2))
                    
                    self.addTrump(0)
                
                    self.addArrows(choose)
               
                }
                    
                else if choose == 1 {
                    trump.zPosition = -20
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    gameOver(2)
                  
                    gameOver(4)
                    
                    print("Bad Right Punch")
                    
                }
            }
        }
        else if freepunch == true {
            
              self.trump.fallRight(0)
            self.trump.size = CGSizeMake(400,300)
            self.trump.zPosition = 1
            hitChoice = 1
            
            boomGo = 5
             self.addTrump(0)
            
            
            
        }
        
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        print("swiped left")
        if isGameOver == false && isGamePaused == false && startGame == true{
            print("Left Tapped")
            if isGamePaused == false && isGameOver == false && isRunning == true {
                
                
                
                if isTimerGoing == false{
                
                    isTimerGoing = true
                   
                    
                }
                
                let homething = childNodeWithName("Points") as! JDHomeButtons
                
                let pointsLabel = homething.childNodeWithName("pointsLabelNumber") as! JDRunningLabels
                
                let timer = childNodeWithName("Time") as! JDHomeButtons
                
                let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
                
                let defaults = NSUserDefaults.standardUserDefaults()
               
                
                let timeDial = timer.childNodeWithName("timeDial")
                if choose == 1{
                    runAction(playPunch(1))
                    trump.zPosition = 1
                    if oneHit == false{
                        continueHit = 0
                        oneHit = true
                    }
                    else {
                        continueHit = genHit
                    }
                   
                    hitChoice = 0
                    boomGo = 5
                  
                    self.trump.fallLeft(0)
                    
                    if trumpExLeft == true {
                        
                        
                        let trumpFellLeft = childNodeWithName("trumpFellLeft") as! JDTrump
                        
                        trumpFellLeft.removeFromParent()
                        trumpExLeft = false
                        
                    }
                    

                    
                    
                   tutorial -= 1
                    if weaponNumber.number == 0 {
                        timeCount += 60
                        
                    }
                    else if weaponNumber.number == 1{
                        timeCount += 70
                        
                    }
                    else if weaponNumber.number == 2 {
                        timeCount += 90
                    }
                    timeDial!.runAction(rotateDial())
              
                    
                   self.trump.size = CGSizeMake(400,300)
                    
              
                    
                    if self.timerStarted == false{
                        self.timerStarted = true
                        
                        
                    }
                    
                    timeGone = 5
                    pointsLabel.increment()
                    self.medal.runAction(self.growMedal())
                    
                    if Int(pointsLabel.text!)! == silverMedal {
                        self.runAction(self.playMedalSound(1))
                        self.medalType = "Silver"
                        self.medal.removeFromParent()
                        self.addMedal(1)
                        self.medal.zPosition = -2
                        toMinus = 9
                        
                        defaults.setInteger(1, forKey:"fishState")
                        loadWepaonUnlocked()
                        if fishUnlocked == false {
                            let unlocked = SKLabelNode(text:"FISH UNLOCKED!")
                            unlocked.name = "unlocked"
                            unlocked.position = CGPointMake(view!.center.x, view!.center.y)
                            unlocked.fontName = "Helvetica"
                            unlocked.fontSize = 20.0
                            addChild(unlocked)
                            
                            unlocked.runAction(blinkAnimationU())
                        }
                    }
                    else if Int(pointsLabel.text!)! == goldMedal {
                        self.reachedGold = true
                        self.runAction(self.playMedalSound(2))
                        self.medalType = "Gold"
                        self.medal.removeFromParent()
                        self.addMedal(2)
                        self.medal.zPosition = -2
                        self.toMinus = 10
                        
                        
                    }
                    else if Int(pointsLabel.text!)! == crystalMedal {
                        
                        self.runAction(self.playMedalSound(3))
                        self.medalType = "Crystal"
                        self.medal.removeFromParent()
                        self.addMedal(3)
                        self.medal.zPosition = -2
                        toMinus = 12
                        defaults.setInteger(1, forKey:"tomatoState")
                        loadWepaonUnlocked()
                        if tomatoUnlocked == false {
                            let unlocked = SKLabelNode(text:"GLOVES UNLOCKED!")
                            unlocked.name = "unlocked"
                            unlocked.position = CGPointMake(view!.center.x, view!.center.y)
                            unlocked.fontName = "Helvetica"
                            unlocked.fontSize = 20.0
                            addChild(unlocked)
                            
                            unlocked.runAction(blinkAnimationU())
                            
                        }
                       
                    }
                    else if Int(pointsLabel.text!)! == masterMedal {
                        self.runAction(self.playMedalSound(4))
                        self.medalType = "Master"
                        self.medal.removeFromParent()
                        self.addMedal(4)
                        self.medal.zPosition = -2
                        toMinus = 13
                       
                    }
                    
                    choose = Int(arc4random_uniform(2))
                    
                    
                    self.addTrump(0)
                    
                    self.addArrows(choose)
                 
                }
                else if choose == 0{
                     AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    trump.zPosition = -20
                    gameOver(2)
                   
                    gameOver(4)
                }
                
                
            }
            
        }
        else if freepunch == true {
            self.trump.fallLeft(0)
            self.trump.size = CGSizeMake(400,300)
            self.trump.zPosition = 1
            hitChoice = 0
            boomGo = 5
            self.addTrump(0)
            
            
            
        }
        
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        print("swiped up")
        
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        print("swiped down")
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            print("tapped")
            tapUp = true
            
            let overTryAgain = childNodeWithName("OverTryAgain")
            let overMenu = childNodeWithName("OverMenu")
            
            if isGameOver {
                
                if button == 2{
                    overTryAgain!.runAction(growPause(), completion: {
                        self.playBackgroundMusic(2)
                        self.runAction(self.buttonSound(), completion: {
                            
                            self.timeTrialScene(0)
                        })
                    })
                    
                }
                else if button == 3{
                    overMenu!.runAction(growPause(), completion: {
                        self.playBackgroundMusic(2)
                        self.runAction(self.buttonSound(), completion: {
                            self.gameScene()
                            
                        })
                        
                    })
                }
            }
            
        }
        else if sender.state == .Began {
            
            tapUp = false
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.whiteColor()
        
        
        let gloveState = JDCandidateNumber(num: 0)
        gloveState.name = "gloveState"
        addChild(gloveState)
        
        let fishState = JDCandidateNumber(num: 0)
        fishState.name = "fishState"
        addChild(fishState)
        
        let tomatoState = JDCandidateNumber(num: 0)
        tomatoState.name = "tomatoState"
        addChild(tomatoState)
        
        loadWeaponUnlocked()
        
        if tomatoState.number == 0 {
            tomatoUnlocked = false
        }
        else {
            tomatoUnlocked = true
        }
        
        if fishState.number == 0 {
            
            fishUnlocked = false
        }
        else {
            fishUnlocked = true
        }
        
        
        
        
        let weapon = JDCandidateNumber(num: 0)
        weapon.name = "weaponNumber"
        addChild(weapon)
        
        loadWeapon()
        
        
        trumpEx = false
        trumpExLeft = false
        
        
        addTrump(0)
        let ready = SKSpriteNode(texture: SKTexture(imageNamed: "Ready.png"))
        ready.size = CGSizeMake(0, 0)
        ready.position.x = view.center.x
        ready.position.y = view.center.y + 200
        addChild(ready)
        
        runAction(readySound())
        ready.runAction(readyInit(), completion: {
            let punch = SKSpriteNode(texture: SKTexture(imageNamed: "Punch.png"))
            punch.size = CGSizeMake(0,0)
            
            punch.position.x = view.center.x
            punch.position.y = view.center.y + 200
            self.addChild(punch)
            self.runAction(self.readyPunchSound())
            punch.runAction(self.punchInit(), completion: {
                
                self.start(1)
                
                
                
                
            })
            
            
            }
            
            
            
        )
        
        
        //Gesture Recognizers
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        
        let handleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.addGestureRecognizer(handleTap)
        
    }
    
    
    //RUNNING LABELS
    func addRunningLabels(num: Int){
        
        if num == 2 {
            
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 3.5, view!.frame.height / 8))
            home.texture = SKTexture(imageNamed: "Clear.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y + 180
            home.name = "Points"
            addChild(home)
            
            //POINTS LABELS
            let settings = SKLabelNode(text: "")
            settings.fontColor = UIColor.whiteColor()
            settings.fontSize = 20.0
            settings.fontName = "Helvetica"
            settings.position = CGPointMake(0, 10)
            home.addChild(settings)
            
            
            
            
            let pointsLabelNumber = JDRunningLabels(num: 0)
            pointsLabelNumber.position = CGPointMake(view!.frame.size.width - 200, view!.frame.size.height - 60)
            pointsLabelNumber.fontSize = 35.0
            pointsLabelNumber.position = CGPointMake(0,-10)
            pointsLabelNumber.name = "pointsLabelNumber"
            pointsLabelNumber.fontColor = UIColor.whiteColor()
            home.addChild(pointsLabelNumber)
            home.runAction(shakeRunnings())
            
        }
            
        else if num == 3{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.3, view!.frame.height / 13))
            home.texture = SKTexture(imageNamed: "Bar_Back.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y + 250
            home.name = "Time"
            addChild(home)
            
            
            let gloss = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.4, view!.frame.height / 24))
            gloss.texture = SKTexture(imageNamed: "Bar_Gloss.png")
            gloss.position = CGPointMake(0, 7)
            gloss.name = "Gloss"
            gloss.zPosition = 70
            home.addChild(gloss)
            
            
            
            
            timeDial = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1, view!.frame.height / 12))
            timeDial.texture = SKTexture(imageNamed: "BarTime.png")
   
            timeDial.position = CGPointMake(-146,0)
            timeDial.name = "timeDial"
            timeDial.zPosition = 25
            home.addChild(timeDial)
            
            
        }
    }
    
    func removeRunningLabels(){
        
        //POINTS LABELS
        let pointsLabelNumber = childNodeWithName("pointsLabelNumber") as! JDRunningLabels
        pointsLabelNumber.removeFromParent()
        
        let timeLabelNumber = childNodeWithName("timeLabelNumber") as! JDRunningLabels
        timeLabelNumber.removeFromParent()
        
    }
    
    func loadWeapon(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
        
        weaponNumber.setTo(defaults.integerForKey("weapon"))
    }
    
    func loadWeaponUnlocked(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let gloveState = childNodeWithName("gloveState") as! JDCandidateNumber
        let fishState = childNodeWithName("fishState") as! JDCandidateNumber
        let tomatoState = childNodeWithName("tomatoState") as! JDCandidateNumber
        
        gloveState.setTo(defaults.integerForKey("gloveState"))
        fishState.setTo(defaults.integerForKey("fishState"))
        tomatoState.setTo(defaults.integerForKey("tomatoState"))
        
        
        
    }
    
    func addScreenParts(num: Int){
        
        if num == 1{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 2, view!.frame.height))
            home.texture = SKTexture(imageNamed: "Clear.png")
            home.position.x = view!.center.x - 100
            home.position.y = view!.center.y
            home.name = "LeftScreen"
            addChild(home)
            home.zPosition = 20
        }
        else if num == 2 {
            
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 2, view!.frame.height))
            home.texture = SKTexture(imageNamed: "Clear.png")
            home.position.x = view!.center.x + 100
            home.position.y = view!.center.y
            home.name = "RightScreen"
            addChild(home)
            home.zPosition = 20
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            let touchedNode = self.nodeAtPoint(location)
            
            if let name = touchedNode.name
            {
                
                
                let overTryAgain = childNodeWithName("OverTryAgain")
                let overMenu = childNodeWithName("OverMenu")
             
               
                if name == "Pause" || name == "PauseT"
                {
                    runAction(buttonSound(), completion: {
                        self.playBackgroundMusic(1)
                       
                    })
                    
                }
                
                    
                    //GAME OVER
                else if isGameOver {
                    
                    if name == "OverMenu" || name == "OverMenuT"{
                        button = 3
                        
                        overMenu!.runAction(shrinkPause())
                        
                    }
                        
                    else if name == "OverTryAgain" || name == "OverTryAgainT"{
                       
                        
                        button = 2
                        
                        overTryAgain!.runAction(shrinkPause())
                    }
                    
                }
                
            }
            
        }
    }
    
    var timeLeft: Float = 5 {
        didSet {
            timeLeft = max(min(timeLeft, 10), 0)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
        if doAgain == 0 {
            doAgain = 1
            twoRun()
            
        }
        if timeCount <= 0 && !isGameOver {
            trump.zPosition = -20
            gameOver(2)
            gameOver(4)
            
        }
        
        
        if timeCount > 610 {
            timeCount = 600
        }
        
        addBooms()
    }
    
    func timeTrialScene(num: Int){
        let newScene = JDSimpleScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        view!.presentScene(newScene)
        
    }
    

    func twoRun() {
        let timer = childNodeWithName("Time") as! JDHomeButtons
        let timeDial = timer.childNodeWithName("timeDial")

        timeDial?.runAction(rotateDial(), completion: {
            self.doAgain = 0})
    }
    
    
    //GAME
    //STATE
    func start(num: Int) {
        
        isRunning = true
        isGameOver = false
        isGamePaused = false
        
        addRunningLabels(3)
        
        let left = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 6, view!.frame.height / 6))
        let right = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 6, view!.frame.height / 6))
        let left2 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 6, view!.frame.height / 6))
        let right2 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 6, view!.frame.height / 6))
        
        let left3 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 8, view!.frame.height / 10))
        let right3 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 8, view!.frame.height / 10))
        let left4 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 8, view!.frame.height / 10))
        let right4 = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 8, view!.frame.height / 10))
        
        left.position.y = view!.center.y
        left.position.x = view!.center.x - 130
        right.position.x = view!.center.x - 130
        left.zPosition = 15
        right.position.y = view!.center.y
        right.zPosition = 15
        left.name = "leftFrontArrow"
        right.name = "rightFrontArrow"
        
        left2.position.y = view!.center.y
        left2.position.x = view!.center.x + 130
        right2.position.x = view!.center.x + 130
        left2.zPosition = 15
        right2.position.y = view!.center.y
        right2.zPosition = 15
        left2.name = "leftFrontArrow2"
        right2.name = "rightFrontArrow2"
        
        left3.position.y = view!.center.y + 170
        left3.position.x = view!.center.x - 60
        right3.position.x = view!.center.x + 60
        left3.zPosition = 15
        right3.position.y = view!.center.y + 170
        right3.zPosition = 15
        left3.name = "leftFrontArrow3"
        right3.name = "rightFrontArrow3"
        
        
        left4.position.y = view!.center.y + 170
        left4.position.x = view!.center.x - 60
        right4.position.x = view!.center.x + 60
        left4.zPosition = 15
        right4.position.y = view!.center.y + 170
        right4.zPosition = 15
        left4.name = "leftFrontArrow4"
        right4.name = "rightFrontArrow4"
        
        
        
        
        left.texture = SKTexture(imageNamed:"FinalLeftArrow.png")
        right.texture = SKTexture(imageNamed:"FinalRightArrow.png")
        left2.texture = SKTexture(imageNamed:"FinalLeftArrow.png")
        right2.texture = SKTexture(imageNamed:"FinalRightArrow.png")
        
        left3.texture = SKTexture(imageNamed:"FinalLeftArrow.png")
        right3.texture = SKTexture(imageNamed:"FinalRightArrow.png")
        left4.texture = SKTexture(imageNamed:"FinalLeftArrow.png")
        right4.texture = SKTexture(imageNamed:"FinalRightArrow.png")
        
        addMedal(0)
      
        
        addRunningLabels(2)
        addChild(left)
        addChild(right)
        addChild(left2)
        addChild(right2)
        
        addChild(left3)
        addChild(right3)
        addChild(left4)
        addChild(right4)
        
        left.hidden = true
        right.hidden = true
        left2.hidden = true
        right2.hidden = true
        
        left3.hidden = true
        right3.hidden = true
        left4.hidden = true
        right4.hidden = true
        
        let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
        
        
        
        let leftB = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 2, view!.frame.height / 9))
        let rightB = JDArrows(sizeOf: CGSizeMake(view!.frame.width / 2, view!.frame.height / 9))
        
        leftB.position.y = view!.center.y - 200
        leftB.position.x = view!.center.x
        rightB.position.x = view!.center.x
        leftB.zPosition = 15
        rightB.position.y = view!.center.y - 200
        rightB.zPosition = 15
        leftB.name = "leftBackArrow"
        rightB.name = "rightBackArrow"
        
        leftB.texture = SKTexture(imageNamed:"SwipeLeft.png")
        rightB.texture = SKTexture(imageNamed:"SwipeRight.png")
        addChild(leftB)
        addChild(rightB)
        addArrows(choose)
        
     
        
        leftBoom.position.y = view!.center.y
        leftBoom.position.x = view!.center.x
        rightBoom.position.x = view!.center.x
        leftBoom.zPosition = 15
        rightBoom.position.y = view!.center.y
        rightBoom.zPosition = 15
        leftBoom.name = "leftBoomArrow"
        rightBoom.name = "rightBoomArrow"
        
        if weaponNumber.number == 0{
            leftBoom.texture = SKTexture(imageNamed:"Tomato_Left3.png")
            rightBoom.texture = SKTexture(imageNamed:"Tomato_Right3.png")
        }
        else if weaponNumber.number == 1{
            leftBoom.texture = SKTexture(imageNamed:"Fish_Left.png")
            rightBoom.texture = SKTexture(imageNamed:"Fish_Right.png")
            
        }
        else if weaponNumber.number == 2{
            leftBoom.texture = SKTexture(imageNamed:"FinalLeftGlove.png")
            rightBoom.texture = SKTexture(imageNamed:"FinalRightGlove.png")
        }
        
     
        addChild(leftBoom)
        addChild(rightBoom)
        
      
        leftBoom.hidden = true
        rightBoom.hidden = true
       
        startGame = true
        doAgain = 0
    }
    
    func loadHighScore(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let highScoreLabel = medal.childNodeWithName("highScore") as! JDRunningLabels
        highScoreLabel.setTo(defaults.integerForKey("highscore"))
        
        
    }
    
    func loadWepaonUnlocked(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let gloveState = childNodeWithName("gloveState") as! JDCandidateNumber
        let fishState = childNodeWithName("fishState") as! JDCandidateNumber
        let tomatoState = childNodeWithName("tomatoState") as! JDCandidateNumber
        
        gloveState.setTo(defaults.integerForKey("gloveState"))
        fishState.setTo(defaults.integerForKey("fishState"))
        tomatoState.setTo(defaults.integerForKey("tomatoState"))
        
        
        
    }
   
    
    func addBooms(){
        

        if boomGo > 0 {
           
            
            if hitChoice == 0{
                leftBoom.hidden = false
                if startGame == true{
                   // trump.texture = SKTexture(imageNamed: "Trump_Left.png")
                  //  trump.size = CGSizeMake(300, 250)
                }
              
                
            }
            else if hitChoice == 1{
                rightBoom.hidden = false
                if startGame == true {
                    //trump.texture = SKTexture(imageNamed: "Trump_Right.png")
                //trump.size = CGSizeMake(300, 250)
                }
               
            }
            leftUp.hidden = false
            rightUp.hidden = false
       
            boomGo -= 1
            
            
        }
        if boomGo == 0 {
            leftBoom.hidden = true
            rightBoom.hidden = true
            leftUp.hidden = true
            rightUp.hidden = true
            trump.size = CGSizeMake(300, 300)
            trump.texture = SKTexture(imageNamed: "Trump.png")
            
        }
    }
    
    
    func gameOver(var num: Int){
        isGameOver = true
        isGamePaused = false
        isRunning = false
      
        let medal = childNodeWithName("Medal") as! JDMedals
        let points = childNodeWithName("Points") as! JDHomeButtons
        let pointsLabelNumber = points.childNodeWithName("pointsLabelNumber") as! JDRunningLabels
        let left = childNodeWithName("leftFrontArrow") as! JDArrows
        let right = childNodeWithName("rightFrontArrow") as! JDArrows
        let left2 = childNodeWithName("leftFrontArrow2") as! JDArrows
        
        let right2 = childNodeWithName("rightFrontArrow2") as! JDArrows
        
        let left3 = childNodeWithName("leftFrontArrow3") as! JDArrows
        let right3 = childNodeWithName("rightFrontArrow3") as! JDArrows
        let left4 = childNodeWithName("leftFrontArrow4") as! JDArrows
        
        let right4 = childNodeWithName("rightFrontArrow4") as! JDArrows
        
        
        left.hidden = true
        right.hidden = true
    
        left.hidden = false
        right.hidden = true
        
        left2.hidden = true
        right2.hidden = false
        
        left.runAction(growArrowEnd())
        right2.runAction(growArrowEnd())
        
        left.size = CGSizeMake(view!.frame.width / 10, view!.frame.height / 13)
        right2.size = CGSizeMake(view!.frame.width / 10, view!.frame.height / 13)
        
        left3.hidden = true
        right3.hidden = true
        left4.hidden = true
        right4.hidden = true
        
        
        hideGame()
        print("GAME OVER")
        medal.zPosition = 20
        points.zPosition = 21
        points.runAction(self.highMoveMedal())
        
        
        medal.runAction(highMoveMedal())
            
            if num == 4{
              
                //ADD SCORING STUFF
                self.home = JDHomeButtons(size:CGSizeMake(0, 0))
                self.home.texture = SKTexture(imageNamed: "DoneScore.png")
                self.home.size = CGSizeMake(self.view!.frame.width / 1.3, self.view!.frame.height / 4.8)
                self.home.position.x = self.view!.center.x
                self.home.position.y = self.view!.center.y + 190
                self.home.name = "scoreLabel"
                self.addChild(self.home)
                
                
                self.freepunch = true
                //CREATE QUOTE
                self.quote = JDTrumpQuotes(num: 0)
                
                self.home.addChild(self.quote)
                
                self.medal = JDMedals(sizeOf: CGSizeMake(10,10))
                self.medal.zPosition = 22
                self.medal.position.x = self.view!.center.x - 110
                self.medal.position.y = self.view!.center.y - 60
                self.medal.size = CGSizeMake(50,50)
                
                self.label = JDRunningLabels(num: 0)
                self.label.fontSize = 20.0
                
                self.label.position = CGPointMake(0, -7)
                
                self.label.name = "highScore"
                self.label.zPosition = 23
             
          
                
                self.addChild(self.medal)
                
                self.medal.addChild(self.label)
                self.medal.runAction(self.shakeMedal())
                self.loadHighScore()
                
                if self.label.number >= silverMedal && self.label.number < goldMedal{
               
                    self.medal.texture = SKTexture(imageNamed:"Silver_Medal.png")
                }
                if self.label.number >= goldMedal {
                 
                    self.medal.texture = SKTexture(imageNamed: "Gold_Medal.png")
                    
                }
                if self.label.number >= crystalMedal {
             
                    self.medal.texture = SKTexture(imageNamed: "Crystal_Medal.png")
                    
                }
                if self.label.number >= masterMedal {
                
                    self.medal.texture = SKTexture(imageNamed: "Master_Medal.png")
                    
                }
                
                if self.label.number < pointsLabelNumber.number {
                    self.high = true
                }
                
                
                //If New High Score
                if self.label.number < pointsLabelNumber.number{
                 
                   
                    self.label.setTo(pointsLabelNumber.number)
                    self.runAction(self.highScoreSound(), completion: {self.playBackgroundMusic(1)})
                    
                    
                    if self.high == true {
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setInteger(self.label.number, forKey:"highscore")
                    }
                
                    if self.tutorial <= 0 {
                        let trumpPunchLabel = JDHomeButtons(size: CGSizeMake(self.view!.frame.width / 1.5, self.view!.frame.height / 12))
                        trumpPunchLabel.position.x = self.view!.center.x
                        trumpPunchLabel.position.y = self.view!.center.y - 220
                         trumpPunchLabel.name = "gameOverButton"
                        if self.high == true {
                            
                            trumpPunchLabel.texture = SKTexture(imageNamed:"HighScore.png")
                            
                        }
                       
                        
                        self.addChild(trumpPunchLabel)
                        
                        
                    }
                  
                    
                    self.medal.removeFromParent()
                    self.label.removeFromParent()
                  
                }
                else {
                    if self.tutorial <= 0 {
                        let trumpPunchLabel = JDHomeButtons(size: CGSizeMake(self.view!.frame.width / 1.5, self.view!.frame.height / 12))
                        trumpPunchLabel.position.x = self.view!.center.x
                        trumpPunchLabel.position.y = self.view!.center.y - 220
                        trumpPunchLabel.name = "gameOverButton"
                      
                            trumpPunchLabel.texture = SKTexture(imageNamed:"Choke.png")
                            
                        
                        
                        
                        self.addChild(trumpPunchLabel)
                    }
                   
                    
                }
                self.home.runAction(self.growEndLarge(), completion:
                    {
                        
                        num = 3
                        if num == 3{
                            
                            self.home = JDHomeButtons(size:CGSizeMake(0, 0))
                            self.home.texture = SKTexture(imageNamed: "Button_Home.png")
                            self.home.position.x = self.view!.center.x - 80
                            self.home.position.y = self.view!.center.y - 130
                            self.home.name = "OverMenu"
                            self.addChild(self.home)
                            self.home.runAction(self.growEndSmall())
                            
                            //  self.home.runAction(self.wigglePause())
                            
                            let settings = SKLabelNode(text: "")
                            settings.fontColor = UIColor.whiteColor()
                            settings.fontSize = 25.0
                            settings.fontName = "Helvetica"
                            settings.position = CGPointMake(0, -8)
                            settings.name = "OverMenuT"
                            self.home.addChild(settings)
                            num = 1
                        }
                        if num == 1 {
                            self.home = JDHomeButtons(size:CGSizeMake(0, 0))
                            self.home.texture = SKTexture(imageNamed: "Button_Play.png")
                            
                            self.home.position.x = self.view!.center.x + 80
                            self.home.position.y = self.view!.center.y - 130
                            self.home.name = "OverTryAgain"
                            
                            
                            self.addChild(self.home)
                            self.home.runAction(self.growEndSmall())
                            
                            //self.home.runAction(self.wigglePause())
                            
                            let settings = SKLabelNode(text: "")
                            settings.fontColor = UIColor.whiteColor()
                            settings.fontSize = 25.0
                            settings.fontName = "Helvetica"
                            settings.position = CGPointMake(0, -8)
                            settings.name = "OverTryAgainT"
                            self.home.addChild(settings)
                           
                            
                            
                        }
                        
                    })
                }
            
            
        
    }
    
    
    func gameScene(){
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        view!.presentScene(newScene)
    }
    
    
    func hideGame(){
        let time = childNodeWithName("Time") as! JDHomeButtons
        time.hidden = true
    }
    
    
    func unhideGame(){
        isGamePaused = false
        isGameOver = false
        isRunning = true
        trump.hidden = false
       
        let time = childNodeWithName("Time")
        let points = childNodeWithName("Points")
        
        time!.hidden = false
        points!.hidden = false
        
        
    }
   
    
    func hideGameOver(){
        isGameOver = false
        isRunning = true
        let pauseLabel = childNodeWithName("gameOverButton")
        
     //   let pauseLabelThing = childNodeWithName("Share") as! JDHomeButtons
        
        let tryAgain = childNodeWithName("OverTryAgain") as! JDHomeButtons
        let menu = childNodeWithName("OverMenu") as! JDHomeButtons
        
        let score = childNodeWithName("scoreLabel") as! JDHomeButtons
        
      //  pauseLabelThing.removeFromParent()
        
        tryAgain.removeFromParent()
        menu.removeFromParent()
        pauseLabel!.removeFromParent()
        score.removeFromParent()
        
        
    }
    
    
    //TRUMP
    //ATTRIBUTES
    func addTrump(w: Int){
        
        trump = JDTrump(w: w)
        
        trump.position.x = view!.center.x
        trump.position.y = view!.center.y - 30
        trump.zPosition = -1
        trump.name = "trumpUp"
        
        addChild(trump)
        trump.runAction(growCandidate())
        trump.runAction(shakeCandidate())
    }
    
    func addQuote(w: Int, choose: Int ){
        home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.2, view!.frame.height / 7))
        if choose == 0{
            home.texture = SKTexture(imageNamed: "Home_Blue.png")
        }
        else if choose == 1{
            home.texture = SKTexture(imageNamed: "Home_Red.png")
        }
        
        home.position.x = view!.center.x
        home.position.y = view!.center.y + 180
        home.name = "quoteBack"
        addChild(home)
        
        quote = JDTrumpQuotes(num: w)
        
        quote.position = CGPointMake(0, 0)
        quote.name = "quoteBackT"
        
        home.addChild(quote)
        home.runAction(growQuote())
    }
    
    func addArrows(w: Int) {
        
        let left = childNodeWithName("leftFrontArrow") as! JDArrows
        
        let right = childNodeWithName("rightFrontArrow") as! JDArrows
        
        let left2 = childNodeWithName("leftFrontArrow2") as! JDArrows
        
        let right2 = childNodeWithName("rightFrontArrow2") as! JDArrows
        
        let left3 = childNodeWithName("leftFrontArrow3") as! JDArrows
        
        let right3 = childNodeWithName("rightFrontArrow3") as! JDArrows
        
        let left4 = childNodeWithName("leftFrontArrow4") as! JDArrows
        
        let right4 = childNodeWithName("rightFrontArrow4") as! JDArrows
        
        
        
        let leftB = childNodeWithName("leftBackArrow") as! JDArrows
        
        let rightB = childNodeWithName("rightBackArrow") as! JDArrows
        
        
        if w == 0{
            
            right.hidden = false
            right2.hidden = false
            left.hidden = true
            left2.hidden = true
            
            right3.hidden = false
            right4.hidden = false
            left3.hidden = true
            left4.hidden = true
            if tutorial > 0 {
                leftB.hidden = true
                rightB.hidden = false
            }
            
        }
        else if w == 1{
            
            left.hidden = false
            right.hidden = true
            left2.hidden = false
            right2.hidden = true
            
            left3.hidden = false
            right3.hidden = true
            left4.hidden = false
            right4.hidden = true
            if tutorial > 0 {
                leftB.hidden = false
                rightB.hidden = true
            }
            
            
            
        }
        
        if tutorial <= 0 {
            leftB.hidden = true
            rightB.hidden = true
        }
        
        leftB.runAction(growArrowB())
        rightB.runAction(growArrowB())
       
        left.runAction(growArrow())
        right.runAction(growArrow())
        left2.runAction(growArrow())
        right2.runAction(growArrow())
        left4.runAction(growSmallArrow())
        right4.runAction(growSmallArrow())
        left3.runAction(growSmallArrow())
        right3.runAction(growSmallArrow())
    }
    
    
    
    func addBottomArrows(w: Int) {
        let left = childNodeWithName("leftBackArrow") as! JDArrows
        let right = childNodeWithName("rightBackArrow") as! JDArrows
        
        if w == 0{
            
            left.texture = SKTexture(imageNamed:"BoxLeft.png")
            right.texture = SKTexture(imageNamed:"BoxRight.png")
            
            
        }
        else if w == 1{
            
            left.texture = SKTexture(imageNamed:"BoxLeft.png")
            right.texture = SKTexture(imageNamed:"Crown.png")
            
            
            
        }
        else if w == 2{
            
            left.texture = SKTexture(imageNamed:"Crown.png")
            right.texture = SKTexture(imageNamed:"BoxRight.png")
            
            
            
        }
        
        left.runAction(growBackArrow())
        right.runAction(growBackArrow())
        
    }
    
    
    func addTwoArrow(w: Int) {
        twoArrow = JDTwoArrows(sizeOf: CGSizeMake(view!.frame.width / 5, view!.frame.height / 8))
        boom = JDBoom(sizeOf: CGSizeMake(view!.frame.width / 5, view!.frame.height / 8))
        
        twoArrow.position.y = view!.center.y
        twoArrow.zPosition = 50
        twoArrow.name = "twoArrow"
        boom.position.y = view!.center.y
        boom.zPosition = 49
        boom.name = "boom"
        boom.position.x = view!.center.x
        boom.texture = SKTexture(imageNamed: "Boom.png")
        boom.size = CGSizeMake(100,100)
        if w == 0{
            twoArrow.position.x = view!.center.x
            twoArrow.texture = SKTexture(imageNamed:"BoxLeft.png")
            
            twoArrow.size = CGSizeMake(view!.frame.width / 5, 40)
            
            
        }
        else if w == 1{
            twoArrow.position.x = view!.center.x
            twoArrow.texture = SKTexture(imageNamed:"BoxRight.png")
            twoArrow.size = CGSizeMake(view!.frame.width / 5, 40)
            
            
        }
        
        addChild(twoArrow)
        addChild(boom)
        
        
    }
    
    
    
    func addMedal(w: Int) {
        medal = JDMedals(sizeOf: CGSizeMake(70, 70))
        
        medal.position.x = view!.center.x
        medal.position.y = view!.center.y + 180
        medal.name = "Medal"
        if w == 0{
            
            medal.texture = SKTexture(imageNamed:"Bronze_Medal.png")
            
        }
        else if w == 1{
            medal.texture = SKTexture(imageNamed:"Silver_Medal.png")
            
        }
        else if w == 2{
            medal.texture = SKTexture(imageNamed:"Gold_Medal.png")
            
        }
        else if w == 3{
            medal.texture = SKTexture(imageNamed:"Crystal_Medal.png")
            
        }
        else if w == 4{
            medal.texture = SKTexture(imageNamed:"Master_Medal.png")
            
        }
        else if w == 5{
            medal.texture = SKTexture(imageNamed:"Legend_Medal.png")
            
        }
        
        addChild(medal)
        medal.runAction(growMedal())
        medal.runAction(shakeMedal())
        
        
    }
    
    
    
    
    
    //ANIMATIONS
    func blinkAnimation() -> SKAction {
        let duration = 0.8
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatActionForever(blink)
    }
    
    func blinkAnimationU() -> SKAction {
        let duration = 0.8
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeIn,fadeOut])
        return SKAction.repeatAction(blink, count: 1)
    }
    
    func growTrump() -> SKAction {
        let duration = 0.2
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    func pop() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 8, height: view!.frame.height / 13, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 5, height: view!.frame.height / 7.5, duration: 0.1)
        
        let blink = SKAction.sequence([shrink, grow])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    func pop2() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 2.6, height: view!.frame.height / 14, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 2.3, height: view!.frame.height / 12, duration: 0.1)
        
        let blink = SKAction.sequence([shrink, grow])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    func growCandidate() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(300, height: 300, duration: 0.1)
        let grow = SKAction.resizeToWidth(330, height: 330, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    //GLOVE ACTIONS
    func growArrow() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 6, height: view!.frame.height / 6, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 4.5, height: view!.frame.height / 5, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    
    func growSmallArrow() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 8, height: view!.frame.height / 10, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 7, height: view!.frame.height / 8, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    
    
    func growArrowB() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.2, height: view!.frame.height / 8, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 1, height: view!.frame.height / 6, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    
    
    
    
    func growBackArrow() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 6, height: view!.frame.height / 9, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 4, height: view!.frame.height / 7, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    
    
    func growMedal() -> SKAction{
        let shrink = SKAction.resizeToWidth(70, height: 70, duration: 0.1)
        let grow = SKAction.resizeToWidth(75, height: 75, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    func shrinkHit() -> SKAction{
        let blink = SKAction.resizeToWidth(view!.frame.width / 100, height: 10, duration: 0.2)
        
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    func shakeCandidate() -> SKAction{
        let shrink = SKAction.rotateByAngle(0.1, duration: 0.2)
        let grow = SKAction.rotateByAngle(-0.1, duration: 0.2)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatActionForever(blink)
        
        
        
        
    }
    func shakeRunnings() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 3.5, height: view!.frame.height / 8, duration: 1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 3.4, height: view!.frame.height / 7.8, duration: 1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatActionForever(blink)
        
        
        
        
    }
    
    func shakeTime() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 6, height: view!.frame.height / 12, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 4.5, height: view!.frame.height / 9.0, duration: 0.8)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatActionForever(blink)
        
    }
    func shrinkRunnings() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 3.3, height: view!.frame.height / 7.6, duration: 0.2)
        let grow = SKAction.resizeToWidth(0, height: 0, duration: 0.5)
        
        let blink = SKAction.sequence([shrink, grow])
        return SKAction.repeatAction(blink, count: 1)
        
        
        
        
    }
    
    func wigglePause() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.3, height: view!.frame.height / 8, duration: 0.7)
        let grow = SKAction.resizeToWidth(view!.frame.width / 1.33, height: view!.frame.height / 8.3, duration: 1)
        
        let blink = SKAction.sequence([shrink, grow])
        
        return SKAction.repeatActionForever(blink)
        
        
        
        
    }
    
    func shakeMedal() -> SKAction {
        
        let shrink = SKAction.rotateByAngle(0.05, duration: 0.2)
        let grow = SKAction.rotateByAngle(-0.05, duration: 0.2)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatActionForever(blink)
        
        
        
    }
    
    
    
    
    func growQuote() -> SKAction {
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.2, height: view!.frame.height / 7, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 1.1, height: view!.frame.height / 6.8, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    
    //STARTERS
    func readyInit() -> SKAction {
        
        
        let moveDown = SKAction.resizeToWidth(view!.frame.width / 1.5, height: view!.frame.height / 9, duration: 0.2)
        
        let shake = SKAction.rotateByAngle(0.1, duration: 0.1)
        let shakeB = SKAction.rotateByAngle(-0.1, duration: 0.1)
        
        let moveUp = SKAction.resizeToWidth(0, height: 0, duration: 0.2)
        
        
        //let revolution = SKAction.sequence([rotate, yellow, rotate, red, rotate])
        
        let again = SKAction.sequence([moveDown, shake, shakeB, shakeB, shake, shake, shakeB,shakeB, shake, shake, shakeB, shakeB, shake, shake, shakeB, shakeB, shake, shake, moveUp])
        return SKAction.repeatAction(again, count: 1)
        
        
        
    }
    
    func punchInit() -> SKAction {
        
        let moveDown = SKAction.resizeToWidth(view!.frame.width / 1.5, height: view!.frame.height / 9, duration: 0.2)
        
        let shake = SKAction.rotateByAngle(0.1, duration: 0.1)
        let shakeB = SKAction.rotateByAngle(-0.1, duration: 0.1)
        
        let moveUp = SKAction.resizeToWidth(0, height: 0, duration: 0.1)
        
        
        //let revolution = SKAction.sequence([rotate, yellow, rotate, red, rotate])
        
        let again = SKAction.sequence([moveDown, shake, shakeB, moveUp])
        return SKAction.repeatAction(again, count: 1)
        
    }
    
    func disappear() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(0, height:0, duration: 0.2)
        
        
        return SKAction.repeatAction(shrink, count: 1)
    }
    
    func moveMedal() -> SKAction {
        let move = SKAction.moveToY(view!.center.y + 220, duration: 1)
        
        return SKAction.repeatAction(move, count: 1)
        
    }
    func highMoveMedal() -> SKAction {
        let move = SKAction.moveToY(view!.center.y - 60, duration: 2)
         let xmove = SKAction.moveToX(view!.center.x + 110, duration: 0.5)
        
        let go = SKAction.sequence([move,xmove])
  
        return SKAction.repeatAction(go, count: 1)
        
    }
    
    func growEndLarge() -> SKAction {
        
        
        let grow = SKAction.resizeToWidth(view!.frame.width / 1.2, height: view!.frame.height / 4.4, duration: 0.2)
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.3, height: view!.frame.height / 4.6, duration: 0.1)
        
        let wiggleOne = SKAction.rotateByAngle(0.02, duration: 0.1)
        let wiggleTwo = SKAction.rotateByAngle(-0.02, duration: 0.1)
        
        let through = SKAction.sequence([grow,shrink,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne])
        
        return SKAction.repeatAction(through, count: 1)
        
        
        
    }
    
    func growEndSmall() -> SKAction {
        
        
        let grow = SKAction.resizeToWidth(view!.frame.width / 2, height: view!.frame.height / 7.5, duration: 0.2)
        let shrink = SKAction.resizeToWidth(view!.frame.width / 2.5, height: view!.frame.height / 8, duration: 0.1)
        
        let wiggleOne = SKAction.rotateByAngle(0.02, duration: 0.1)
        let wiggleTwo = SKAction.rotateByAngle(-0.02, duration: 0.1)
        
        let through = SKAction.sequence([grow,shrink,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne])
        
        return SKAction.repeatAction(through, count: 1)
        
        
        
    }
    
    func shrinkPause() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 3, height: view!.frame.height / 10, duration: 0.1)
        
        return SKAction.repeatAction(shrink, count: 1)
        
    }
    
    func growPause() -> SKAction {
        
        let grow = SKAction.resizeToWidth(view!.frame.width / 2.5, height: view!.frame.height / 8, duration: 0.1)
        
        return SKAction.repeatAction(grow, count: 1)
        
    }
    
    func appearPause() -> SKAction {
        
        let xcenter = SKAction.moveToX(view!.center.x, duration: 0.01)
        
        let grow = SKAction.resizeToWidth(view!.frame.width / 5, height: view!.frame.height / 9, duration: 0.2)
        
        let act = SKAction.sequence([xcenter,grow])
        
        return SKAction.repeatAction(act, count: 1)
        
    }
    
    func playPunch(num: Int) -> SKAction {
         let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
        
        var play: SKAction!
        
        if num == 1 {
            if weaponNumber.number == 2 {
                 play = SKAction.playSoundFileNamed("Punch.mp3", waitForCompletion: true)
                
                
            }
            else if weaponNumber.number == 1{
                
                play = SKAction.playSoundFileNamed("Punch.mp3", waitForCompletion: true)
                
            }
            else if weaponNumber.number == 0 {
                play = SKAction.playSoundFileNamed("Tomato.mp3", waitForCompletion: true)
                
                
            }
           
        }
        
        if num == 2 {
            play = SKAction.playSoundFileNamed("Wrong Button.mp3", waitForCompletion: true)
        }
        
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    
    func buttonSound() -> SKAction {
        
        let play = SKAction.playSoundFileNamed("Button Pressed.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    func readySound() -> SKAction {
        
        let play = SKAction.playSoundFileNamed("Ready.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    
    func readyPunchSound() -> SKAction {
        
        let play = SKAction.playSoundFileNamed("PUNCH!.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
    }
    
    func timeTickSound() -> SKAction {
        let play = SKAction.playSoundFileNamed("Time Tick.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    
    func alertTimeTickSound() -> SKAction {
        let play = SKAction.playSoundFileNamed("Time Tick Alert.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
    }
    
    func chokeSound() -> SKAction {
        
        let play = SKAction.playSoundFileNamed("Game Over (Choke).mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
    }
    
    func highScoreSound() -> SKAction {
        let play = SKAction.playSoundFileNamed("High Score.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
    }
    
    func playBackgroundMusic(num: Int) {
        
        let path = NSBundle.mainBundle().pathForResource("App Music.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOfURL: url)
            
            bombSoundEffect.numberOfLoops = -1
            if num == 1{
                bombSoundEffect.play()
            }
            else {
                bombSoundEffect.pause()
            }
            
        } catch {
            // failure
        }
        
    }
    
    func playMedalSound(num: Int) -> SKAction {
        var play: SKAction!
        
        if num == 1 {
            
            play = SKAction.playSoundFileNamed("Silver Medal.mp3", waitForCompletion: true)
        }
        
        if num == 2 {
            play = SKAction.playSoundFileNamed("Gold Medal.mp3", waitForCompletion: true)
        }
        if num == 3 {
            play = SKAction.playSoundFileNamed("Crystal Medal.mp3", waitForCompletion: true)
        }
        if num == 4 {
            play = SKAction.playSoundFileNamed("Master Medal.mp3", waitForCompletion: true)
        }
        if num == 5 {
            play = SKAction.playSoundFileNamed("Legend Medal.mp3", waitForCompletion: true)
        }
        
        
        return SKAction.repeatAction(play, count: 1)
    }
    
    func rotateDial() -> SKAction {
        let shrink = SKAction.resizeToWidth(CGFloat(timeCount), duration: 0.05)
        
        timeCount -= toMinus
        return SKAction.repeatAction(shrink, count: 1)
        
        
        
    }
    
    func growArrowEnd() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 9, height: view!.frame.height / 13, duration: 0.4)
        let grow = SKAction.resizeToWidth(view!.frame.width / 8, height: view!.frame.height / 12, duration: 0.4)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatActionForever(blink)
        
        
        
        
    }

    
}
