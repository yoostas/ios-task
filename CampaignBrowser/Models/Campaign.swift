import Foundation
import RxSwift


typealias CampaignList = [Campaign]


class Campaign {

    /** The campaign's unique identifier. Usually used to identify the campaign in URLs. */
    let urlKey: String

    /** The campaign's name. This is the name which is displayed to customers. */
    let name: String

    let description: String

    /** An observable that will emit the campaign's mood image. */
    let moodImage: Observable<UIImage>

    /**
     Designated initializer.
     */
    init(urlKey: String, name: String, description: String, moodImage: Observable<UIImage>) {
        self.urlKey = urlKey
        self.name = name
        self.description = description
        self.moodImage = moodImage
    }
}



extension Campaign: Hashable {
    var hashValue: Int {
        return 42 ^ urlKey.hashValue
    }
}


extension Campaign: Equatable {
    static func == (lhs: Campaign, rhs: Campaign) -> Bool {
        return lhs.urlKey == rhs.urlKey
    }
}
