//
//  JDPointsLabel.swift
//  Lit
//
//  Created by Jared Downing on 1/23/16.
//  Copyright © 2016 Advergo. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class JDRunningLabels: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.whiteColor()
        fontName = "Helvetica"
        fontSize = 25.0
        
        number = num
        text = "\(num)"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment(){
        number++
        text = "\(number)"
        
        
    }
    
    func subtract(){
        number--
        text = "\(number)"
        
        
    }
    
    func setTo(num:Int) {
        self.number = num
        text = "\(self.number)"
        
        
    }
    
    func isOver() -> Bool{
        if self.number <= 0{
            return true
        }
        else {
            return false
        }
    
    }
    
    
}