//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Albina Musugalieva on 28.04.2026.
//

import Foundation
import WebKit

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    
    private init() { }
    
    func logout() {
        OAuth2TokenStorage.shared.token = nil
        ProfileService.shared.logout()
        ProfileImageService.shared.logout()
        ImagesListService.shared.logout()
        cleanCookies()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
