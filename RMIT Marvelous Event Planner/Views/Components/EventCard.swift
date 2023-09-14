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

struct EventCard: View {
    var event: Event
    
    var body: some View {
        ZStack {
            Image(event.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
            
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(event.name)
                            .font(Font.custom("Poppins-Medium", size: 18))
                            .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        ListItem(icon:"clock.fill", content: "\(event.date) - \(event.time)", size: 18)
                        ListItem(icon:"mappin.and.ellipse", content: event.location, size: 18)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                                .rotationEffect(.degrees(-90))
                            Text("Join")
                                .font(Font.custom("Poppins-Regular", size: 18))
                        }
                    }
                    .buttonStyle(PrimaryButton())
                }
                .padding(.all, 10)
                .background(Color("opacity-background"))
            }
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .clipped()
        .shadow(radius: 2.5, x: 0, y: 2.5)
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event(id: "1",name: "Family reunion", description: "Anh em mot nha", date: "24 Dec 2020", time: "9:00", location: "Quang Binh", imageUrl: "sample-image", organizerRole: OrganizerRole.personal.rawValue))
    }
}