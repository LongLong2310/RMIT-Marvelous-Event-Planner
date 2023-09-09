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
        Generate fake data w
     */
    public func generateFakeData(amounts: Int, isPostToFirestore: Bool) -> [Event]{
        for _ in 0...amounts{
            let fakerDateTimeStr = getRandomDateTimeStr()
            
            var event = Event(
                id: UUID().uuidString,
                name: faker.lorem.words(amount: Int.random(in: 0..<6)).capitalized,
                description: faker.lorem.paragraphs(amount: Int.random(in: 1..<3)),
                date: fakerDateTimeStr.0,
                time: fakerDateTimeStr.1,
                location: faker.address.streetAddress(includeSecondary: Bool()),
                imageUrl: "https://picsum.photos/200/300",
                organizerRole: OrganizerRole.allCases.randomElement()!.rawValue)
            
            // Since we generate fake id with UUID, we directly update data
            if isPostToFirestore{
                event = eventViewModel.updateEventData(event: event, name: event.name, description: event.description, date: event.date, time: event.time, location: event.location, imageUrl: event.imageUrl, organizerRole: event.organizerRole)
            }
            
            events.append(event)
        }
        
        return events
    }
    
    /**
        Generate Random Date and Time by faker
     */
    private func getRandomDateTimeStr() -> (String, String){
        let fakerDateTime = faker.date.forward(60)
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Create Time Formatter
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        // range from current date to 60 dates
        return (dateFormatter.string(from: fakerDateTime), timeFormatter.string(from: fakerDateTime))
    }
    
}
