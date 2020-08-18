//
//  TimeTableCell.swift
//  AgendaProgrammatically
//
//  Created by eyal avisar on 13/08/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

//creating a protocol - what is the delegate task?
protocol TimeCollectionCellDelegate: class {
    func collectionView(collectionviewcell: DateCollectionCell?, index: Int, tappedTableCell: TimeTableCell)

}

/*
 if timeUnits = 12, internal day label = month
 external day label = year. how to differentiate them? register cells differently?
*/
class TimeTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dayLabel = UILabel()
    
    var dayCollection:UICollectionView!
    //providing a delegate office
    weak var cellDelegate: TimeCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = CGSize(width: 40, height: 60)
        
        dayCollection =  UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        dayCollection.register(DateCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        dayCollection.dataSource = self
        dayCollection.delegate = self
        dayCollection.backgroundColor = .green
        dayCollection.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(dayCollection)
        
        let views = [
        "dayLabel" : dayLabel,
        "dayCollection": dayCollection
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[dayLabel][dayCollection]-|", options: [], metrics: nil, views: views as [String : Any])
       
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dayLabel]-|", options: [], metrics: nil, views: views as [String : Any])
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dayCollection]-|", options: [], metrics: nil, views: views as [String : Any])
        
         NSLayoutConstraint.activate(allConstraints)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    //MARK: collection datasource + delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeUnits
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! DateCollectionCell
        
        cell.containingTableRow = dayLabel.text!
        cell.dateLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionCell
            //consulting with the delegate, if one was instated
        cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, tappedTableCell: self)
        
    }
}
