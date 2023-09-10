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
        Update event to firestore
     */
    public func updateEventData(event: Event, name: String, description: String, date: String, time: String, location: String, imageUrl: String, organizerRole: String) -> Event{
        
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
    public func addNewEventData(name: String = "", description: String = "", date: String = "", time: String = "", location: String = "", imageUrl: String = "", organizerRole: String = "") -> Event{
        
        // Initialize dcoument ID in firestore by letting in generate
        let id = db.collection("events").document().documentID
        
        // Call event constructor
        let event: Event = Event(id: id, name: name, description: description, date: date, time: time, location: location, imageUrl: imageUrl, organizerRole: organizerRole)
        
        // Add data process to firestore
        self.postPutFirestore(event: event)
        
        return event
    }
    
    /**
        Add event user join to firestore
     */
    public func addEventToJoinEvents(event: Event){
        // TODO: Get Authenticate UserId
        let uid = ""
        
        // Create new document in eventParticipation collection
        let ref = db.collection("eventParticipation").document()
        
        // Update event with event id, and the id of user
        ref.setData([
            "eventID": event.id,
            "accountID": uid
        ])
    }
    
    /**
        Query the owned events by the ownerID
     */
    public func queryOwnedEvents(){
        // TODO: Get Authenticate UserId
        let uid = ""
        
        // Create a query against the collection.
        let query = db.collection("events").whereField("ownerId", isEqualTo: uid)
        self.queryEventsFirestore(query: query)
    }
    
    /**
        Query the owned events user had joined
     */
    public func queryEventParticipation(){
        // TODO: Get Authenticate UserId
        let uid = ""
        
        // Create a query against the collection.
        let query = db.collection("eventParticipation").whereField("ownerId", isEqualTo: uid)
        
        self.queryEventsFirestore(query: query)
        
    }
    
    /**
        Query the events not owned by the user
        And the events that user have not joined
     */
    public func queryEventsHomePage(){
        // TODO: Get Authenticate UserId
        let uid = ""
        
        // Create a query against the collection.
        let query = db.collection("events").whereField("ownerId", isNotEqualTo: uid)
        self.queryEventsFirestore(query: query)
        self.filterEventsParticipationHelper()
    }
    
    /**
        Update events list from query
     */
    private func queryEventsFirestore(query: Query){
        // Execute the query
        query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // This is for the fake data at beginning
            if documents.isEmpty{
                // Generate fake data
                self.events = FakeDataHelper().generateFakeData(amounts: 20, isPostToFirestore: false)
                return
            }
            
            // Loop to get the event field inside each event document
            self.events = documents.map { (queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                return Event(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    date: data["date"] as? String ?? "",
                    time: data["time"] as? String ?? "",
                    location: data["location"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String ?? "",
                    organizerRole: data["organizerRole"] as? String ?? "")
            }
        }
    }
    
    /**
     Add or update document of event movie name in the "events" collection
     */
    private func postPutFirestore(event: Event){
        // ref is a DocumentReference
        let ref = db.collection("events").document(event.id)
        
        // TODO: Get Authenticate UserId
        let uid = ""
        
        ref.setData(
            [
                "id": event.id,
                "name": event.name,
                "description": event.description,
                "date": event.date,
                "time": event.time,
                "location": event.location,
                "imageUrl": event.imageUrl,
                "ownerId": uid,
                "organizerRole": event.organizerRole
            ]
        )
    }
 
    private func filterEventsParticipationHelper(){
        // TODO: Get Authenticate UserId
        let uid = ""
        
        // Filter out events that user already join
        let query = db.collection("eventParticipation").whereField("accountID", isEqualTo: uid)
        query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                // No existing events that user had participated
                return
            }
            
            // Get all id of the event participation and filter out of the all events
            let eventParticipateIDs = documents.map { (queryDocumentSnapshot) -> String in
                let data = queryDocumentSnapshot.data()
                return data["id"] as? String ?? ""
            }
            self.events = self.events.filter{!eventParticipateIDs.contains($0.id)}
            
        }
    }
}
