//
//  ScoreScene.swift
//  The Last of Run
//
//  Created by EvilXmurf on 3/24/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

// MARK: - Class Definition
class ScoreScene: CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.createSceneObjects()
        
    }
    
    func createSceneObjects(){
        
        // Create a colored background (Dark Grey)
        let background:CCSprite = CCSprite(imageNamed: "bgScore.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
        // Back button
        let backButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("back.png") as CCSpriteFrame)
        backButton.position = CGPointMake(screenSize.width/2, screenSize.height/9.0)
        backButton.anchorPoint = CGPointMake(0.5, 0.5)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
        
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