//
//  JDTrump.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/24/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import SpriteKit

class JDHomeButtons: SKSpriteNode {
    init(size: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"Settings_Icon.png"), color: UIColor.clearColor(), size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}