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
    @EnvironmentObject private var eventVM: EventViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderBar()
                
                TabView {
                    // Home Events
                    HomeEventListView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    
                    // Events Participate
                    JoinedEventsView()
                        .tabItem {
                            Label("Joined", systemImage: "calendar")
                        }
                    
                    // Profiles
                    UserProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                }
            }
        }
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthState())
            .environmentObject(EventViewModel())
    }
}
