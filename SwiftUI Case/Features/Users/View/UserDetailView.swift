//
//  UserDetailView.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        Form {
            Section(header: Text("İletişim")) {
                Label(user.phone, systemImage: "phone")
                Label(user.email, systemImage: "envelope")
                Label(user.website, systemImage: "globe")
            }

            Section(header: Text("Adres")) {
                Text("\(user.address.street), \(user.address.suite)")
                Text("\(user.address.city), \(user.address.zipcode)")
            }

            Section(header: Text("Şirket")) {
                Text(user.company.name)
            }
        }
        .navigationTitle(user.name)
    }
}


#Preview {
    UserDetailView(user: User(
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
    ))
}
