//
//  JDTrump.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/24/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import SpriteKit

class JDTrump: SKSpriteNode {
    
    
    var weapon: Int = 0
    
    init(w: Int) {
        
        super.init(texture:SKTexture(imageNamed:"Trump.png"), color: UIColor.clearColor(), size: CGSizeMake(300, 300))
        loadPhysicsBody(CGSizeMake(300,300))
        
        
    }
    
    
    func loadPhysicsBody(size: CGSize){
        loadWeapon()
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30,30))
       
        
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.dynamic = false
        physicsBody?.pinned = true
        
        
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
        
    }
    func loadWeapon(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
      weapon = defaults.integerForKey("weapon")
    }
    
    
    
    func fallLeft(w: Int) {
        loadWeapon()
        if w == 0 {
            texture = SKTexture(imageNamed: "Trump_Left.png")
             size = CGSizeMake(300, 300)
        }
        
        name = "trumpFellLeft"
        
        let choose = CGFloat(arc4random_uniform(100))
        let chooseT = CGFloat(arc4random_uniform(30))
       
        physicsBody?.affectedByGravity = true
        physicsBody?.dynamic = true
        physicsBody?.pinned = false
        if weapon == 0 {
            
            physicsBody?.applyImpulse(CGVectorMake(-30,15 - chooseT))
            
        }
        else if weapon == 1 || weapon == 2{
            physicsBody?.applyImpulse(CGVectorMake(-30,50 - choose))
        }
        
        
        //Real Fall
        let shrink = SKAction.resizeToWidth(100, height: 100, duration: 0.3)
        
        let rotateBack = SKAction.rotateByAngle(2.1, duration:0.1)
        
        let swirl = SKAction.repeatAction(rotateBack, count: 5)
        
        //Fish Fall
        let shrinkF = SKAction.resizeToWidth(100, height: 100, duration: 0.6)
        
        let rotateBackF = SKAction.rotateByAngle(1, duration:0.2)
        
        let swirlF = SKAction.repeatAction(rotateBackF, count: 5)
        
        //Tomato Fall
        let shrinkT = SKAction.resizeToWidth(200, height: 200, duration: 0.6)
        
        let rotateBackT = SKAction.rotateByAngle(0.5, duration:0.2)
        
        let swirlT = SKAction.repeatAction(rotateBackT, count: 5)
        
        if weapon == 2 {
            
            runAction(swirl)
            runAction(shrink, completion: {self.removeFromParent(); print("gone left")})
            
        }
        else if weapon == 0 {
            runAction(shrinkT)
            runAction(swirlT, completion: {self.removeFromParent(); print("gone left")})
            
            
        }else if weapon == 1{
            runAction(swirlF)
            runAction(shrinkF, completion: {self.removeFromParent(); print("gone left")})
            
        }
    }
    func fallRight(w: Int) {
        loadWeapon()
        
        if w == 0 {
            texture = SKTexture(imageNamed: "Trump_Right.png")
             size = CGSizeMake(300, 300)
        }
        
        let choose = CGFloat(arc4random_uniform(100))
       let chooseT = CGFloat(arc4random_uniform(30))
        
        name = "trumpFell"
        
        if weapon == 0 {
            
            physicsBody?.applyImpulse(CGVectorMake(-30,15 - chooseT))
            
        }
        else if weapon == 1 || weapon == 2{
            physicsBody?.applyImpulse(CGVectorMake(-30,50 - choose))
        }
        
        physicsBody?.affectedByGravity = true
        physicsBody?.dynamic = true
        physicsBody?.pinned = false
        
        physicsBody?.applyImpulse(CGVectorMake(30,50 - choose))
        //Real Fall
        let shrink = SKAction.resizeToWidth(100, height: 100, duration: 0.3)
        
        let rotateBack = SKAction.rotateByAngle(-2.1, duration:0.1)
        
        let swirl = SKAction.repeatAction(rotateBack, count: 5)
        
        
        //Fish Fall
        let shrinkF = SKAction.resizeToWidth(100, height: 100, duration: 0.6)
        
        let rotateBackF = SKAction.rotateByAngle(-1, duration:0.2)
        
        let swirlF = SKAction.repeatAction(rotateBackF, count: 5)
        
        //Tomato Fall
        let shrinkT = SKAction.resizeToWidth(100, height: 100, duration: 0.6)
        
        let rotateBackT = SKAction.rotateByAngle(-0.5, duration:0.2)
        
        let swirlT = SKAction.repeatAction(rotateBackT, count: 5)
        
        if weapon == 2 {
            
            runAction(swirl)
            runAction(shrink, completion: {self.removeFromParent(); print("gone right")})
            
        }
        else if weapon == 0 {
            runAction(shrinkT)
            runAction(swirlT, completion: {self.removeFromParent(); print("gone right")})
            
            
        }else if weapon == 1{
            runAction(swirlF)
            runAction(shrinkF, completion: {self.removeFromParent(); print("gone right")})
        
        }
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
