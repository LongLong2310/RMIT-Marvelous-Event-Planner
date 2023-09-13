//
//  EventForm.swift
//  RMIT Marvelous Event Planner
//
//  Created by Ashley on 13/09/2023.
//

import SwiftUI

struct EventForm: View {
    @AppStorage("deviceName") private var deviceName: String = ""
    var body: some View {
        NavigationStack {
                    // 2
                    Form {
                        // 3
                        TextField("Name", text: $deviceName)

                    }
                    .navigationBarTitle("Settings")
                }
    }
}

struct EventForm_Previews: PreviewProvider {
    static var previews: some View {
        EventForm()
    }
}
