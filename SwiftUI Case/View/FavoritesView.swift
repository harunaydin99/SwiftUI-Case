//
//  FavoritesView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import SwiftUI

// MARK: - Favorites View
/*struct FavoritesView: View {
    @EnvironmentObject var viewModel: UsersViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteUsers) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        UserRowView(
                            user: user,
                            isFavorite: true,
                            onToggleFavorite: {
                                viewModel.toggleFavorite(for: user)
                            }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Favoriler")
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let user = viewModel.favoriteUsers[index]
            viewModel.removeFavorite(user: user)
        }
    }
}*/
// MARK: - Favorites View
struct FavoritesView: View {
    @EnvironmentObject var viewModel: UsersViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.favoriteUsers.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "star.slash")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)

                        Text("Henüz favori eklenmedi")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
                } else {
                    List {
                        ForEach(viewModel.favoriteUsers) { user in
                            NavigationLink {
                                UserDetailView(user: user)
                            } label: {
                                UserRowView(
                                    user: user,
                                    isFavorite: true,
                                    onToggleFavorite: {
                                        viewModel.toggleFavorite(for: user)
                                    }
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Favoriler")
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let user = viewModel.favoriteUsers[index]
            viewModel.removeFavorite(user: user)
        }
    }
}
#Preview {
    FavoritesView()
        .environmentObject(UsersViewModel()) // Ortak model sağlanmalı
}
