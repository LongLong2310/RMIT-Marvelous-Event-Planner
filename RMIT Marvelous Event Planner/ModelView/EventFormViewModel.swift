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
import FirebaseAuth

class EventFormViewModel: ObservableObject {
    @Published var event: Event
    private var db = Firestore.firestore()
    private let auth = Auth.auth()
    
    init(event: Event?){
        self.event = event ?? Event(imageUrl: "sample-image")
    }
    
    /**
        Add event to firestore
     */
    public func addNewEventData(){
        
        // Initialize dcoument ID in firestore by letting in generate
        let id = db.collection("events").document().documentID
        
        self.event.id = id
        
        guard let uid = auth.currentUser?.uid else {return}
        
        // Add data process to firestore
        self.postPutFirestore(event: event, uid: uid)
        
    }
    
    /**
        Update event to firestore
     */
    public func updateEventData(){
        
        guard let uid = auth.currentUser?.uid else {return}
        
        // Update data event in firestore
        self.postPutFirestore(event: event, uid: uid)
        
    }
    
    /**
        Fetch event by id
     */
    public func fetchEvent(){
        let ref = self.db.collection("events").document(event.id)
        
        ref.getDocument { (document, error) in
            if let document = document {
                // Parse document as account value
                let data = document.data()
                if let data = data {
                    // Pass data account to published user details
                    self.event.updateEvent(
                        name: data["name"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        dateTime: data["dateTime"] as? String ?? "",
                        location: data["location"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        organizerRole: data["organizerRole"] as? String ?? "",
                        major: data["major"] as? String ?? "")
                        
                }
            }
        }
    }
    
    public func removeOwnedEvent(){
        // Specify the document to delete
        db.collection("events").document(event.id).delete{ error in
            if error == nil {
                print("Remove suscessfully!")
            } else {
                print("Error removing events")
            }
        }
        
        /* Remove all events from event participation collection*/
        /**
             Since we don't display number of participation so no need to remove
             If we do have then do the delete function here
         **/
    }
    
    /**
     Add or update document of event movie name in the "events" collection
     */
    private func postPutFirestore(event: Event, uid: String?){
        // ref is a DocumentReference
        let ref = db.collection("events").document(event.id)
        
        ref.setData(
            [
                "id": event.id,
                "name": event.name,
                "description": event.description,
                "dateTime": event.getDateTime(),
                "location": event.location,
                "imageUrl": event.imageUrl,
                "ownerId": uid!,
                "organizerRole": event.organizerRole,
                "major": event.major
            ]
        )
    }
    
    // ----------- FAKE DATA TO FIREBASE HELPER --------------------//
    public func addEventToJoinEventsWithUid(uid: String){
        let query = db.collection("events").whereField("ownerId", isNotEqualTo: uid)
        
        // Execute the query
        query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let events = documents.map { (queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                return Event(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    dateTime: data["dateTime"] as? String ?? "",
                    location: data["location"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String ?? "",
                    organizerRole: data["organizerRole"] as? String ?? "",
                    major: data["major"] as? String ?? "")
            }
            
            var eventIdList: [Event] = []
            for _ in 0...Int.random(in: 0...10){
                let event: Event = events.randomElement() ?? events[0]
                
                if !eventIdList.contains(where: { existingEvent in
                    existingEvent.id == event.id
                }){
                    // Create new document in eventParticipation collection
                    let ref = self.db.collection("eventParticipation").document()
                    
                    // Update event with event id, and the id of user
                    ref.setData([
                        "eventID": event.id,
                        "accountID": uid
                    ])
                    
                    eventIdList.append(event)
                }
            }
        }
    }
    
    public func addFakeDataToFirestore(uid: String){
        // generate fake data and add
        for event in FakeDataHelper().generateFakeData(amounts: Int.random(in: 0...10)) {
            // Initialize dcoument ID in firestore by letting in generate
            let id = db.collection("events").document().documentID
            
            // Call event constructor
            let event: Event = Event(
                id: id, name: event.name,
                description: event.description,
                dateTime: event.dateTime,
                location: event.location,
                imageUrl: event.imageUrl,
                organizerRole: event.organizerRole,
                major: event.major)
            
            // Add data process to firestore
            self.postPutFirestore(event: event, uid: uid)
        }
    }
    
}