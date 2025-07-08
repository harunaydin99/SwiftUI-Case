//
//  UserRowView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 1.07.2025.
//

import SwiftUI

// MARK: - User Row View (Reusable)
struct UserRowView: View {
    let user: User
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: "https://i.pravatar.cc/150?img=\(user.id)")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: onToggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    UserRowView(user: User(      // preview için mock data kullanıyoruz
        id: 1,
        name: "Leanne Graham",
        username: "Bret",
        email: "Sincere@april.biz",
        phone: "1-770-736-8031 x56442",
        website: "hildegard.org",
        address: User.Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874"
        ),
        company: User.Company(
            name: "Romaguera-Crona"
        )
    ),
    isFavorite: true,
    onToggleFavorite: {})
}
