//
//  UserService.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import Foundation


// MARK: - API Service
final class UserService {
    static let shared = UserService()
    private init() {}

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return completion(.failure(URLError(.badURL)))
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
