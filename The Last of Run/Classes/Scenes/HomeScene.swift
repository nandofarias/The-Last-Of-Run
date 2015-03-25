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
        let background:CCSprite = CCSprite(imageNamed: "bgTheLastOfRun.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
               
        // ToGame Button
        let toGameButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("start.png") as CCSpriteFrame)
        toGameButton.position = CGPointMake(screenSize.width/2.0, screenSize.height/3.4)
        toGameButton.anchorPoint = CGPointMake(0.5, 0.5)
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        toGameButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.IntroScene, isFade:true)}
        self.addChild(toGameButton)
        
        // To Settings Button
        let toSettingsButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("settings.png") as CCSpriteFrame)
        toSettingsButton.position = CGPointMake(screenSize.width/2.0, screenSize.height/5.0)
        toSettingsButton.anchorPoint = CGPointMake(0.5, 0.5)
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        toSettingsButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.SettingsScene, isFade:true)}
        self.addChild(toSettingsButton)
        
        // To Score Button
        let toScoreButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("score.png") as CCSpriteFrame)
        toScoreButton.position = CGPointMake(screenSize.width/2.0, screenSize.height/9.2)
        toScoreButton.anchorPoint = CGPointMake(0.5, 0.5)
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonTap)
        toScoreButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.ScoreScene, isFade:true)}
        self.addChild(toScoreButton)
        
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
