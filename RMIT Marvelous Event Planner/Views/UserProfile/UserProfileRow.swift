//
//  UserProfileRow.swift
//  RMIT Marvelous Event Planner
//
//  Created by mac on 12/09/2023.
//

import SwiftUI

struct UserProfileRow: View {
    let title: String
    let content: String
    var body: some View {
        ZStack(){
            VStack(alignment: .leading){
                Text(title)
                    .font(Font.custom("Poppins-Medium", size: 20))
                Text(content)
                    .font(Font.custom("Poppins-Regular", size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct UserProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileRow(title: "Birthday", content: "04/04/2002")
    }
}
