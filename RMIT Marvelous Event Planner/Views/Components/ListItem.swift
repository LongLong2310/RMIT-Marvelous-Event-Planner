/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 11/09/2023
  Last modified: 12/09/2023
  Acknowledgement: None
*/

import SwiftUI

struct ListItem: View {
    var icon: String
    var content: String
    var size: Double
    
    var body: some View {
        HStack(spacing: 10.0) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(.accentColor)
            Text(content)
                .font(Font.custom("Poppins-Regular", size: size - 3))
                .foregroundColor(Color("text-color"))
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(icon: "clock.fill", content: "dd MMM yyyy - hh:mm", size: 18)
    }
}
