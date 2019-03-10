//
//  URLManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    // MARK: - Routes
    
    private struct Domains {
        static let ressourceURL = "http://18.197.90.144/"
        static let baseURL = "http://18.197.90.144:3000/" //"http://18.185.199.168:3000/"
        static let cmsBaseURL   = "http://reach.xtnd.io/cms/www/"
    }
    
    private struct News {
        static let allNews = "static/news"
        static let newsDetails = "static/news/"
    }
    
    private struct Promotions {
        static let allPromotions = "promotions/all"
    }
    
    private struct Sales {
        static let sales = "sales/"
    }
    
    private struct Static {
        static let about = "static/about"
        static let faq   = "static/faq"
        static let terms = "static/terms"
        static let privacy = "static/privacy"
        static let banners = "static/banners"
        static let contact = "static/contact"
    }
    
    private struct Training {
        static let allCategories = "static/trainings/categories/"
    }

    private struct User {
        static let login = "members/login"
        static let profile = "members/profile"
    }
    
    private struct Vendors {
        static let allVendors = "products/vendors/all/training"
    }
    
    // MARK: - URLs
    
    static let baseURL : URL! = URL(string: Domains.baseURL)
    static let ressourcesURL : URL! = URL(string: Domains.ressourceURL)
    static let cmsBaseURL : URL! = URL(string: Domains.cmsBaseURL)
    
    static let about    = Domains.baseURL + Static.about
    static let allCategories = Domains.baseURL + Training.allCategories
    static let allNews  = Domains.baseURL + News.allNews
    static let allPromotions  = Domains.baseURL + Promotions.allPromotions
    static let banners  = Domains.baseURL + Static.banners
    static let faqs     = Domains.baseURL + Static.faq
    static let login     = Domains.baseURL + User.login
    static let newsDetails = Domains.baseURL + News.newsDetails
    static let profile  = Domains.baseURL + User.profile
    static let sales  = Domains.baseURL + Sales.sales
    static let termsAndConditions = Domains.baseURL + Static.terms
    static let trainingCategory   = Domains.baseURL + Training.allCategories
    static let vendorsList  = Domains.baseURL + Vendors.allVendors
    
    // MARK: - Helpers
    
    /// Create complete URLs from relative paths, used by image ressources, etc.
    static func getURL(path: String, parameters: [String: String] = [:]) -> URL? {
        return baseURL.appendingPathComponent(path).appendingQueryParameters(parameters)
    }
    
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
