//
//  UserProfileView.swift
//  RMIT Marvelous Event Planner
//
//  Created by mac on 12/09/2023.
//

import SwiftUI

struct UserProfileView: View {
    @State var account: Account
    
    @State var Phase = 1
    @State private var currentTab: String = "Events"
    @State private var username: String = ""
    @State private var useremail: String = ""
    @State private var password: String = ""
    @State private var showPasswordL: Bool = false
    
    @Namespace var animation
    
    func previousPhase() {
        if (Phase > 1 ) {
            Phase -= 1
        }
    }
    
    func nextPhase() {
        if (Phase < 3) {
            Phase += 1
        }
    }
    
    @ViewBuilder
    func CustomTextField(
//        icon: String,
        title: String,
        hint: String,
        value: Binding<String>,
        showPassword: Binding<Bool>
    ) -> some View {
        // Create a VStack to arrange the components vertically.
        VStack (alignment: .leading, spacing: 12) {
                Text(title)
                    .foregroundColor(Color.black.opacity(0.8))
            // Depending on the title (e.g., if it contains "Password") and showPassword state,
            // either show a SecureField (password) or TextField (non-password) input.
            if (title.contains("Password") && !showPassword.wrappedValue) {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            // Divider line below the text input.
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Overlay a button to toggle password visibility (visible only for password fields).
        .overlay(
            Group {
                if (title.contains("Password")) {
                    Button (
                        action: {
                            // Toggle the showPassword state to hide/show the password.
                            showPassword.wrappedValue.toggle()
                        },
                        label: {
                            // Display "Hide" when the password is shown, and "Show" when hidden.
                            Text(showPassword.wrappedValue ? "Hide" : "Show")
                                .foregroundColor(Color("primary-button"))
                        }
                    )
                    .offset(y: 9)
                }
            },
            alignment: .trailing
        ).padding(.top, 3)
    }
    
    var body: some View {
        
        ZStack{
            if(Phase == 1){
                VStack(spacing:20){
                    
                    HeaderBar()
                    
                    HStack(spacing: 10){
                        UserProfileImage(image: Image("\(account.profilePicture)"))
                        VStack(alignment: .leading,spacing:5){
                            Text(account.name)
                                .font(Font.custom("Poppins-Regular", size: 24))
                            Text(account.email)
                                .font(Font.custom("Poppins-Regular", size: 15))
                        }
                        
                        Spacer()
                    }.padding(.horizontal,20)
                    
                    HStack(spacing:20){
                        VStack{
                            Button{
                                nextPhase()
                            }label:{
                                HStack{
                                    Image(systemName: "pencil")
                                    Text("Edit profile")
                                        
                                }
                                .frame(maxWidth: .infinity)
                            }.buttonStyle(PrimaryButton())
                            
                        }
                        VStack{
                            Button{
                                
                            }label:{
                                HStack{
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Log out")
                                }
                                .frame(maxWidth: .infinity)
                            }.buttonStyle(WarningButton())
                        }
                    }
                    .padding(.horizontal,20)
                    
                    HStack{
                        TabBarButton(current: $currentTab, label: "Events", icon: "calendar", animation: animation)
                        TabBarButton(current: $currentTab, label: "About", icon: "person", animation: animation)
                    }
                    
                    TabView(selection: $currentTab) {
                        if(currentTab == "About"){
                            ScrollView {
                                VStack(spacing:10){
                                    UserProfileRow(title: "Birthday", content: "04/04/2002")
                                    UserProfileRow(title: "Major", content: "\(account.major)")
                                    UserProfileRow(title: "Join date", content: "12/09/2023")
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        Text("Content for second tab")
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    Spacer()
                }
            }else if(Phase == 2){
                VStack(spacing: 10){
                    Text("Edit profile")
                        .font(Font.custom("Poppins-SemiBold", size: 30))
                    UserProfileImage(image: Image(""))
                    VStack(alignment: .leading){
                        Text("Basic Information")
                            .font(Font.custom("Poppins-SemiBold", size: 20))
                        CustomTextField(
                            title: "Username",
                            hint: "username",
                            value: $username,
                            showPassword: .constant(false)
                        )
                        CustomTextField(
                            title: "Email",
                            hint: "Email",
                            value: $useremail,
                            showPassword: .constant(false)
                        )
                        CustomTextField(
                            title: "Password",
                            hint: "Password",
                            value: $password,
                            showPassword: .constant(false)
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                    Spacer()
                    
                    HStack(spacing:20){
                        VStack{
                            Button{
                                previousPhase()
                            }label:{
                                HStack{
                                    Image(systemName: "multiply")
                                    Text("Discard")
                                }
                                .frame(maxWidth: .infinity)
                            }.buttonStyle(WarningButton())
                            
                        }
                        VStack{
                            Button{
                                previousPhase()
                            }label:{
                                HStack{
                                    Image(systemName: "checkmark")
                                    Text("Save")
                                }
                                .frame(maxWidth: .infinity)
                            }.buttonStyle(PrimaryButton())
                        }
                    }
                    .padding(.horizontal,20)
                    .padding(.top, 10)
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(account: Account(id:"1", email: "haoconboha@gmail.com", name: "Pham Viet Hao", profilePicture: "", major: "Information Technology", darkModeSetting: false, isMajorFilterSetting: false))
    }
}
