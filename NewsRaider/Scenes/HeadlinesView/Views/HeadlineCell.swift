//
//  HeadlineCell.swift
//  NewsRaider
//
//  Created by Данил Акимов on 04.02.2023.
//

import UIKit

 final class HeadlineCell: UITableViewCell {

     @IBOutlet weak var titleLabel: UILabel!
     @IBOutlet weak var byLineLabel: UILabel!
     @IBOutlet weak var sectionLabel: UILabel!

     func configure(
       with viewModel: TopStoryHeadline
     ) {
         titleLabel.text = viewModel.title
         byLineLabel.text = viewModel.byLine
         sectionLabel.text = viewModel.section
     }
    
}
