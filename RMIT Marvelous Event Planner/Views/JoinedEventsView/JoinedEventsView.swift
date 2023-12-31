/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Pham Trinh Hoang Long, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 12/09/2023
 Last modified: dd/09/2023
 Acknowledgement: None
*/

import SwiftUI
import Foundation

struct JoinedEventsView: View {
    @EnvironmentObject private var eventVM: EventViewModel
    @State private var currentTab: String = "Upcoming"
    @Namespace var animation
    
    var filteredEvents: [Event] {
        guard let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else {
            return []
        }

        return eventVM.events.compactMap { event in
            if (currentTab == "Upcoming" && event.dateTimeFormat >= today) ||
               (currentTab == "Past" && event.dateTimeFormat < today) {
                return event
            } else {
                return nil
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing:0) {
                // Tab section
                HStack(spacing: 0) {
                    TabBarButton(current: $currentTab, label: "Upcoming", icon: "calendar", animation: animation)
                    TabBarButton(current: $currentTab, label: "Past", icon: "clock.fill", animation: animation)
                }
                
                // List of joined events
                if currentTab == "Upcoming" {
                    EventList(isJoinedEvent: true, events: Binding(get: { filteredEvents }, set: { _ in }), listType: currentTab)
                }
                else if currentTab == "Past" {
                    EventList(isJoinedEvent: true, events: Binding(get: { filteredEvents }, set: { _ in }), listType: currentTab)
                }
            }
        }
        .onAppear(){
            self.eventVM.isHomePage = false
            self.eventVM.queryEventParticipation()
        }
    }
}

struct JoinedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
