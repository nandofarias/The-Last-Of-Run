//
//  SettingsScene.swift
//  The Last of Run
//
//  Created by Usuário Convidado on 23/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

class SettingsScene : CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.createSceneObjects()
        
    }
    
    func createSceneObjects(){
        
        // Create a colored background (Dark Grey)
        let background:CCSprite = CCSprite(imageNamed: "bgSettings.png")
        self.addChild(background)
        
        
        
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
