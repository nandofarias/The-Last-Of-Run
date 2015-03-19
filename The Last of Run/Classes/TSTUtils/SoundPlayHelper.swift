//
//  SoundPlayHelper.m
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

enum GameMusicAndSoundFx:String {
	case MusicInGame = "MusicInGame.mp3"
	case SoundFXButtonTap = "SoundFXButtonTap.mp3"
	
	static let allSoundFx = [SoundFXButtonTap]
}

class SoundPlayHelper {
	// MARK Public Declarations
	
	// MARK Private Declarations

	// MARK: - Singleton
	class var sharedInstance:SoundPlayHelper {
	struct Static {
			static var instance: SoundPlayHelper?
			static var token: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = SoundPlayHelper()
		}

		return Static.instance!
	}
	
	// MARK: Private Methods

	// MARK: Public Methods
	func preloadSoundsAndMusic() {
		// Habilita o cache de audio
		OALSimpleAudio.sharedInstance().preloadCacheEnabled = true

		// Apenas uma musica de fundo pode ser cacheada
		OALSimpleAudio.sharedInstance().preloadBg(GameMusicAndSoundFx.MusicInGame.rawValue)

		// Itera todos os SoundsFX para cachear
		for music in GameMusicAndSoundFx.allSoundFx {
			OALSimpleAudio.sharedInstance().preloadEffect(music.rawValue)
		}

		// Define o volume default
		setMusicDefaultVolume()
	}

	func playSoundWithControl(aGameMusic:GameMusicAndSoundFx) {
		OALSimpleAudio.sharedInstance().playEffect(aGameMusic.rawValue)
	}

	func playMusicWithControl(aGameMusic:GameMusicAndSoundFx, withLoop:Bool) {
		OALSimpleAudio.sharedInstance().stopBg()
		OALSimpleAudio.sharedInstance().preloadBg(aGameMusic.rawValue)
		OALSimpleAudio.sharedInstance().playBgWithLoop(withLoop)
	}

	func stopAllSounds() {
		OALSimpleAudio.sharedInstance().stopEverything()
	}

	func setMusicVolume(aVolume:Float) {
		OALSimpleAudio.sharedInstance().bgVolume = aVolume
	}

	func setMusicPauseVolume() {
		OALSimpleAudio.sharedInstance().bgVolume = 0.25
	}

	func setMusicDefaultVolume() {
		OALSimpleAudio.sharedInstance().bgVolume = 0.8
		OALSimpleAudio.sharedInstance().effectsVolume = 1.0
	}
}
