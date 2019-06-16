//
//  Utility.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import SwiftyJSON

class Utility: NSObject {
    class func convertStringToJson(_ strInput: String) -> JSON {
        let json = strInput.data(using: .utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
        return json
    }
}
