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
*/

import Foundation
import SwiftUI

enum OrganizerRole: String, CaseIterable{
    case personal
    case club
    case department
}

struct Event: Identifiable{

    var id: String
    var name: String
    var description: String
    var date: String
    var time: String
    var location: String
    var imageUrl: String
    var organizerRole: String
    
    init(id: String, name: String, description: String, date: String, time: String, location: String, imageUrl: String, organizerRole: String) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.time = time
        self.location = location
        self.imageUrl = imageUrl
        self.organizerRole = organizerRole
    }
    
    mutating func updateEvent(name: String, description: String, date: String, time: String, location: String, imageUrl: String, organizerRole: String){
        self.name = name
        self.description = description
        self.date = date
        self.time = time
        self.location = location
        self.imageUrl = imageUrl
        self.organizerRole = organizerRole
    }
    
}
