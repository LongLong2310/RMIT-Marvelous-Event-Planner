/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 9/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://stackoverflow.com/questions/59760615/create-random-time-in-swift
    https://github.com/vadymmarkov/Fakery
    https://cocoacasts.com/swift-fundamentals-how-to-convert-a-date-to-a-string-in-swift
    https://developer.apple.com/documentation/foundation/date/3329237-advanced
 */



import Foundation
import Fakery

class FakeDataHelper {
    let eventViewModel: EventViewModel = EventViewModel()
    // Create fake data for event
    var events: [Event] = []
    let faker = Faker(locale: "en-US")
    
    /**
        Generate fake data with faker libary
     */
    public func generateFakeData(amounts: Int) -> [Event]{
        let default_image_list = self.generate_image_list()
        
        for _ in 0...amounts{
            let randomDateTime: String = self.generateRandomDateTimeRange()
            let event = Event(
                id: UUID().uuidString,
                name: faker.lorem.words(amount: Int.random(in: 1..<6)).capitalized,
                description: faker.lorem.paragraphs(amount: Int.random(in: 1..<3)),
                dateTime: randomDateTime,
                location: faker.address.streetAddress(includeSecondary: Bool()),
                imageUrl: default_image_list.randomElement() ?? "event_image_1",
                organizerRole: OrganizerRole.allCases.randomElement()!.rawValue,
                major: SchoolDepartment.allCases.randomElement()!.rawValue)
            
            events.append(event)
        }
        
        return events
    }
    
    /**
        Generate Random Date and Time by faker
     */
    func generateRandomDateTimeRange() -> String {

        // Get the start and end dates for the range.
        let startDate = faker.date.backward(days: 60)
        let endDate =  faker.date.forward(90)

        // Generate a random number between the start and end dates.
        let randomTimestamp = TimeInterval.random(in: startDate.timeIntervalSince1970...endDate.timeIntervalSince1970)

        // Create a new Date object from the random number.
        let randomDateTime = Date(timeIntervalSince1970: randomTimestamp)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: randomDateTime)
    }
    
    
    private func generate_image_list() -> [String] {
        var image_str_list: [String] = []
        for index in 0...10{
            image_str_list.append("event_image_\(index)")
        }
        return image_str_list
    }
    
}
