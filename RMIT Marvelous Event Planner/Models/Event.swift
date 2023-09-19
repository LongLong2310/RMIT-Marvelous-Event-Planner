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
    case Personal
    case Club
    case Department
}

let imageUrls = ["event_image_1","event_image_2","event_image_3","event_image_4","event_image_5","event_image_6","event_image_7","event_image_8","event_image_9","event_image_10","event_image_11","event_image_12","event_image_13","event_image_14","event_image_15"]

struct Event: Identifiable{

    var id: String
    var name: String
    var description: String
    var dateTime: String
    var location: String
    var imageUrl: String
    var organizerRole: String
    var ownerId: String
    var ownerName: String = "Username"
    var ownerImage: String = "profile_picture_1"
    var particitpationNumber: Int = 0
    var major: String
    
    let dateTimeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var dateTimeFormat: Date{
        get {
            return dateTimeFormatter.date(from: dateTime) ?? Date()
        }
        set(value) {
            self.dateTime = dateTimeFormatter.string(from: value)
        }
    }
    
    var date: String{
        return dateFormatter.string(from: dateTimeFormat)
    }
    
    var time: String{
        return timeFormatter.string(from: dateTimeFormat)
    }
    
    init(id: String = "", name: String = "", description: String = "", dateTime: String = "", time: String = "", location: String = "", imageUrl: String = "event_image_1", organizerRole: String = "Personal", ownerId: String = "", major: String="SSET") {
        self.id = id
        self.name = name
        self.description = description
        self.dateTime = dateTime
        self.location = location
        self.imageUrl = imageUrl
        self.organizerRole = organizerRole
        self.ownerId = ownerId
        self.major = major
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
    }
    
    mutating func updateEvent(name: String, description: String, dateTime: String, location: String, imageUrl: String, organizerRole: String, major: String="", ownerName: String = "", ownerImage: String = ""){
        self.name = name
        self.description = description
        self.dateTime = date
        self.location = location
        self.imageUrl = imageUrl
        self.organizerRole = organizerRole
        self.major = major
        self.ownerName = ownerName
        self.ownerImage = ownerImage
    }
    
    mutating func updateOwner( ownerName: String = "", ownerImage: String = ""){
        self.ownerName = ownerName
        self.ownerImage = ownerImage
    }
    
    mutating func updateParticipation(number: Int){
        self.particitpationNumber = number
    }
    
    mutating func increaseDecreaseParticipation(number: Int){
        self.particitpationNumber += number
    }
    
    func getDateTime() -> String{
        return dateTimeFormatter.string(from: self.dateTimeFormat)
    }
}
