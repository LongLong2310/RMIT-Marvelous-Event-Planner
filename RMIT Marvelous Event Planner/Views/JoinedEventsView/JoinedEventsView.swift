/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 12/09/2023
  Last modified: dd/09/2023
  Acknowledgement: None
*/

import SwiftUI
import Foundation

struct JoinedEventsView: View {
    @EnvironmentObject private var eventVM: EventViewModel
    
    @State private var today: Date = Date()
    @State private var currentTab: String = "Upcoming"
    @State private var filteredEvents: [Event] = []
    @Namespace var animation
    
    func compareEventsByToday() {
        // Avoid duplication
        filteredEvents = []
        
        if !eventVM.events.isEmpty {
            if currentTab == "Upcoming" {
                for event in eventVM.events {
                    if event.dateTimeFormat >= today {
                        filteredEvents.append(event)
                    }
                }
            }
            else if currentTab == "Past" {
                for event in eventVM.events {
                    if event.dateTimeFormat < today {
                        filteredEvents.append(event)
                    }
                }
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
                    EventList(isJoinedEvent: true, events: $filteredEvents, listType: currentTab)
                }
                else if currentTab == "Past" {
                    EventList(isJoinedEvent: true, events: $filteredEvents, listType: currentTab)
                }
            }
        }
        .onAppear(){
            self.eventVM.queryEventParticipation()
        }
        .onChange(of: currentTab) { _ in
            compareEventsByToday()
        }
        .onChange(of: self.eventVM.events) { newValue in
            compareEventsByToday()
        }
    }
}

struct JoinedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

