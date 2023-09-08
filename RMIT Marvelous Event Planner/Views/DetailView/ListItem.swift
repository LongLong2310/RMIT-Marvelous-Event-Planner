/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy
  ID: 3877991
  Created  date: 08/09/2023
  Last modified: dd/mm/yyyy
  Acknowledgement: None.
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
                .frame(width: size)
                .foregroundColor(.accentColor)
            Text(content)
                .font(Font.custom("Poppins-Regular", size: size - 3))
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(icon: "clock.fill", content: "dd MMM yyyy - hh:mm", size: 18)
    }
}
