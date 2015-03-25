//
//  IntroScene.swift
//  The Last of Run
//
//  Created by EvilXmurf on 3/24/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

// MARK: - Class Definition
class IntroScene: CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    var inicialIntroBg:Int = 1
    let maxIntroBg:Int = 4
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.userInteractionEnabled = true
        self.alterIntro()
        
    }
    
   
    func alterIntro(){
        // Create a colored background (Dark Grey)
        var background:CCSprite = CCSprite(imageNamed:"intro0\(inicialIntroBg).png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        self.inicialIntroBg+=1;
    }
    

    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        
        if(inicialIntroBg  <= maxIntroBg){
            alterIntro()
        } else {
           StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)
        }
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    //	func startTap(sender:AnyObject) {
    //		StateMachine.sharedInstance.changeScene(StateMachine.StateMachineScenes.GameScene, isFade:true)
    //	}
    
    // MARK: - Public Methods
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
    
    
}