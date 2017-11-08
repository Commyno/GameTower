//
//  ENButtonNode.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 23/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit

//Enumeratori
enum ENButtonNodeState {
    case active, hidden
}

enum ENButtonActionType: Int {
    case TouchUpInside = 1,
    TouchDown, TouchUp
}

class ENButtonNode: SKSpriteNode { //SKSpriteNode {
    
    //Propietà
    var isEnabled: Bool = true {
        didSet {
            if (disabledTexture != nil) {
                self.texture = isEnabled ? defaultTexture : disabledTexture
            }
        }
    }
    var isSelected: Bool = false {
        didSet {
            self.texture = isSelected ? selectedTexture : defaultTexture
        }
    }

    //Variabili
    var defaultTexture: SKTexture? = nil
    var selectedTexture: SKTexture? = nil
    var disabledTexture: SKTexture? = nil
    var label: SKLabelNode = SKLabelNode()
    var actionTouchUpInside: Selector?
    var actionTouchUp: Selector?
    var actionTouchDown: Selector?
    weak var targetTouchUpInside: AnyObject?
    weak var targetTouchUp: AnyObject?
    weak var targetTouchDown: AnyObject?

    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Button state management */
    var state = ENButtonNodeState.active {
        didSet {
            switch state {
            case .active:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                
                /* Visible */
                self.alpha = 1
                break
            
            case .hidden:
                /* Disable touch */
                self.isUserInteractionEnabled = false
                
                /* Hide */
                self.alpha = 1
                break
            }
        }
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
        
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(texture: texture, color: color, size: size)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    init() {
    //override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(texture: nil, color: UIColor.clear, size: CGSize.zero)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
        
    }
    
    func setTexture(normalTexture defaultTexture: SKTexture!, selectedTexture:SKTexture!, disabledTexture: SKTexture?, testo: String) {
        
        self.defaultTexture = defaultTexture
        self.selectedTexture = selectedTexture
        self.disabledTexture = disabledTexture
        
        self.texture = self.defaultTexture
        self.size = (self.defaultTexture?.size())!

        //Crea e aggiunge un testo vuoto, centrato nel bottone
        self.label = SKLabelNode(fontNamed: "Helvetica")
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;
        self.label.fontColor = SKColor.black
        self.label.fontSize = 20
        self.label.zPosition = 2
        self.label.text = testo
        addChild(self.label)
    }
    
    func setButtonAction(target: AnyObject, triggerEvent event:ENButtonActionType, action:Selector) {
        
        switch (event) {
        case .TouchUpInside:
            targetTouchUpInside = target
            actionTouchUpInside = action
        case .TouchDown:
            targetTouchDown = target
            actionTouchDown = action
        case .TouchUp:
            targetTouchUp = target
            actionTouchUp = action
        }
        
    }
    
    func setButtonLabel(title: NSString, font: String, fontSize: CGFloat) {
        self.label.text = title as String
        self.label.fontSize = fontSize
        self.label.fontName = font
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        
        isSelected = true
        
        if (targetTouchDown != nil && targetTouchDown!.responds(to: actionTouchDown!)) {
            UIApplication.shared.sendAction(actionTouchDown!, to: targetTouchDown, from: self, for: nil)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        
        let touch: AnyObject! = touches.first
        let touchLocation = touch.location(in: parent!)
        
        if (frame.contains(touchLocation)) {
            isSelected = true
        } else {
            isSelected = false
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        
        isSelected = false
        
        if (targetTouchUpInside != nil && targetTouchUpInside!.responds(to: actionTouchUpInside!)) {
            let touch: AnyObject! = touches.first
            let touchLocation = touch.location(in: parent!)
            
            if (frame.contains(touchLocation)) {
                UIApplication.shared.sendAction(actionTouchUpInside!, to: targetTouchUpInside, from: self, for: nil)
            }
            
        }
        
        if (targetTouchUp != nil && targetTouchUp!.responds(to: actionTouchUp!)) {
            UIApplication.shared.sendAction(actionTouchUp!, to: targetTouchUp, from: self, for: nil)
        }
        
    }
    
}
