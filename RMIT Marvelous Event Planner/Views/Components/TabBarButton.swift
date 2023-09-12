/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 12/09/2023
  Last modified: 12/09/2023
  Acknowledgement:
    https://www.youtube.com/watch?v=h7dWHr5gTzc
*/

import SwiftUI

struct TabBarButton: View {
    @Binding var current: String
    var label: String
    var icon: String
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation {
                current = label
            }
        } label: {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                    Text(label)
                        .font(Font.custom(current == label ? "Poppins-Semibold" : "Poppins-Regular", size: 15))
                    
                    
                }
                .foregroundColor(current == label ? .accentColor : Color("text-color"))
                .padding(.vertical, 2.5)
                
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                    
                    if current == label {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
        }
    }
}

//struct TabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinedEventsView()
//    }
//}
