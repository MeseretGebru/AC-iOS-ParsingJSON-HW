//
//  APPLStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class APPLStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var allStocks = [Stock]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadStockData()
    }

    func loadStockData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.allStocks = Stock.getStocks(from: data)
            }
        }
    }

    //MARK: - TableView Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
       // let section = allStocks
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = allStocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stock = allStocks[tableView.indexPathForSelectedRow!.row]
        let detailStockVC = segue.destination as? DetailedAPPLStockViewController
        detailStockVC?.selectedStock = stock
    }
}


