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
        
        
        buttonIsOnMusic = NSUserDefaults.standardUserDefaults().objectForKey("musicSettings") as Bool
        buttonIsOnEffects = NSUserDefaults.standardUserDefaults().objectForKey("effectsSettings") as Bool
        
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
        let music:CCSprite = CCSprite(imageNamed: "music.png")
        music.position = CGPointMake(screenSize.width/2, screenSize.height/1.4)
        music.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(music, z:ObjectsLayers.HUD.rawValue)
        
        
        // ON/OFF Music button
        
        let onOffMusicButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed(buttonIsOnMusic ? "off.png" : "on.png") as CCSpriteFrame)
        onOffMusicButton.position = CGPointMake(screenSize.width/2, screenSize.height/1.6)
        onOffMusicButton.anchorPoint = CGPointMake(0.5, 0.5)
        onOffMusicButton.zoomWhenHighlighted = false
        onOffMusicButton.block = {_ in
            
            self.buttonIsOnMusic = !self.buttonIsOnMusic
            NSUserDefaults.standardUserDefaults().setObject(self.buttonIsOnMusic, forKey: "musicSettings")
            NSUserDefaults.standardUserDefaults().synchronize()
            StateMachine.sharedInstance.changeScene(StateMachineScenes.SettingsScene, isFade: false)
        }
        self.addChild(onOffMusicButton, z:ObjectsLayers.HUD.rawValue)
  
        
        
        
        
        // EFFECTS
        let effects:CCSprite = CCSprite(imageNamed: "effects.png")
        effects.position = CGPointMake(screenSize.width/2, screenSize.height/2.2)
        effects.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(effects, z:ObjectsLayers.HUD.rawValue)
        
        // ON button
        let onOffEffectsButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed(buttonIsOnEffects ? "off.png" : "on.png") as CCSpriteFrame)
        onOffEffectsButton.position = CGPointMake(screenSize.width/2, screenSize.height/2.8)
        onOffEffectsButton.anchorPoint = CGPointMake(0.5, 0.5)
        onOffEffectsButton.zoomWhenHighlighted = false
        onOffEffectsButton.block = {_ in
            self.buttonIsOnEffects = !self.buttonIsOnEffects
            NSUserDefaults.standardUserDefaults().setObject(self.buttonIsOnEffects, forKey: "effectsSettings")
            NSUserDefaults.standardUserDefaults().synchronize()
            StateMachine.sharedInstance.changeScene(StateMachineScenes.SettingsScene, isFade: false)
        }
        self.addChild(onOffEffectsButton, z:ObjectsLayers.HUD.rawValue)
        
        
        
  
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
