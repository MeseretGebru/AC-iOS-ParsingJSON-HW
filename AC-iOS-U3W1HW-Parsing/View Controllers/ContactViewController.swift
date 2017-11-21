//
//  ContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    let cellIdentifier = "Contact Cell"
    
    //MARK: - Instance Methods
    var allContact = [Person]()
    
    var searchTerm: String = "" {
        didSet{
            if searchTerm.count > 0 {
                allContact = allContact.filter{$0.name.fullName.contains(searchTerm)}
            } else {
                loadContact()
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadContact()
        searchBar.delegate = self
    }
    func loadContact(){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do{
                    let responseDict = try myDecoder.decode(ResponseDict.self, from: data)
                    self.allContact = responseDict.results.sorted(by: {$0.name.first < $1.name.first})
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    //                        print(responseDict)
                    
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.searchTerm = text
        return true
    }
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contacts = self.allContact[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = contacts.name.fullName
        cell.detailTextLabel?.text = contacts.location.city.capitalized
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailContactViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            
            let selectedContact = allContact[indexPath.row]
            
            detailVC.contact = selectedContact
            
        }
        
    }
}
