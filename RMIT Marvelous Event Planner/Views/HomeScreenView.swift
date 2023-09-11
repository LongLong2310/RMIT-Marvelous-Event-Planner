/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 8/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://docs.google.com/presentation/d/1-QV6pqZBkdGgKGImB7t0izYk0OqzFdrf/edit#slide=id.g25839ad1222_0_435
    https://www.youtube.com/watch?v=XsDtO7lpeO0&t=1438s
    https://www.hackingwithswift.com/quick-start/swiftui/adding-tabview-and-tabitem
*/

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject private var authState: AuthState
    
    var body: some View {
        TabView {
            // Home Events
            Text("Home Events Tab")
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Events Participate
            Text("Events Participate Tab")
                .tabItem {
                    Label("Joined", systemImage: "calendar")
                }
            
            
            // Create Events
            Text("Create Events Tab")
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            
            
            // Profiles
            VStack{
                Text("Profile Tab")
                Button {authState.logout()} label: {Text("Logout")}
            }
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthState())
    }
}
