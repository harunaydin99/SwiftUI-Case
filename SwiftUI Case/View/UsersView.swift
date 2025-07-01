//
//  UsersView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import SwiftUI

// MARK: - Users View
//
//  UsersView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var viewModel: UsersViewModel

    var body: some View {
        NavigationView {
          /*  List(viewModel.filteredUsers) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    UserRowView(
                        user: user,
                        isFavorite: viewModel.isFavorite(user: user),
                        onToggleFavorite: {
                            viewModel.toggleFavorite(for: user)
                        }
                    )
                }
            }*/
            List(viewModel.filteredUsers) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    UserRowView(
                        user: user,
                        isFavorite: viewModel.isFavorite(user: user),
                        onToggleFavorite: {
                            viewModel.toggleFavorite(for: user)
                        }
                    )
                }
                .buttonStyle(PlainButtonStyle()) // Çakışmaları önlemek için
            }
            .navigationTitle("Kullanıcılar")
            .searchable(text: $viewModel.searchText, prompt: "Ara")
        }
    }
}

#Preview {
    UsersView()
        .environmentObject(UsersViewModel()) // Preview’a environment object sağlanıyor
}
