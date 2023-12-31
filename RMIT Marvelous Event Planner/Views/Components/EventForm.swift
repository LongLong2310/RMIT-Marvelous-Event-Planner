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
    @Environment(\.dismiss) var dismiss
    @StateObject var formViewModel: EventFormViewModel
    
    let type = ["SSET", "SBM", "SCD"]
    
    var body: some View {
        Form {
            // Input fields
            VStack(alignment: .center, spacing: 20.0) {
                // Form title
                Text(formViewModel.event.id != "" ? "Edit event" : "Add a new event")
                    .font(Font.custom("Poppins-Medium", size: 24))
                
                // Image input
                VStack(spacing: 10) {
                    VStack {
                        Image(formViewModel.event.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(Color("list-background"))
                    .cornerRadius(10)
                    .clipped()
                    
                    Picker(selection: $formViewModel.event.imageUrl) {
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
                TextField("Event name (required)", text: $formViewModel.event.name)
                    .textFieldStyle(CustomTextField())
                
                // Date time input
                VStack (alignment: .leading){
                    Text("Date and time")
                        .font(Font.custom("Poppins-Regular", size: 12))
                    DatePicker(selection: $formViewModel.event.dateTimeFormat) {
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color("list-background"))
                    .cornerRadius(10)
                }
                
                
                // Location input
                TextField("Location (required)", text: $formViewModel.event.location)
                    .textFieldStyle(CustomTextField())
                
                // Event type input
                Picker(selection: $formViewModel.event.major) {
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
                Picker(selection: $formViewModel.event.organizerRole) {
                    ForEach(OrganizerRole.allCases.map{ $0.rawValue }, id: \.self) {
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
                TextField("Description (optional)", text: $formViewModel.event.description, axis: .vertical)
                    .textFieldStyle(CustomTextField())
                
                Text(formViewModel.showingAlert ? "Field should be filled" : "")
                // User actions
                HStack {
                    // Discard button
                    Button {
                        dismiss()
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
                        DispatchQueue.global(qos: .background).sync {
                            if (formViewModel.event.id != ""){
                                formViewModel.updateEventData()
                            }
                            else {
                                formViewModel.addNewEventData()
                            }
                        }
                        
                        if(formViewModel.showingAlert == false){
                            dismiss()
                        }
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
        }.alert(" Please enter all the require field", isPresented: $formViewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct EventForm_Previews: PreviewProvider {
    static var previews: some View {
        EventForm(formViewModel: EventFormViewModel(event: nil))
    }
}
