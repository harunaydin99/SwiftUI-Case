//
//  Endpoint.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 2.07.2025.
//

import Foundation

/// HTTP metotlarını tanımlar
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// Endpoint protokolü – her endpoint bu kurallara uymalı
protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    
    func asURLRequest() -> URLRequest
}

/// Kullanacağımız endpointleri temsil eden enum
enum Endpoint {
    case getUsers
}

extension Endpoint: EndpointProtocol {
    
    // Temel URL (her endpoint bu domain üzerinden çalışacak)
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }

    // Her bir endpoint’e özel path
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }

    // Hangi HTTP metodu kullanılacak?
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }

    // Header bilgileri (içerik tipi vs.)
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
    }

    // Gönderilecek parametreler (bu örnekte yok)
    var parameters: [String: Any]? {
        return nil
    }

    /// Endpoint'i URLRequest nesnesine çevirir
    func asURLRequest() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL oluşturulamadı.")
        }
        
        components.path = path
        
        guard let url = components.url else {
            fatalError("Geçersiz URL oluştu.")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Parametre varsa, gövdeye JSON olarak eklenir
        if let parameters {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = bodyData
            } catch {
                print("Parametre dönüştürme hatası: \(error.localizedDescription)")
            }
        }

        // Header'lar ekleniyor
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
