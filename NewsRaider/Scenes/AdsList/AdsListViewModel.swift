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

private let PAGE_LIMIT = 20

struct AdsSection {
    let identity: String
    var items: [AdsListViewModel.AdListItem]
}

extension AdsSection: AnimatableSectionModelType {
    init(original: AdsSection, items: [AdsListViewModel.AdListItem]) {
        self = original
        self.items = items
    }
}

final class AdsListViewModel {
    
    enum AdListItem: IdentifiableType, Equatable {
        case activityIndicator
        case ad(Ad)
        
        
        
        var identity: String {
            switch self {
            case .activityIndicator:
                return "activityIndicator"
            case .ad(let ad):
                return ad.identity
            }
        }
    }
    
    let ads: Driver<[AdsSection]>
    let nextPageLoadingTrigger = PublishRelay<Void>()
    
    private let service: AdsServiceType
    
    init(
        service: AdsServiceType
    ) {
        self.service = service
        
        ads = AdsListViewModel.createAdsLoader(
            service: service,
            nextPageTrigger: nextPageLoadingTrigger.asObservable(),
            reloadTrigger: .never())
        
        
    }
        static func createAdsLoader(
            service: AdsServiceType,
            nextPageTrigger: Observable<Void>,
            reloadTrigger: Observable<Void>
        ) -> Driver<[AdsSection]> {
            var page = 1
            return nextPageTrigger
                .flatMap { () -> Single<[Ad]> in
                    service.getAdsList(page: page, limit: PAGE_LIMIT)
                }
                .do(onNext: { _ in
                    
                    page += 1
                    
                })
                .map { ads -> [AdsSection] in
                    return [
                        AdsSection(
                        identity: UUID().uuidString,
                        items: ads.map(AdListItem.ad)
                        )
                   ]
                }
                .asDriver(onErrorJustReturn: [])
                .scan([], accumulator: { old, new in
                    return old.dropLast() + new + [AdsSection(identity: UUID().uuidString, items: [.activityIndicator])]
                })
                .startWith([AdsSection(identity: UUID().uuidString, items: [.activityIndicator])])
    }
}
