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

struct HeaderBar: View {
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        HStack {
            // Logo
            Text("RMEP")
                    .font(Font.custom("Poppins-SemiBold", size: 30))
                
            Spacer()
            
            // User action buttons
            HStack(spacing: 20) {
                // Add a new event button
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                }
                
                // Dark mode toggle button
                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct HeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
