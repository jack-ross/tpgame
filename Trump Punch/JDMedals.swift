//
//  JDMedals.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/28/16.
//  Copyright © 2016 Ideals. All rights reserved.
//
import Foundation
import SpriteKit

class JDMedals: SKSpriteNode {
    
    
    
    
    init(sizeOf: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"Clear.png"), color: UIColor.clearColor(), size: CGSizeMake(80,80))
        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}