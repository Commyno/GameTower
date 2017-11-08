//
//  ENScrollView.swift
//  Gamenado
//
//  Created by Giovanni Tirico on 07/11/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//


import SpriteKit

public class ENScrollView: SKNode {
    
    // MARK: - Properties
    
    /// ENScrollView direction
    public enum ScrollDirection {
        case vertical
        case horizontal
    }

    /// Disable status
    public var isDisabled = false {
        didSet {
            isUserInteractionEnabled = !isDisabled
        }
    }

    /// Min Position
    public var minYPosition: CGFloat = 0.0
    /// Max Position
    public var maxPosition: CGFloat = 0.0
    /// Max Position
    public var yOffset: CGFloat = 0.0
    /// Direction scroll
    public let direction: ScrollDirection
    /// Moveable node
    public let scrollingNode: SKNode

    /// Init
    ///
    /// - parameter frame: The frame of the scroll view
    /// - parameter moveableNode: The moveable node that will contain all the sprites to be moved by the scrollview
    /// - parameter scrollDirection: The scroll direction of the scrollView.
    public init(frame: CGRect, scrollingNode: SKNode, direction: ScrollDirection) {
        self.scrollingNode = scrollingNode
        scrollingNode.name = "ScrollingNode"
        self.direction = direction
        super.init()
        
        // Rettangolo contenitore
        let rectNode = SKSpriteNode(color: UIColor.blue, size: frame.size)
        rectNode.position = CGPoint(x:0, y:0)
        
        // Rettangolo di maschera
        let maskNode = rectNode.copy()
        let cropNode = SKCropNode()
        cropNode.maskNode = maskNode as! SKSpriteNode
        cropNode.addChild(rectNode)

        // Aggiungo lo scrolling Node e il tutto alla view
        rectNode.addChild(scrollingNode)
        self.addChild(cropNode)

        // Aggiungo gli oggetti
        let oggetto1 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        oggetto1.position = CGPoint(x: 0, y: 0)
        scrollingNode.addChild(oggetto1)
        let oggetto2 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        oggetto2.position = CGPoint(x: 0, y: 110)
        scrollingNode.addChild(oggetto2)
        let oggetto3 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        oggetto3.position = CGPoint(x: 0, y: 220)
        scrollingNode.addChild(oggetto3)
        let oggetto4 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        oggetto4.position = CGPoint(x: 0, y: 330)
        scrollingNode.addChild(oggetto4)
        let oggetto5 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        oggetto5.position = CGPoint(x: 0, y: 440)
        scrollingNode.addChild(oggetto5)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
