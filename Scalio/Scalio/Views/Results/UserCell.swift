//
//  UserCell.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 20/02/2022.
//

import SwiftUI

struct UserCell: View {
    var item: Item!
    @EnvironmentObject var settings: SearchSettings
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: item.avatarURL), content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }, placeholder: {
                        ProgressView()
                    })
                    .frame(width: 100, height: 100)
                    .background(Color(.systemGray5))
                    .cornerRadius(50)
                       
                    VStack(alignment: .leading, spacing: 7) {
                        Text(item.login)
                            .font(.headline)
                        HStack(spacing: 5) {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.gray)
                                .font(.subheadline)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(item.type)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .frame(height: 120)
            .padding([.leading, .trailing], 16)
            .padding(.top, 0)
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
