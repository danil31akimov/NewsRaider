//
//  ViewController.swift
//  NewsRaider
//
//  Created by Данил Акимов on 04.02.2023.
//

import UIKit

 final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         let service = AdsService()
         let viewModel = AdsListViewModel(service: service)
         let viewController = AdsListViewController(viewModel: viewModel)
         viewController.modalPresentationStyle = .fullScreen
         present(viewController, animated: false)
     }
}

