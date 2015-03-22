//
//  LoadingScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class LoadingScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects


	// MARK: - Life Cycle
	override init() {
		super.init()

        // Define a cor de fundo da cena
        self.color = CCColor.whiteColor()
        
        // Preload das musicas
        SoundPlayHelper.sharedInstance.preloadSoundsAndMusic()
        SoundPlayHelper.sharedInstance.setMusicDefaultVolume()
        
        
        // Preload do plist
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("zombie.plist")
        
        self.createSceneObjects()

	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}

    // MARK: - Private Methods
    func createSceneObjects() {
        // Label loading
        let loadingLabel:CCLabelTTF = CCLabelTTF(string: "Loading...", fontName: "Verdana-Bold", fontSize: 56.0)
        loadingLabel.fontColor = CCColor.blackColor()
        loadingLabel.position = CGPointMake(screenSize.width / 2.0, screenSize.height / 2.0)
        loadingLabel.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(loadingLabel, z: ObjectsLayers.Background.rawValue)
        
        // Chama os steps de inicializacao
        DelayHelper.sharedInstance.callFunc("callGameHome", onTarget: self, withDelay: 1.0)
    }
    
    func callGameHome() {
        StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
        
        CCTextureCache.sharedTextureCache().removeAllTextures()
}
}