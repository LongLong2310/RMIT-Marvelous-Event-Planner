/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 16/09/2023
  Last modified: dd/09/2023
  Acknowledgement: None
*/

import SwiftUI

struct EventForm: View {
    //declare variable
    @State private var name: String = ""
    @State private var dateTime: Date = Date.now
    @State private var time: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var selectedType = "SSET"
    @State private var selectedRole: String = "Personal"
    @State private var selectedUrl: String = "sample-image"
    
    let type = ["SSET", "SBM", "SCD"]
    let organizerRoles = ["Personal", "Club", "Department"]
    let imageUrls = ["sample-image", "sample-avatar"]   // Add actual value of images here (URL name should be meaningful)
    
    var body: some View {
        Form {
            // Input fields
            VStack(alignment: .center, spacing: 20.0) {
                // Form title
                Text("Add a new event")
                    .font(Font.custom("Poppins-Medium", size: 24))
                
                // Image input
                VStack(spacing: 10) {
                    VStack {
                        Image(selectedUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(Color("list-background"))
                    .cornerRadius(10)
                    .clipped()
                    
                    Picker(selection: $selectedUrl) {
                        ForEach(imageUrls, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Event image")
                            .font(Font.custom("Poppins-Regular", size: 15))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color("list-background"))
                    .cornerRadius(10)
                }
                
                // Event name input
                TextField("Event name (required)", text: $name)
                    .textFieldStyle(CustomTextField())
                
                // Date time input
                DatePicker(selection: $dateTime, in: Date.now...) {
                    Text("Date and time")
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color("list-background"))
                .cornerRadius(10)
                
                // Location input
                TextField("Location (required)", text: $location)
                    .textFieldStyle(CustomTextField())
                
                // Event type input
                Picker(selection: $selectedType) {
                    ForEach(type, id: \.self) {
                        Text($0)
                    }
                } label: {
                    Text("Event type")
                        .font(Font.custom("Poppins-Regular", size: 15))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color("list-background"))
                .cornerRadius(10)
                
                // Organizer role input
                Picker(selection: $selectedRole) {
                    ForEach(organizerRoles, id: \.self) {
                        Text($0)
                    }
                } label: {
                    Text("Organizer role")
                        .font(Font.custom("Poppins-Regular", size: 15))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color("list-background"))
                .cornerRadius(10)
                
                // Description input
                TextField("Description (optional)", text: $description, axis: .vertical)
                    .textFieldStyle(CustomTextField())
                
                // User actions
                HStack {
                    // Discard button
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                            Text("Discard")
                                .font(Font.custom("Poppins-Regular", size: 18))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(SecondaryButton())
                    
                    // Save button
                    Button {
                        print(name)
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Save")
                                .font(Font.custom("Poppins-Regular", size: 18))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButton())
                }
            }
        }
    }
}

struct EventForm_Previews: PreviewProvider {
    static var previews: some View {
        EventForm()
    }
}
