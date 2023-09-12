/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 12/09/2023
  Last modified: dd/MM/yyyy
  Acknowledgement: None.
*/

import SwiftUI

struct JoinedEventsView: View {
    @State private var today: Date = Date()
    @State private var currentTab: String = "Upcoming"
    @Namespace var animation
    
    var body: some View {
        VStack(spacing:0) {
            // Tab section
            HStack(spacing: 0) {
                TabBarButton(current: $currentTab, label: "Upcoming", icon: "calendar", animation: animation)
                TabBarButton(current: $currentTab, label: "Past", icon: "clock.fill", animation: animation)
            }
            
            // List of joined events
            ScrollView {
                
            }
            .background(Color("list-background"))
        }
    }
}

struct JoinedView_Previews: PreviewProvider {
    static var previews: some View {
        JoinedEventsView()
    }
}
