//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Альбина on 04.04.2026.
//

import Foundation
final class OAuth2TokenStorage{
    
    private let  bearerToken = "bearerToken"
    var token: String?{
        get{
            return UserDefaults.standard.string(forKey: bearerToken)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: bearerToken)
        }
    }
    
}
