//
//  ENHUDScene.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 24/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENHUDClass: SKSpriteNode {

    public func setTotalMoney(value: Int32) {
        let totalMoney = self.childNode(withName: "TotalMoney") as? SKLabelNode!
        totalMoney?.text = String(format: "$ %d", value)
    }

    public func setTotalFollowers(value: Int32) {
        let totalFollowers = self.childNode(withName: "TotalFollowers") as? SKLabelNode!
        totalFollowers?.text = String(format: "%d", value)
    }

    
}
