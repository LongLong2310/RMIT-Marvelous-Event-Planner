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

struct EventList: View {
    var events: [Event]
    var listType: String
    
    var body: some View {
        VStack {
            // Check if the list of events is empty
            if !events.isEmpty {
                // If not, display that list in scroll view
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(events, id: \.id) { event in
                            NavigationLink {
                                DetailView(event: event)
                            } label: {
                                EventCard(event: event)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            } else {
                // If so, display the message
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                
                    Text("\(listType) events will appear here.")
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color("list-background"))    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
