//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Альбина on 04.04.2026.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage{
    
    static let shared = OAuth2TokenStorage()
    
    private let  bearerToken = "bearerToken"
    var token: String?{
        get{
            KeychainWrapper.standard.string(forKey: bearerToken)
        }
        set{
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: bearerToken)
            } else {
                KeychainWrapper.standard.removeObject(forKey: bearerToken)
            }
        }
    }
    
    private init(){}
}
