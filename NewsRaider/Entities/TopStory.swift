import Foundation
import RxDataSources
import Fakery


let faker = Faker(locale: "ru")

struct TopStoryHeadline: Decodable  {
    
    struct Media: Decodable {
        let url: String
    }
    
    
    let title: String
    let url: String
    var section: String?
    var byLine: String?
    
    static var placeholder: TopStoryHeadline {
        TopStoryHeadline(title: faker.lorem.words().capitalized,
                         url: faker.internet.url(),
                         section: faker.lorem.word(),
                         byLine: faker.name.name()
        )
    }
}
