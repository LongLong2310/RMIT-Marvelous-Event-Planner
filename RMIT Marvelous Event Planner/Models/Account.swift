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

enum SchoolDepartment: String, CaseIterable{
    case SSET
    case SCD
    case SBM
}

let profilePictures = ["profile_picture_1","profile_picture_2","profile_picture_3","profile_picture_4","profile_picture_5"]

class Account: NSObject, Identifiable {
    
    var id: String?
    var email: String
    var name: String
    var profilePicture: String
    var major: String
    var darkModeSetting: Bool
    var isMajorFilterSetting: Bool
    
    init(id: String? = nil, email: String, name: String, profilePicture: String, major: String, darkModeSetting: Bool, isMajorFilterSetting: Bool) {
        self.id = id
        self.email = email
        self.name = name
        self.profilePicture = profilePicture
        self.major = major
        self.darkModeSetting = darkModeSetting
        self.isMajorFilterSetting = isMajorFilterSetting
    }
    
    func setAttribute(data: [String:AnyObject]){
        for (key,value) in data {
            switch key {
                case "name":
                    self.name = value as! String
                    break
                case "profilePicture":
                    self.profilePicture = value as! String
                    break
                case "major":
                    self.major = value as! String
                    break
                case "darkModeSetting":
                    self.darkModeSetting = value as! Bool
                    break
                case "isMajorFilterSetting":
                    self.isMajorFilterSetting = value as! Bool
                    break
                default:
                    break
            }
        }
    }
}
