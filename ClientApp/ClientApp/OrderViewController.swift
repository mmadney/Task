//
//  ViewController.swift
//  ClientApp
//
//  Created by Madney on 30/06/2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var orderName: UITextField!
    @IBOutlet weak var orderLocation: UITextField!
    @IBOutlet weak var orderDescptions: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Place Order"
    }
    
    @IBAction func sendOrder(_ sender: Any) {
        guard let ordername = orderName.text else { return }
        guard let orderDate = orderLocation.text else { return }
        guard let orderDescrptions = orderDescptions.text else { return }
        //Create Post request here to start Fire Socket in Merchant app
        
        
    }
    


}

