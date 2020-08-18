//
//  ViewController.swift
//  AgendaProgrammatically
//
//  Created by eyal avisar on 13/08/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

/*Things to think about:
 1 - creating yearsTable - yearCollection - monthTable - monthCollection if time units == 12, table should show collection only (hide dayLabel probably easier than playing with registration)
under the same condition timeUnits == 12
 collection view cell should hold a table which in that case would be instantiated and registered like the one here // or add viewcontroller as a subview
 
 2 - when in view controller weekController mode, either take care of table size (probably with conditioned constraints; or add subview of eventsTable to cover its
 */
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TimeCollectionCellDelegate {
    
    //providing channel for delegate
    /*
     i have a view controller which contains a table view
     it is registered and directed to its cell TimeTableCell identifier cell
     this includes a collection view which is registered and directed to its cell DateCollectionCell identifier collectionCell
     there i want the possibility to have another table and to start the process over.
     meaning DateCollectionCell should have an optional table which upon condition should be created and registered to a different cell identifier. when that happens, i should consider row height and cell content. different registration ought to be done with collection as well, and size and content considerations too.
     problem: changing timeUnit to 12 pushing a new viewcontroller - it goes to view controller and should register it the regular way so sizes would be regular, and the inner view controller sh
     */
    private var monthTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "2020", style: .plain, target: self, action: #selector(showYears))
        monthTableView = UITableView()
        
        monthTableView.register(TimeTableCell.self, forCellReuseIdentifier: "cell")
        
        monthTableView.delegate = self
        monthTableView.dataSource = self
        
        monthTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(monthTableView)
        
        let views = ["view": view!, "tableView" : monthTableView]

        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views as [String : Any])
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views as [String : Any])
        NSLayoutConstraint.activate(allConstraints)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func showYears() {
        let yearController = ViewController()
        
        timeUnits = 12
        navigationController?.pushViewController(yearController, animated: true)
    }
    
    //MARK: TimeCollectionCellDelegate delegate
    //defining the communication to be done with the delegate
    func collectionView(collectionviewcell: DateCollectionCell?, index:Int, tappedTableCell: TimeTableCell) {
        print("row \(tappedTableCell.dayLabel.text!) cell \(index)")
        
        let weekController = ViewController()
        
        timeUnits = 7
        navigationController?.pushViewController(weekController, animated: true)

    }
   
    //MARK: datasource + delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timeUnits == 7 {
            return 1
        }
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimeTableCell
        
        
        cell.cellDelegate = self //instating a delegate
        cell.dayLabel.text = "\(indexPath.row)"

        cell.dayLabel.backgroundColor = .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if timeUnits == 7 {
            return 100
        }
        return 400
    }
    
}

