//
//  UsersViewModel.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import Foundation

final class UsersViewModel: ObservableObject {
    @Published var allUsers: [User] = []
    @Published var searchText: String = ""
    @Published var favorites: Set<Int> = []

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return allUsers
        } else {
            return allUsers.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var favoriteUsers: [User] {
        allUsers.filter { favorites.contains($0.id) }
    }

    init() {
        loadUsers()
        loadFavorites()
    }

    func loadUsers() {
        UserService.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.allUsers = users
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
            }
        }
    }

    func toggleFavorite(for user: User) {
        print("favroiriye tıklandı")
        if favorites.contains(user.id) {
            favorites.remove(user.id)
        } else {
            favorites.insert(user.id)
        }
        saveFavorites()
    }

    func removeFavorite(user: User) {
        favorites.remove(user.id)
        saveFavorites()
    }

    func isFavorite(user: User) -> Bool {
        favorites.contains(user.id)
    }

    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            favorites = Set(saved)
        }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: "favorites")
    }
}
