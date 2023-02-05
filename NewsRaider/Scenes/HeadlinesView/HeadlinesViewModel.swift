//
//  HeadlinesViewModel.swift
//  NewsRaider
//
//  Created by Данил Акимов on 04.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

extension TopStoryHeadline: IdentifiableType, Equatable {
    
    static func == (lhs: TopStoryHeadline, rhs: TopStoryHeadline) -> Bool {
        lhs.title == rhs.title
    }
    
    var identity: some Hashable {
        title
    }
}
struct NewsSection {
    let identity: String
    var items: [TopStoryHeadline]
}

extension NewsSection: AnimatableSectionModelType {
    init(original: NewsSection, items: [TopStoryHeadline]) {
        self = original
        self.items = items
    }
}

final class HeadlinesViewModel {
    
    let headlines: Driver<[NewsSection]>
    
    private let service: NewsServiceType
    
    init(
        service: NewsServiceType
    ) {
        self.service = service
            
        headlines = service
            .getTopHeadlines()
            .map { headlines in
                return [
                    NewsSection(
                    identity: UUID().uuidString,
                    items: headlines)
               ]
            }
                    
            .asDriver(onErrorJustReturn: [])
    }
}
