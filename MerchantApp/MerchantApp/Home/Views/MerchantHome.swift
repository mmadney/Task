//
//  ViewController.swift
//  MerchantApp
//
//  Created by Madney on 30/06/2022.
//

import UIKit

class MerchantHome: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    private var socket : MerchantSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         setupTableView()
         setupNavgatioBar()
         setupSocket()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.navigateToOrderRecevied()
        }
        
    }
    
    func setupTableView(){
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.orderTableView.reloadData()
    }
    
    func setupNavgatioBar(){
        self.navigationItem.title = "Orders"
    }
    
    func setupSocket(){
        self.socket = MerchantSocket(merchantId: "id")
        self.socket?.SubscripeToGetOrderEvent()
        self.socket?.ReciveOrder(completion: { [weak self] data in
            guard let self = self else { return }
            //Recive Socket Data Here and Fire Socket Driver To Accept Or Reject after Parse Data
            self.navigateToOrderRecevied()
        })
    }
    
    func navigateToOrderRecevied(){
        let orderReceviedVC = OrderRecieved.Create()
        orderReceviedVC.modalPresentationStyle = .pageSheet
        self.present(orderReceviedVC, animated: true)
    }


}

extension MerchantHome : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell!
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "order1")
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "order2")
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "order3")
        default:
            cell = UITableViewCell()
        }
        return cell
    }
  
    
    
}
