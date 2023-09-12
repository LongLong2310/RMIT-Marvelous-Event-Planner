//
//  UserProfileView.swift
//  RMIT Marvelous Event Planner
//
//  Created by mac on 12/09/2023.
//

import SwiftUI

struct UserProfileView: View {
    let email: String
    let name: String
    @State var tabSelectedValue = 0
    var body: some View {
        
        ZStack{
            VStack(spacing:15){
                HStack(spacing: 20){
                    UserProfileImage(image: Image(""))
                    VStack(alignment: .leading,spacing:20){
                        Text(name)
                        Text(email)
                    }
                }
                HStack(spacing:20){
                    VStack{
                        Button{
                            
                        }label:{
                            HStack{
                                Image(systemName: "pencil")
                                Text("Edit profile")
                                    .frame(width:90)
                            }
                        }.buttonStyle(PrimaryButton())
                        
                    }
                    VStack{
                        Button{
                            
                        }label:{
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Log out")
                                    .frame(width:90)
                            }
                        }.buttonStyle(WarningButton())
                    }
                }
                Picker("", selection: $tabSelectedValue) {
                            Text("Events").tag(0)
                            Text("About").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                
                Spacer()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(email: "haoconboha@gmail.com", name: "Pham Viet Hao")
    }
}
