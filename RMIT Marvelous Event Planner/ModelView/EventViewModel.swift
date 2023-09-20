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

class EventViewModel: ObservableObject {
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    private let auth = Auth.auth()
    
    
    /**
        Add event user join to firestore
     */
    public func addEventToJoinEvents(event: Event) {
        guard let uid = auth.currentUser?.uid else {return}
        
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
        guard let uid = auth.currentUser?.uid else {return}
        
        // Create a query against the collection.
        let query = db.collection("events").whereField("ownerId", isEqualTo: uid)
        self.queryEventsFirestore(query: query)
    }
    
    /**
        Query the owned events user had joined
     */
    public func queryEventParticipation(){
        self.events = []
        guard let uid = auth.currentUser?.uid else {return}
        
        // Create a query against the collection.
        let queryEventParticipation = db.collection("eventParticipation").whereField("accountID", isEqualTo: uid)
        // Execute the query
        queryEventParticipation.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            if documents.isEmpty{
                return
            }
            let eventIDs = documents.map { (queryDocumentSnapshot) -> String in
                return queryDocumentSnapshot.data()["eventID"] as? String ?? ""
            }
            
            let queryEvents = self.db.collection("events").whereField("id", in: eventIDs)
            self.queryEventsFirestore(query: queryEvents)
        }
    }
    
    /**
        Query the events not owned by the user
        And the events that user have not joined
     */
    public func queryEventsHomePage(){
        guard let uid = auth.currentUser?.uid else {return}
        
        // Create a query against the collection.
        let query = db.collection("events").whereField("ownerId", isNotEqualTo: uid)
        self.queryEventsFirestore(query: query)
    }
    
    public func removeAccountFromEventParticipation(event: Event){
        guard let uid = auth.currentUser?.uid else {return}
        
        // Create a query against the collection.
        let query = db.collection("eventParticipation").whereField("accountID", isEqualTo: uid).whereField("eventID", isEqualTo: event.id)
        
        query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            for document in documents {
                self.db.collection("eventParticipation").document(document.documentID).delete(){ error in
                    if error == nil {
                        print("Leave suscessfully!")
                        self.events = self.events.filter { $0.id != event.id }
                        
                    } else {
                        print("Error leaving events")
                    }
                }
            }
            
        }
    }
    
    /**
        Update events list from query
     */
    private func queryEventsFirestore(query: Query){
        self.events = []
        // Execute the query
        query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // This is for the fake data at beginning
            if documents.isEmpty && false{
                // Generate fake data
                self.events = FakeDataHelper().generateFakeData(amounts: 5)
                return
            }
            
            // Loop to get the event field inside each event document
            let _ = documents.map { (queryDocumentSnapshot) in
                let data = queryDocumentSnapshot.data()
                
                // Fetch directly from the event collection
                let event = Event(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    dateTime: data["dateTime"] as? String ?? "",
                    location: data["location"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String ?? "",
                    organizerRole: data["organizerRole"] as? String ?? "",
                    ownerId: data["ownerId"] as? String ?? "",
                    major: data["major"] as? String ?? "")
                
                self.events.append(event)
            }
        }
    }
    
    
 
    private func filterEventsParticipationHelper(){
        guard let uid = auth.currentUser?.uid else {return}
        
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
