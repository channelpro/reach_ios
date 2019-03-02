//
//  URLManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    /// Create complete URLs from relative paths, used by image ressources, etc.
    static func getURL(path: String, parameters: [String: String] = [:]) -> URL? {
        return baseURL.appendingPathComponent(path).appendingQueryParameters(parameters)
    }
    
    private struct Domains {
        static let baseURL = "http://18.185.199.168:3000/"
    }
    
    private struct Static {
        static let faq   = "static/faq"
        static let terms = "static/terms"
        static let contact = "static/contact"
        static let about = "static/about"
        static let privacy = "static/privacy"
        static let banners = "static/banners"
    }
    
    private struct Training {
        static let allCategories = "static/trainings/categories/"
    }

    
    static let baseURL : URL! = URL(string: Domains.baseURL)
    
    static let allCategories = Domains.baseURL + Training.allCategories
}

extension URL {
    
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = []
        
        for (key, value) in parameters {
            urlComponents?.queryItems?.append(URLQueryItem(name:key, value: value as? String))
        }
        
        return urlComponents?.url
    }
}
