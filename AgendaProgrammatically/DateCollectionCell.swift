//
//  DateCollectionCell.swift
//  AgendaProgrammatically
//
//  Created by eyal avisar on 13/08/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class DateCollectionCell: UICollectionViewCell {
    let dateLabel = UILabel()
    var containingTableRow = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        let views = [
         "dateLabel" : dateLabel
         ]
         
         var allConstraints: [NSLayoutConstraint] = []
         allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[dateLabel]-|", options: [], metrics: nil, views: views)
        
         allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dateLabel]-|", options: [], metrics: nil, views: views)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
}
