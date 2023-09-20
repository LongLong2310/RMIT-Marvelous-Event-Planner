//
//  UserProfileView.swift
//  RMIT Marvelous Event Planner
//
//  Created by mac on 12/09/2023.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject private var authState: AuthState
    @StateObject var eventVM: EventViewModel = EventViewModel()
    @State var avatarName = "Avatar 1"
    @State var Phase = 1
    @State private var currentTab: String = "Events"
    @State private var username: String = ""
    @State private var major: String = ""
    @State private var useremail: String = ""
    @State private var password: String = ""
    @State private var showPasswordL: Bool = false
    @State private var showingAlert = false
    @State private var showingPopupLogoutAlert = false
    let type = ["SSET", "SBM", "SCD"]
    
    @Namespace var animation
//  Function to return to the profile information page
    func previousPhase() {
        if (Phase > 1 ) {
            Phase -= 1
        }
    }
 
//  Function to go to the edit profile page
    func nextPhase() {
        if (Phase < 3) {
            Phase += 1
        }
    }
    
//  Function to validate if any field is emty
    func errorCheck() -> String?{
        if username.trimmingCharacters(in: .whitespaces).isEmpty ||
            major.trimmingCharacters(in: .whitespaces).isEmpty{
            showingAlert = true
            return "Please fill all the field"
        }else{
            authState.setAccountData(name: username, profilePicture: avatarName, major: major);
            previousPhase()
        }
        return nil
    }
    
    
//  Custom texfield for edit profile
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
// If the current phase is equal to 1, the screen will show the user profile page
        ZStack{
            if(Phase == 1){
                VStack(spacing:20){
                    
                    HStack(spacing: 10){
                        UserProfileImage(image: authState.account!.profilePicture)
                        VStack(alignment: .leading,spacing:5){
                            Text("\(authState.account!.name)")
                                .font(Font.custom("Poppins-Regular", size: 24))
                            Text("\(authState.account!.email)")
                                .font(Font.custom("Poppins-Regular", size: 15))
                            Text("\(authState.account!.major)")
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
                                showingPopupLogoutAlert = true
                            }label:{
                                HStack{
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Log out")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(WarningButton())
                            .alert(isPresented: $showingPopupLogoutAlert) {
                                  Alert(title: Text("Are you sure to logout?"), primaryButton: .destructive(Text("Confirm"), action: {
                                    // Perform the action.
                                      authState.logout()
                                  }), secondaryButton: .cancel())
                            }
                        }
                    }
                    .padding(.horizontal,20)

                            VStack {
                                EventList(events: $eventVM.events, listType: currentTab)
                            }
                            .frame(width: UIScreen.main.bounds.size.width)
                            .background(Color("list-background"))
                        }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    Spacer()

// If phase is equal to 2 display the edit profile
            }else if(Phase == 2){
                
                VStack(spacing: 20){
                    Text("Edit profile")
                        .font(Font.custom("Poppins-SemiBold", size: 30))
                    VStack(alignment: .leading, spacing: 20){
                        Text("Basic Information")
                            .font(Font.custom("Poppins-SemiBold", size: 20))
                        
                        let avatarView = UserProfileImage(image: avatarName)

//  Select an avatar for edit profile
                        Text("Select an avatar")
                                    Picker("Pick your avatar:", selection: $avatarName) {
                                        Text("Avatar 1").tag("profile_picture_1")
                                        Text("Avatar 2").tag("profile_picture_2")
                                        Text("Avatar 3").tag("profile_picture_3")
                                        Text("Avatar 4").tag("profile_picture_4")
                                        Text("Avatar 5").tag("profile_picture_5")
                                    }.offset(x: -10)
//  Edit profile
                        HStack{
                            Spacer()
                            avatarView
                            Spacer()
                        }
                        CustomTextField(
                            title: "Name",
                            hint: "\(authState.account!.name)",
                            value: $username,
                            showPassword: .constant(false)
                        )
                        HStack{
                            Text("Select school major")
                                .foregroundColor(Color.black.opacity(0.8))
                            Picker(selection: $major) {
                                ForEach(type, id: \.self) {
                                    Text($0)
                                }
                            } label: {
                                Text("Select School major")
                                    .font(Font.custom("Poppins-Regular", size: 15))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                    Spacer()
//  Buttons section edit profile
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
                                errorCheck()
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
                } .alert(" Please enter all the require field", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
        .onAppear(){
            authState.fetchUser()
            self.eventVM.queryOwnedEvents()
        }
    }
        
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(
            AuthState())
    }
}
