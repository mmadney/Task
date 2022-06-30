//
//  OrderRecieved.swift
//  MerchantApp
//
//  Created by Madney on 30/06/2022.
//

import UIKit

class OrderRecieved: UIViewController {
    
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderLocation: UILabel!
    @IBOutlet weak var orderDescrptions: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func acceptBtn(_ sender: Any) {
        self.dismiss(animated: true)
        //if merchant accept order should send post request to assign to driver
    }
    
    @IBAction func Reject(_ sender: Any) {
        self.dismiss(animated: true)
        //if merchant reject should send post request to reject order 
    }
    
    
    static func Create() -> OrderRecieved{
        let stroyBorad = UIStoryboard(name: "Main", bundle: nil)
        let OrderRecieved = stroyBorad.instantiateViewController(withIdentifier: "OrderRecieved") as! OrderRecieved
        return OrderRecieved
    }
    
    
    

}
