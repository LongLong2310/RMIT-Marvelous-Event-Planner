//
//  EventForm.swift
//  RMIT Marvelous Event Planner
//
//  Created by Ashley on 13/09/2023.
//

import SwiftUI

struct EventForm: View {
    //declare variable
    @State private var EventName: String = ""
    @State private var EventDate: String = ""
    @State private var EventTime: String = ""
    @State private var EventLocation: String = ""
    @State private var EventDes: String = ""
    @State private var selectedType = "Dark"
    let EventType = ["SSET", "SBM", "SCD"]
    @State private var EventOrganizer: String = ""
    let EventRole = ["personal", "club", "department"]
    var body: some View {
        NavigationStack {
            //navigation title
            Text("Add a new event").font(Font.custom("Poppins-Medium", size: 25)).foregroundColor(Color("text-color"))
                .navigationBarTitleDisplayMode(.inline)
            
            Form {
                //event name
                Section(header: Text("Event name") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        TextField("Enter an event name", text: $EventName).font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event date
                Section(header: Text("Date") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        TextField("dd MM yyyy", text: $EventName).font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event time
                Section(header: Text("Time") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        TextField("hh:mm", text: $EventName).font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event location
                Section(header: Text("Location") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        TextField("Enter a location", text: $EventName).font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event organizer type
                Section(header: Text("Organizer") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        Picker("Choose an event type", selection: $EventOrganizer) {
                            ForEach(EventRole, id: \.self) {
                                Text($0)
                            }
                        }.font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event cagetory
                Section(header: Text("Type") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        Picker("Choose an event type", selection: $selectedType) {
                            ForEach(EventType, id: \.self) {
                                Text($0)
                            }
                        }.font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                
                //event desription
                Section(header: Text("Event Description") .font(Font.custom("Poppins-Medium", size: 18))    .foregroundColor(Color("text-color"))
                    .multilineTextAlignment(.leading)) {
                        TextField("Enter a description", text: $EventDes,  axis: .vertical)
                            .lineLimit(5...10).font(Font.custom("Poppins-Regular", size: 15))    .foregroundColor(Color("text-color"))
                            .multilineTextAlignment(.leading)
                    }
                HStack{
                    //button to discard
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "xmark").foregroundColor(.black)
                                .font(Font.custom("Poppins-Regular", size: 25))
                               
                            Text("Discard")
                                .font(Font.custom("Poppins-Regular", size: 25)).foregroundColor(.black)
                                .frame(width: 100, height: 30)
                               
                        }
                    }
                    .buttonStyle(.borderedProminent).tint(.gray.opacity(0.5))
                    Spacer()
                    //button to add new event
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .font(Font.custom("Poppins-Regular", size: 25))
                               
                            Text("Save")
                                .font(Font.custom("Poppins-Regular", size: 25))  .frame(width: 100, height: 30)
                        }
                    }
                    .buttonStyle(.borderedProminent).tint(Color("primary-button"))
                    
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
