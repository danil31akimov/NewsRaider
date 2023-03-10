//
//  HeadlinesViewController.swift
//  NewsRaider
//
//  Created by Данил Акимов on 04.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private enum Constants {
    static let adCell = "AdsListCell"
}

final class AdsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias ViewModel = AdsListViewModel
    
    let viewModel: ViewModel
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedAnimatedDataSource<AdsSection> { (dataSource, tableView: UITableView, indexPath, item) in
        
        
        switch item {
            
        case .activityIndicator:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActivityIndicatorCell.id) as! ActivityIndicatorCell
            cell.startAinimating()
            return cell
       
        
        case .ad(let ad):
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.adCell) as! AdsListCell
            cell.configure(with: ad)
            return cell
        }
       
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
}

private extension AdsListViewController {
    
    func configureViews() {
        configureTableView()
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "AdsListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.adCell)
        tableView.register(ActivityIndicatorCell.self, forCellReuseIdentifier: ActivityIndicatorCell.id)
        
        tableView
            .rx
            .contentOffset
            .map(\.y)
            .filter { [unowned self] y in
                let height = tableView.frame.size.height
                let distanceFromButton = tableView.contentSize.height - y
                return distanceFromButton < height / 2
                
            }
            .debug("AND-1 reached bottom")
            .throttle(.seconds(3), latest: true, scheduler: MainScheduler.instance)
            .map {_ in}
            .bind(to: viewModel.nextPageLoadingTrigger)
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [unowned self] ip in
                tableView.deselectRow(at: ip, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .ads
            .drive(
                tableView.rx.items(dataSource: dataSource)
            )
            .disposed(by: disposeBag)
    }
    
    
    
}


extension AdsListViewController: UITableViewDelegate {
    
}
