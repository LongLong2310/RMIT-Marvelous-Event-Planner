/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 11/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://www.youtube.com/watch?v=XsDtO7lpeO0&t=1438s
*/

import SwiftUI

// Body
struct ContentView: View {
    @StateObject private var authState = AuthState()
    @StateObject private var eventVM = EventViewModel()
    @State private var isSplashScreenShown: Bool = true
    
    var body: some View {
        Group{
            // Check authenticated
            switch authState.value{
                case .authenticated:
                    HomeScreenView()
                        .environmentObject(authState)
                default:
                    LogInSignUpView()
                        .environmentObject(eventVM)
                        .environmentObject(authState)
            }
      
        }.overlay{
            // TODO: Quan - Add splash screen view and exist and reset showSplashScreen
            if isSplashScreenShown{
                SplashScreenView().onAppear {
                    //dissapear after 2 second by setting isActive to true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.isSplashScreenShown = false
                        }
                    }
                }
            }}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
