//
//  MerchantSocket.swift
//  MerchantApp
//
//  Created by Madney on 30/06/2022.
//

import Foundation
import PusherSwift

class MerchantSocket: PusherDelegate {
    var options: PusherClientOptions
    var pusher: Pusher
    var socketId: String?
    var mychannel: PusherChannel?
    var MerchantId: String
    var timer = Timer()
    var chekSocketTimer = 0

    init(merchantId:String) {
        self.MerchantId = merchantId
        options = PusherClientOptions(authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
                                      host: .host("socketURL"),
                                      port: 6001,
                                      useTLS: true)
        pusher = Pusher(key: "ABCDEFGHIJKLM", options: options)
        pusher.delegate = self
    }

    func establishConnection() {
        pusher.connect()
        checkSocketStatus()
    }

    func closeConnection() {
        pusher.disconnect()
    }

    func checkSocketStatus() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc func timerAction() {
        chekSocketTimer = chekSocketTimer + 1
        checkStatus()
        if chekSocketTimer == 5 {
            timer.invalidate()
            chekSocketTimer = 0
        }
    }

    func checkStatus() {
        print(pusher.connection.connectionState.stringValue())
    }

    func SubscripeToGetOrderEvent() {
        mychannel = pusher.subscribe("private-Get.Order.\(MerchantId)")
    }
    

    func ReciveOrder(completion:@escaping([String: AnyObject])->()) {
        _ = mychannel?.bind(eventName: "client-Receve.Order", eventCallback: { (data: Any?) -> Void in
            if let data = data as? [String: AnyObject] {
               completion(data)
            }
        })
    }
}


class AuthRequestBuilder: AuthRequestBuilderProtocol {
    func requestFor(socketID: String, channelName: String) -> URLRequest? {
        var token = "Token"
        token = "Bearer \(token)"
        var request = URLRequest(url: URL(string: "Socket Url")!)
         request.httpMethod = "POST"
         request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: String.Encoding.utf8)
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
         return request
    }
}
