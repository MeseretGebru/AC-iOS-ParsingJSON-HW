//
//  APPLStockInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


class Stock {
    let date: String
    let open: Double
    let close: Double
    let label: String
    init(date: String, open: Double, close: Double, label: String){
        self.date = date
        self.open = open
        self.close = close
        self.label = label
    }
    
    convenience init?(from dictStock: [String: Any]){
        guard let date = dictStock["date"] as? String else {return nil}
        let open = dictStock["open"] as? Double ?? 0.0
        let close = dictStock["close"] as? Double ?? 0.0
        let label = dictStock["label"] as? String ?? "Not Found"
        self.init(date:date, open:open, close:close, label:label)
    }
    
    class func getStocks(from data: Data) -> [Stock] {
        var allStocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let arrDictStocks = json as? [[String: Any]] else {return []}
            for dictStock in arrDictStocks {
                if let stockDict = Stock(from: dictStock) {
                    allStocks.append(stockDict)
                }
            }
        }
        catch let error {
            print("Error serializating data: \(error)")
        }
        return allStocks
    }
}

