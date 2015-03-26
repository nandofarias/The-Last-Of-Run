//
//  SettingsScene.swift
//  The Last of Run
//
//  Created by Usuário Convidado on 25/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//
//
import Foundation

// MARK: - Class Definition
class SettingsScene: CCScene {
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    var buttonIsOnMusic:Bool = true
    var buttonIsOnEffects:Bool = true
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.createSceneObjects()
        
    }
    
    func createSceneObjects(){
        
        // Create a colored background (Dark Grey)
        let background:CCSprite = CCSprite(imageNamed: "bgSettings.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
        // Back button
        let backButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("back.png") as CCSpriteFrame)
        backButton.position = CGPointMake(screenSize.width-20, screenSize.height-60)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
        // MUSIC
        let music:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("music.png") as CCSpriteFrame)
        music.position = CGPointMake(screenSize.width/2, screenSize.height/1.4)
        music.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(music, z:ObjectsLayers.HUD.rawValue)
        
        // ON button
        if buttonIsOnMusic{
        let onButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("on.png") as CCSpriteFrame)
        onButton.position = CGPointMake(screenSize.width/2, screenSize.height/1.6)
        onButton.anchorPoint = CGPointMake(0.5, 0.5)
        onButton.zoomWhenHighlighted = false
        self.addChild(onButton, z:ObjectsLayers.HUD.rawValue)
        }else{
        // OFF button
        let offButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("off.png") as CCSpriteFrame)
        offButton.position = CGPointMake(screenSize.width/2, screenSize.height/1.6)
        offButton.anchorPoint = CGPointMake(0.5, 0.5)
        offButton.zoomWhenHighlighted = false
        self.addChild(offButton, z:ObjectsLayers.HUD.rawValue)
        }
        // EFFECTS
        let effects:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("effects.png") as CCSpriteFrame)
        effects.position = CGPointMake(screenSize.width/2, screenSize.height/2.2)
        effects.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(effects, z:ObjectsLayers.HUD.rawValue)
        
        // ON button
        if buttonIsOnEffects{
        let onButton2:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("on.png") as CCSpriteFrame)
        onButton2.position = CGPointMake(screenSize.width/2, screenSize.height/2.8)
        onButton2.anchorPoint = CGPointMake(0.5, 0.5)
        onButton2.zoomWhenHighlighted = false
        self.addChild(onButton2, z:ObjectsLayers.HUD.rawValue)
        }
        // OFF button
        else{
        let offButton2:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("off.png") as CCSpriteFrame)
        offButton2.position = CGPointMake(screenSize.width/2, screenSize.height/2.8)
        offButton2.anchorPoint = CGPointMake(0.5, 0.5)
        offButton2.zoomWhenHighlighted = false
        self.addChild(offButton2, z:ObjectsLayers.HUD.rawValue)
        }
        // Créditos button
        let creditosButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("credits.png") as CCSpriteFrame)
        creditosButton.position = CGPointMake(screenSize.width/2, screenSize.height/9.0)
        creditosButton.anchorPoint = CGPointMake(0.5, 0.5)
        creditosButton.zoomWhenHighlighted = false
        creditosButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.CreditosScene, isFade:true)
        }
        self.addChild(creditosButton, z:ObjectsLayers.HUD.rawValue)
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
