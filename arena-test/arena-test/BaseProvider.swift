//
//  BaseProvider.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import Foundation
import Alamofire

class BaseProvider {

    var baseURL: URL { return URL(string: "https://api.github.com")! }

    func makePostRequest(){
        
    }
    
    func makeGetRequest(url : String, params : [String:Any]?, success:@escaping (Any?) -> Void, failure:@escaping (Any?) -> Void ){
        
        Alamofire.request(
            self.baseURL.absoluteString + url,
            method: .get,
            parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success(_) :
                let json: Any? = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                success(json)
            case .failure(_):
                let json: Any? = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                failure(json)
            }
        }
    }
}
