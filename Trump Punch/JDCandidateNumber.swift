//
//  JDCandidateNumber.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/30/16.
//  Copyright © 2016 Ideals. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class JDCandidateNumber: SKLabelNode {
    
    var number = 1
    
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