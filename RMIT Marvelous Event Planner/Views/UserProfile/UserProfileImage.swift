//
//  UserProfileImage.swift
//  RMIT Marvelous Event Planner
//
//  Created by mac on 12/09/2023.
//

import SwiftUI

struct UserProfileImage: View {
    let image: Image
    var body: some View {
        ZStack{
            image
                .resizable()
                .frame( width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 2)
                ).shadow(radius: 7)
            
        }
    }
}


struct UserProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileImage(image: Image(""))
    }
}
