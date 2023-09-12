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
    var body: some View {
        ZStack {
            Image("sample-image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
            
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Family reunion")
                            .font(Font.custom("Poppins-Medium", size: 18))
                        ListItem(icon:"clock.fill", content: "24 Dec 2020, 9:00", size: 18)
                        ListItem(icon:"mappin.and.ellipse", content: "Dong Hoi, Quang Binh", size: 18)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "person.3.fill")
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
        EventCard()
    }
}
