//
//  APIManager.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/16/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    @objc static let shared = APIManager()
    let baseUrl = "http://192.168.13.185:8080/report/within3kmRange?posX=108.67859&posY=21.0033356"

    func requestGet(){
        // Alamofire 4
        AF.request(baseUrl).responseString(completionHandler: { (response) in
            let jsonResponse = Utility.convertStringToJson(response.value ?? "")
            print(jsonResponse[0])
        })
    }
}
