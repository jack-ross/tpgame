
//
//  JDBoom.swift
//  Trump Punch
//
//  Created by Jared Downing on 2/1/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import SpriteKit

class JDBoom: SKSpriteNode {
    init(sizeOf: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"LeftArrow.png"), color: UIColor.clearColor(), size: CGSizeMake(10,10))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
