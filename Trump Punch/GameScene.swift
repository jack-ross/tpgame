//
//  GameScene.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/23/16.
//  Copyright (c) 2016 Ideals. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    //SCENES

    var time: JDTimeNumber!
    var home: JDHomeButtons!
    var label: JDRunningLabels!
    var medal: JDMedals!
    var trump: JDTrump!
    
    //VARIABLES
    var trumpCount: Int = 0
    var choose = Int(arc4random_uniform(2))
    var isStarted = false
    var isOnChoose = true
    var button = 0
    var tapUp = false
    var started = 0
    var pointText = ""
    var bombSoundEffect: AVAudioPlayer!
    
    
    var boomGo: Int = 0
    
    var hitChoice: Int = 0
    
    
    let leftBoom = JDArrows(sizeOf: CGSizeMake(150, 140))
    let rightBoom = JDArrows(sizeOf: CGSizeMake(150, 140))
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        print("swiped right")
        
        let topBar = childNodeWithName("TopBar") as! JDHomeButtons
          let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
        
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
        
           self.playBackgroundMusic(2)
                    hitChoice = 1
                    boomGo = 5
                   
                   
                    runAction(playPunch(1))
                    trump.zPosition = 1
                   
                    
                    button = 7
                    
                    self.trump.fallRight(0)
        
        if trumpEx == true {
            
            let trumpFell = childNodeWithName("trumpFell") as! JDTrump
            
            trumpFell.removeFromParent()
            trumpEx = false
            
        }
        
                    self.trump.size = CGSizeMake(400,300)
        topBar.runAction(self.topBarUp(), completion: {
            self.trump.removeFromParent()
            self.runSceneGo()
            
        })
        
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        print("swiped left")
        let topBar = childNodeWithName("TopBar") as! JDHomeButtons
        let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
       
        self.playBackgroundMusic(2)
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
                    runAction(playPunch(1))
                    trump.zPosition = 1
        
                    hitChoice = 0
                    boomGo = 5
                    
                    self.trump.fallLeft(0)
        
        if trumpEx == true {
            
            let trumpFell = childNodeWithName("trumpFell") as! JDTrump
            
            trumpFell.removeFromParent()
            trumpEx = false
            
        }
        
                    self.trump.size = CGSizeMake(400,300)
        
        topBar.runAction(self.topBarUp(), completion: {
            self.trump.removeFromParent()
            self.runSceneGo()
            
        })
        
    }


      func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            print("tapped")
            tapUp = true
            
           
            let gloves = childNodeWithName("Gloves") as! JDHomeButtons
            let fish = childNodeWithName("Fish") as! JDHomeButtons
            let tomato = childNodeWithName("Tomato") as! JDHomeButtons
           
            let fishState = childNodeWithName("fishState") as! JDCandidateNumber
            let tomatoState = childNodeWithName("tomatoState") as! JDCandidateNumber
           
            if !isStarted && button == 1{
                
                
                trump.runAction(homeButtonUp(), completion:
                
                
                    {
                        
                        self.runAction(self.buttonSound())
                        
                        
                    })
                
            }
            
            
            else if !isStarted && button == 2{
                gloves.runAction(popBUp(), completion: {
                
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setInteger(0, forKey:"weapon")
                    self.loadWeapon()
                
                })
                
                
                
                
            }
            else if !isStarted && button == 3{
                fish.runAction(popBUp(), completion:  {
                    if fishState.number == 1 {
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setInteger(1, forKey:"weapon")
                        self.loadWeapon()
                    }
                    else {
                        
                        self.addCannotLabel(1)
                        print("locked")
                    }
                   
                
                })
                
                
                
            }
            else if !isStarted && button == 4{
                tomato.runAction(popBUp(), completion:  {
                    if tomatoState.number == 1{
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setInteger(2, forKey:"weapon")
                        self.loadWeapon()
                        
                    }
                    else {
                        self.addCannotLabel(2)
                        print("locked")
                    }
                
                })
            }
        }
       
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.redColor()
       
        
        trumpEx = false
        trumpExLeft = false
        
        
        
        addTrump(0)
        leftBoom.position.y = view.center.y
        leftBoom.position.x = view.center.x
        rightBoom.position.x = view.center.x
        leftBoom.zPosition = 15
        rightBoom.position.y = view.center.y
        rightBoom.zPosition = 15
        leftBoom.name = "leftBoomArrow"
        rightBoom.name = "rightBoomArrow"
        
        leftBoom.texture = SKTexture(imageNamed:"FinalLeftGlove.png")
        rightBoom.texture = SKTexture(imageNamed:"FinalRightGlove.png")
        
        addChild(leftBoom)
        addChild(rightBoom)
        
        
        leftBoom.hidden = true
        rightBoom.hidden = true
        
        
        let gloveState = JDCandidateNumber(num: 0)
        gloveState.name = "gloveState"
        addChild(gloveState)
        gloveState.fontColor = UIColor.redColor()
        
        let fishState = JDCandidateNumber(num: 0)
        fishState.name = "fishState"
        addChild(fishState)
        fishState.fontColor = UIColor.redColor()

        let tomatoState = JDCandidateNumber(num: 0)
        tomatoState.name = "tomatoState"
        addChild(tomatoState)
        tomatoState.fontColor = UIColor.redColor()
        
        loadWeaponUnlocked()
        
        
        
        let weaponNumber = JDCandidateNumber(num: 0)
        weaponNumber.name = "weaponNumber"
        weaponNumber.fontColor = UIColor.redColor()
        addChild(weaponNumber)
        
        
        let gloves = JDHomeButtons(size:CGSizeMake(view.frame.width / 5, view.frame.height / 9))
        gloves.texture = SKTexture(imageNamed: "Selected.png")
        gloves.position.x = view.center.x - 100
        gloves.position.y = view.center.y - 150
        gloves.name = "Gloves"
        addChild(gloves)
        
        let glovesI = JDHomeButtons(size:CGSizeMake(view.frame.width / 8, view.frame.height / 14))
        glovesI.texture = SKTexture(imageNamed: "Tomato_Right.png")
        glovesI.position = CGPointMake(0,3)
        glovesI.name = "GlovesI"
        gloves.addChild(glovesI)
        
        let glovesT = SKLabelNode(text: "Power - 1")
        glovesT.name = "glovesT"
        glovesT.fontName = "Helvetica"
        glovesT.position = CGPointMake(0, -30)
        glovesT.fontSize = 13.0
        
        glovesT.fontColor = UIColor.whiteColor()
        gloves.addChild(glovesT)
        
        
        
        let fish = JDHomeButtons(size:CGSizeMake(view.frame.width / 5, view.frame.height / 9))
        fish.texture = SKTexture(imageNamed: "Unselected.png")
        fish.position.x = view.center.x
        fish.position.y = view.center.y - 150
        fish.name = "Fish"
        addChild(fish)
        
        let fishI = JDHomeButtons(size:CGSizeMake(view.frame.width / 8, view.frame.height / 12))
        fishI.texture = SKTexture(imageNamed: "Icon_Fish.png")
        fishI.position = CGPointMake(0,3)
        fishI.name = "FishI"
        fish.addChild(fishI)
        
        let fishT = SKLabelNode(text: "Power - 2")
        fishT.name = "fishT"
        fishT.fontName = "Helvetica"
        fishT.position = CGPointMake(0, -30)
        fishT.fontSize = 13.0
        
        fishT.fontColor = UIColor.whiteColor()
        fish.addChild(fishT)
        
        
        
        let tomato = JDHomeButtons(size:CGSizeMake(view.frame.width / 5, view.frame.height / 9))
        tomato.texture = SKTexture(imageNamed: "Unselected.png")
        tomato.position.x = view.center.x + 100
        tomato.position.y = view.center.y - 150
        tomato.name = "Tomato"
        addChild(tomato)
        
        let tomatoI = JDHomeButtons(size:CGSizeMake(view.frame.width / 8, view.frame.height / 14))
        tomatoI.texture = SKTexture(imageNamed: "Icon_Glove.png")
        tomatoI.position = CGPointMake(0,3)
        tomatoI.name = "TomatoI"
        tomato.addChild(tomatoI)
        
        let tomatoT = SKLabelNode(text: "Power - 3")
        tomatoT.name = "tomatoT"
        tomatoT.fontName = "Helvetica"
        tomatoT.position = CGPointMake(0, -30)
        tomatoT.fontSize = 13.0
        
        tomatoT.fontColor = UIColor.whiteColor()
        tomato.addChild(tomatoT)
        
        loadWeapon()
        //Add Home Buttons
        loadWeaponUnlocked()
        
        if fishState.number == 0 {
            let lock = JDHomeButtons(size:CGSizeMake(view.frame.width / 10, view.frame.height / 18))
            lock.texture = SKTexture(imageNamed: "Locked.png")
            lock.position = CGPointMake(0,0)
            lock.name = "LockF"
            lock.zPosition = 20
            fish.addChild(lock)
        }
        if tomatoState.number == 0 {
            let lock = JDHomeButtons(size:CGSizeMake(view.frame.width / 12, view.frame.height / 23))
            lock.texture = SKTexture(imageNamed: "Locked.png")
            lock.position = CGPointMake(0,0)
            lock.name = "LockT"
            lock.zPosition = 20
            tomato.addChild(lock)
        }
        
        
        
        if weaponNumber.number == 0{
            leftBoom.texture = SKTexture(imageNamed:"FinalLeftGlove.png")
            rightBoom.texture = SKTexture(imageNamed:"FinalRightGlove.png")
        }
        else if weaponNumber.number == 1{
            leftBoom.texture = SKTexture(imageNamed:"Fish_Left.png")
            rightBoom.texture = SKTexture(imageNamed:"Fish_Right.png")
            
        }
        else if weaponNumber.number == 2{
            leftBoom.texture = SKTexture(imageNamed:"Tomato_Left3.png")
            rightBoom.texture = SKTexture(imageNamed:"Tomato_Right3.png")
        }
        
        
        addHomeButtons(3)
       // addHomeButtons(5)
      
        addtrumpPunchLabel()
      
                playBackgroundMusic(1)
        //Gesture Recognizers
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        let handleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.addGestureRecognizer(handleTap)
    }
    
    
    
    
    //HOME LABELS
    func addtrumpPunchLabel(){
        
        let trumpPunchLabel = JDHomeButtons(size: CGSizeMake(100, 30))
        trumpPunchLabel.name = "swipeTo"
        trumpPunchLabel.texture = SKTexture(imageNamed: "Swipe.png")
    
        trumpPunchLabel.position.x = view!.center.x
        trumpPunchLabel.position.y = view!.center.y + 130
        
        addChild(trumpPunchLabel)
        
        trumpPunchLabel.runAction(blinkAnimation())
        
    }
    
    func addCannotLabel(num: Int){
        let trumpPunchLabel = SKLabelNode(text: "Reach the Gold Round to unlock Fish")
        trumpPunchLabel.name = "cantLabel"
        trumpPunchLabel.fontName = "Helvetica"
        trumpPunchLabel.position.x = view!.center.x
        trumpPunchLabel.position.y = view!.center.y - 220
        trumpPunchLabel.fontSize = 20.0
        
        trumpPunchLabel.fontColor = UIColor.whiteColor()
        addChild(trumpPunchLabel)
        
        if num == 1 {
            trumpPunchLabel.text = "Unlocks at the Silver Round (50)"
            
        }
        else {
            trumpPunchLabel.text = "Unlocks at the Crystal Round (150)"
            
        }
        
        trumpPunchLabel.runAction(fadeCant())
        
    }

  
    
    //HOME BUTTONS
    func addHomeButtons(num: Int){
    
        if num == 3{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.2, view!.frame.height / 9))
            home.texture = SKTexture(imageNamed: "TrumpPunch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y + 200
            home.name = "TopBar"
            addChild(home)
            
        }
           
        
        else if num == 5{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.2, view!.frame.height / 4))
            home.texture = SKTexture(imageNamed: "Home_Punch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y
            home.name = "PunchHeaven"
            addChild(home)
            let settings = SKLabelNode(text: "PUNCH")
            settings.fontColor = UIColor.whiteColor()
            settings.fontSize = 50.0
            settings.fontName = "Helvetica"
            settings.position = CGPointMake(0, -10)
            settings.name = "PunchHeavenT"
            home.addChild(settings)
        }
        
     
    }
    
    func addTrump(w: Int){
        
        trump = JDTrump(w: w)
        
        trump.position.x = view!.center.x
        trump.position.y = view!.center.y - 30
        trump.zPosition = -1
        
        addChild(trump)
        trump.runAction(growCandidate())
        trump.runAction(shakeCandidate())
    }
    
    func addWeaponButtons(num: Int){
        
        if num == 0{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 5, view!.frame.height / 12))
            home.texture = SKTexture(imageNamed: "Selected.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y - 200
            home.name = "TopBar"
            addChild(home)
            
        }
            
            
        else if num == 5{
            home = JDHomeButtons(size:CGSizeMake(view!.frame.width / 1.2, view!.frame.height / 4))
            home.texture = SKTexture(imageNamed: "Home_Punch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y
            home.name = "PunchHeaven"
            addChild(home)
            let settings = SKLabelNode(text: "PUNCH")
            settings.fontColor = UIColor.whiteColor()
            settings.fontSize = 50.0
            settings.fontName = "Helvetica"
            settings.position = CGPointMake(0, -10)
            settings.name = "PunchHeavenT"
            home.addChild(settings)
        }
        
        
    }
    
    func loadWeapon(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let weaponNumber = childNodeWithName("weaponNumber") as! JDCandidateNumber
        let gloves = childNodeWithName("Gloves") as! JDHomeButtons
        let fish = childNodeWithName("Fish") as! JDHomeButtons
        let tomato = childNodeWithName("Tomato") as! JDHomeButtons
       
        let fishState = childNodeWithName("fishState") as! JDCandidateNumber
        let tomatoState = childNodeWithName("tomatoState") as! JDCandidateNumber
        
        weaponNumber.setTo(defaults.integerForKey("weapon"))
        
        
        if weaponNumber.number == 0 {
            gloves.texture = SKTexture(imageNamed: "Selected.png")
            fish.texture = SKTexture(imageNamed: "Unselected.png")
            tomato.texture = SKTexture(imageNamed: "Unselected.png")
        }
        if weaponNumber.number == 1 && fishState.number == 1 {
            gloves.texture = SKTexture(imageNamed: "Unselected.png")
            fish.texture = SKTexture(imageNamed: "Selected.png")
            tomato.texture = SKTexture(imageNamed: "Unselected.png")
        }
        if weaponNumber.number == 2 && tomatoState.number == 1{
            gloves.texture = SKTexture(imageNamed: "Unselected.png")
            fish.texture = SKTexture(imageNamed: "Unselected.png")
            tomato.texture = SKTexture(imageNamed: "Selected.png")
            
            
        }
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
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       
        
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            let touchedNode = self.nodeAtPoint(location)
          
            //let punchHeaven = childNodeWithName("PunchHeaven") as! JDHomeButtons
            
            let gloves = childNodeWithName("Gloves") as! JDHomeButtons
            let fish = childNodeWithName("Fish") as! JDHomeButtons
            let tomato = childNodeWithName("Tomato") as! JDHomeButtons
            
            
           // let punchHeavenT = punchHeaven.childNodeWithName("punchHeavenT")
            
                    if let name = touchedNode.name
                    {
                        /*
                        if name == "PunchHeaven"{
                            print("Punch Heaven Pressed")
                             button = 1
                            
                            punchHeaven.runAction(pop3())
                         
                            
                        }
                        else if name == "PunchHeavenT"{
                            print("Punch Heaven Pressed")
                            button = 1
                            
                            punchHeaven.runAction(pop3())
                        }*/
                        if name == "Gloves" || name == "GlovesI" {
                            print("Gloves pressed")
                            button = 2
                            
                           gloves.runAction(popB())
                        }
                        else if name == "Fish" || name == "LockF" || name == "FishI" {
                            print("Fish pressed")
                            button = 3
                            
                            fish.runAction(popB())
                        }
                        else if name == "Tomato" || name == "LockT" || name == "TomatoI" {
                            print("Tomato pressed")
                            button = 4
                            
                            tomato.runAction(popB())
                        }
                        
                      
                       
                        
                        
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
         addBooms()
    }
    
    func loadHighScore(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let highScoreLabel = childNodeWithName("highScoreLabel") as! JDRunningLabels
        highScoreLabel.setTo(defaults.integerForKey("highscore"))
        
        
    }
    
    func runSceneGo(){
       
        let newScene = JDSimpleScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        
        view!.presentScene(newScene)
    }
    
    func addBooms(){
      
        
        if boomGo > 0 {
            
            
            
            if hitChoice == 0{
                leftBoom.hidden = false
               
                
                
            }
            else if hitChoice == 1{
                rightBoom.hidden = false
                
                
            }
            
            boomGo -= 1
            
            
        }
        if boomGo == 0 {
            leftBoom.hidden = true
            rightBoom.hidden = true
            
        }
    }
    
    

    
    
    
    //ANIMATIONS
    func blinkAnimation() -> SKAction {
        let duration = 0.8
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatActionForever(blink)
    }
    
    func fadeCant() -> SKAction {
        
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: 0.8)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: 0.8)
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
    
    func pop3() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.5, height: view!.frame.height / 5, duration: 0.1)
      
        return SKAction.repeatAction(shrink, count: 1)
        
        
    }
    
    func popB() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 6, height: view!.frame.height / 11, duration: 0.1)
      
        
        return SKAction.repeatAction(shrink, count: 1)
        
        
    }
    
    func growCandidate() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(300, height: 300, duration: 0.1)
        let grow = SKAction.resizeToWidth(330, height: 330, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatAction(blink, count: 1)
        
        
    }
    
    func growArrow() -> SKAction{
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.8, height: 80, duration: 0.1)
        let grow = SKAction.resizeToWidth(view!.frame.width / 2, height: 100, duration: 0.1)
        
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
    
    func homeButtonDown() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.1, height: view!.frame.width / 3, duration: 0.2)
        
        
        return SKAction.repeatAction(shrink, count: 1)
        
        
    }
    
    func homeButtonUp() -> SKAction {
        
        
        let grow = SKAction.resizeToWidth(view!.frame.width / 1.2, height: view!.frame.height / 4, duration: 0.1)
        
        return SKAction.repeatAction(grow, count: 1)
        
    }
    
    func popBUp() -> SKAction {
        
    
        let grow = SKAction.resizeToWidth(view!.frame.width / 5, height: view!.frame.height / 9, duration: 0.1)
        
        return SKAction.repeatAction(grow, count: 1)
        
    }
    
    func topBarUp() -> SKAction {
        
        let moveDown = SKAction.moveToY(view!.center.y + 281, duration: 0.2)
        
        let moveUp = SKAction.moveToY(view!.center.y + 400, duration: 0.2)
        
        let go = SKAction.sequence([moveDown,moveUp])
        
        return SKAction.repeatAction(go, count: 1)
    }
    
    
    
    
    func playBackgroundMusic(num: Int) {
        
        let path = NSBundle.mainBundle().pathForResource("App Music longer.mp3", ofType:nil)!
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
            // couldn't load file :(
        }
        
    }
    
    func candidateShrink() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 6, height: view!.frame.height / 10, duration: 0.2)
        
        
        return SKAction.repeatAction(shrink, count: 1)
        
    }
    
    func candidateGrow() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 5, height: view!.frame.height / 8.5, duration: 0.2)
        
        return SKAction.repeatAction(shrink, count: 1)
        
        
        
        
    }
    
    func buttonSound() -> SKAction {
        
        let play = SKAction.playSoundFileNamed("Button Pressed.mp3", waitForCompletion: true)
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    
    func soundButtonShrink() -> SKAction {
        
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.4, height: view!.frame.height / 10, duration: 0.2)
        
        
        return SKAction.repeatAction(shrink, count: 1)
        
    }
    func soundButtonGrow() -> SKAction {
        let shrink = SKAction.resizeToWidth(view!.frame.width / 1.25, height: view!.frame.height / 8, duration: 0.2)
        
        
        return SKAction.repeatAction(shrink, count: 1)
        
        
    }
    func playPunch(num: Int) -> SKAction {
        
        var play: SKAction!
        
        if num == 1 {
            
            play = SKAction.playSoundFileNamed("Punch.mp3", waitForCompletion: true)
        }
        
        if num == 2 {
            play = SKAction.playSoundFileNamed("Wrong Button.mp3", waitForCompletion: true)
        }
        
        
        return SKAction.repeatAction(play, count: 1)
        
        
    }
    
    
    
    
    
    
    
}
