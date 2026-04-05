//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Альбина on 30.03.2026.
//

import Foundation

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    let tokenStorage = OAuth2TokenStorage()
    
    
    
    struct OAuthTokenResponseBody: Decodable {
        let access_token: String
        let token_type: String
        let scope: String
        let created_at: Int
    }
    
    private init() {}
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken (_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Failed to create request")
            return}
        
        
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    self.tokenStorage.token = responseBody.access_token
                    completion(.success(responseBody.access_token))
                } catch {
                    print("Decoding Error")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}


