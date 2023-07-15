//
//  JsonUtil.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/17.
//

import UIKit

class JSONUtils: NSObject {
    class func jsonFromObject(object: Encodable) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        } catch let encodeErr {
            print("Unable to decode", encodeErr)
        }
        return nil
    }
    
    class func objectFromJson<T:Decodable>(mold: T.Type ,json: String) -> T? {
        do {
            let object = try JSONDecoder().decode(mold.self, from: json.data(using: .utf8)!)
            return object
        } catch let decodeErr {
            print("Unable to decode", decodeErr)
        }
        return nil
    }
}
