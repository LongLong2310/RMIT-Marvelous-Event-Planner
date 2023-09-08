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

// Customize the style of the button
struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all, 10.0)
            .background(Color("primary-button"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.25), value: configuration.isPressed)
    }
}

struct BackButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all, 10.0)
            .background(Color("opacity-background"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.25), value: configuration.isPressed)
    }
}
