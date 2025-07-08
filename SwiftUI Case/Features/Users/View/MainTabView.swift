//
//  ContentView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = UsersViewModel()

    var body: some View {
        TabView {
            UsersView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Kullanıcılar", systemImage:"person.3")
                    }

            FavoritesView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Favoriler", systemImage: "star.fill")
                }
        }
        .accentColor(Color("tabBarItemColor"))
    }
}

#Preview {
    MainTabView()
        .environmentObject(UsersViewModel()) // Zorunlu burada da
}
