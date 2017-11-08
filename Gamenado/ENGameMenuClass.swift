//
//  ENGameMenuClass.swift
//  Gamenado
//
//  Created by Giovanni Tirico on 07/11/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit

class ENGameMenuClass: SKScene {
    
    // MARK: - Properties
    private let menuNewFloorAtlas = SKTextureAtlas(named:"MenuNewFloor")

    /// Scroll view
    var scrollView: ENScrollView?
    
    /// Moveable node in the scrollView
    let scrollingNode = SKNode()
    
    // MARK: - Deinit
    deinit {
        print("Deinit game scene")
    }
    
    // MARK: - View Life Cycle
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        scrollView = ENScrollView(frame: CGRect(x: 3, y: 1, width: 320, height: 428),
                                  scrollingNode: SKNode(),
                                  direction: ENScrollView.ScrollDirection.vertical)
    }
    
    override func willMove(from view: SKView) {

    }
    
    /// Touches began,
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            
        }
    }
}
