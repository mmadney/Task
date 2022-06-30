//
//  ViewController.swift
//  DriverApp
//
//  Created by Madney on 01/07/2022.
//

import UIKit
import MapKit

class Homevc: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    private var socket : DriverSocket?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        setupSocket()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.navigateToOrderRecevied()
        }
    }
    
   
   
    func setupSocket(){
        self.socket = DriverSocket(driverId: "id")
        self.socket?.SubscripeToGetOrderEvent()
        self.socket?.ReciveOrder(completion: { [weak self] data in
            guard let self = self else { return }
            //Recive Socket Data Here and Fire Socket Driver To Accept Or Reject after Parse Data
            self.navigateToOrderRecevied()
        })
    }
    
    func navigateToOrderRecevied(){
        let orderReceviedVC = OrderVC.Create()
        orderReceviedVC.modalPresentationStyle = .pageSheet
        self.present(orderReceviedVC, animated: true)
    }


}

