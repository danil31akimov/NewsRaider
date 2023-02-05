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
         let service = NewsService()
         let viewModel = HeadlinesViewModel(service: service)
         let viewController = HeadlinesViewController(viewModel: viewModel)
         viewController.modalPresentationStyle = .fullScreen
         present(viewController, animated: false)
     }
}

