//
//  DetailedAPPLStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedAPPLStockViewController: UIViewController {
    
    var selectedStock: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
    }
    func loadLabels(){
        //var checkMarketValue: Bool
        
        dateLabel.text = selectedStock.date
        openLabel.text = "\(selectedStock.open)"
        closeLabel.text = "\(selectedStock.close)"
        if selectedStock.close > selectedStock.open {
        //checkMarketValue = true
        self.view.backgroundColor = .green
        imageView.image = #imageLiteral(resourceName: "thumbsUp")
        } else {
        //checkMarketValue = false
        imageView.image = #imageLiteral(resourceName: "thumbsDown")
        self.view.backgroundColor = .red
        }
    }

}
