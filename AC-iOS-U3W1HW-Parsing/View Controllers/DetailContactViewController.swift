//
//  DetailContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailContactViewController: UIViewController {

    var contact: Person!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedContact = contact else {
            return
        }
        guard let theImage = unwrappedContact.picture.medium else { return }
        if let imageUrl = URL(string: theImage) {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.global().async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
        
        nameLabel.text = "\(unwrappedContact.name.first) \(unwrappedContact.name.last)"
        emailLabel.text = unwrappedContact.email
        cityLabel.text = unwrappedContact.location.city
        
    }

}
