//
//  HomeScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class HomeScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects

	// MARK: - Life Cycle
	override init() {
		super.init()

        self.createSceneObjects()
		
	}

    func createSceneObjects(){
    
        // Create a colored background (Dark Grey)
        let background:CCNodeColor = CCNodeColor(color: CCColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
        self.addChild(background)
        
        // Logo
        let label:CCSprite = CCSprite(imageNamed: "bgTheLastOfRun.png")
        label.position = CGPointMake(screenSize.width/2, screenSize.height/2 + 40)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(label)
        
               
        // ToGame Button
        let toGameButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("start.png") as CCSpriteFrame)
        toGameButton.position = CGPointMake(screenSize.width/2.0, screenSize.height/4.0)
        toGameButton.anchorPoint = CGPointMake(0.5, 0.5)
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        toGameButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)}
        self.addChild(toGameButton)
        
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
