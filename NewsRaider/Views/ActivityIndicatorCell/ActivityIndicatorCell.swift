//
//  ActivityIndicatorCell.swift
//  NewsRaider
//
//  Created by Данил Акимов on 05.02.2023.
//

import UIKit

final class ActivityIndicatorCell: UITableViewCell {
    
    static let id = "ActivityIndicatorCell"
    
   private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard superview != nil else {
            return
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
        
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)

            
        ])
    }
    
    func startAinimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAinimating() {
        activityIndicator.stopAnimating()
    }
}
