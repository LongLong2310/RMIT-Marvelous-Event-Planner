/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 8/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://docs.google.com/presentation/d/1-QV6pqZBkdGgKGImB7t0izYk0OqzFdrf/edit#slide=id.g25839ad1222_0_435
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase/blob/main/MovieListFirestoreExample/MovieViewModel.swift
 */

import SwiftUI
import FirebaseFirestore

class EventViewModel: ObservableObject {
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    
    /**
     Add or update document of event movie name in the "events" collection
     */
    func postPutFirestore(event: Event){
        // ref is a DocumentReference
        let ref = db.collection("events").document(event.id)
        
        // TODO: Get Authenticate UserId
        
        ref.setData(
            [
                "id": event.id,
                "name": event.name,
                "description": event.description,
                "date": event.date,
                "time": event.time,
                "location": event.location,
                "imageUrl": event.imageUrl,
                "ownerId": "",
                "organizerRole": event.organizerRole
            ]
        )
    }
    
    /**
        Update event to firestore
     */
    func updateEventData(event: Event, name: String, description: String, date: String, time: String, location: String, imageUrl: String, organizerRole: String) -> Event{
        
        var event = event
        
        // Update event data
        event.updateEvent(name: name, description: description, date: date, time: time, location: location, imageUrl: imageUrl, organizerRole: organizerRole)
        
        // Update data event in firestore
        self.postPutFirestore(event: event)
        
        return event
    }
    
    /**
        Add event to firestore
     */
    func addNewEventData(name: String = "", description: String = "", date: String = "", time: String = "", location: String = "", imageUrl: String = "", organizerRole: String = "") -> Event{
        
        // Initialize dcoument ID in firestore by letting in generate
        let id = db.collection("events").document().documentID
        
        // Call event constructor
        var event: Event = Event(id: id, name: name, description: description, date: date, time: time, location: location, imageUrl: imageUrl, organizerRole: organizerRole)
        
        // Add data process to firestore
        self.postPutFirestore(event: event)
        
        return event
    }
    
}
