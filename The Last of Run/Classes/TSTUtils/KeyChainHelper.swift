//
//  KeyChainHelper.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 9/12/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation
import Security

// Identifyers
let userAccount = "authenticatedUser"

// MARK: - Class Definition
class KeyChainHelper {
	// MARK: - Public Objects

	// MARK: - Private Objects

	// MARK: - Private Methods
	private class func save(service: NSString, data: NSString) {
		var dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!

		// Instantiate a new default keychain query
		var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, service, userAccount, dataFromString], forKeys: [kSecClass, kSecAttrService, kSecAttrAccount, kSecValueData])

		// Delete any existing items
		SecItemDelete(keychainQuery as CFDictionaryRef)

		// Add the new keychain item
		var status: OSStatus = SecItemAdd(keychainQuery as CFDictionaryRef, nil)
	}
	
	private class func load(service: NSString) -> NSString? {
		// Instantiate a new default keychain query
		// Tell the query to return a result
		// Limit our results to one item
		var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, service, userAccount, kCFBooleanTrue, kSecMatchLimitOne], forKeys: [kSecClass, kSecAttrService, kSecAttrAccount, kSecReturnData, kSecMatchLimit])

		var dataTypeRef :Unmanaged<AnyObject>?

		// Search for the keychain items
		let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
		let opaque = dataTypeRef?.toOpaque()
		var contentsOfKeychain: NSString?

		if let op = opaque? {
			let retrievedData = Unmanaged<NSData>.fromOpaque(op).takeUnretainedValue()
			
			// Convert the data retrieved from the keychain into a string
			contentsOfKeychain = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
		} else {
			println("Status code \(status)")
		}

		return contentsOfKeychain
	}

	// MARK: - Public Methods
	class func saveToken(token:String, withKeyID:String) {
		self.save(withKeyID, data: token)
	}

	class func loadTokenWithKeyID(aKeyID:String) -> String? {
		var token = self.load(aKeyID)
		
		return token
	}

	class func haveKey(aKeyID:String) -> Bool {
		var token = self.load(aKeyID)

		return (token == nil) ? false : true
	}
}
