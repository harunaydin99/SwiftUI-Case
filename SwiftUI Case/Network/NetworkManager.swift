//
//  NetworkManager.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 2.07.2025.
//

import Foundation

final class NetworkManager {
    
    // Singleton yapı
    static let shared = NetworkManager()
    private init() {}
    
    /// Generic istek fonksiyonu
    /// - Parameters:
    ///   - endpoint: Hangi endpoint'e istek atılacak?
    ///   - completion: Sonuç başarılıysa model, değilse hata döner
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlRequest = endpoint.asURLRequest()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            // Hata varsa işlemi sonlandır
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            // HTTP yanıtını kontrol ediyor
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            // Veri kontrolü
            guard let data = data else {
                completion(.failure(NSError(domain: "Veri alınamadı", code: 0)))
                return
            }

            // JSON veriyi decode et
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch let decodeError {
                DispatchQueue.main.async {
                    completion(.failure(decodeError))
                }
            }
        }

        task.resume()
    }
    
    /// Örnek endpoint çağrısı: Kullanıcıları getir
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        request(.getUsers, completion: completion)
    }
}
