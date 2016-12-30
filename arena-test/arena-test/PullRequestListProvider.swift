//
//  PullRequestListProvider.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import Foundation
import Argo

class PullRequestListProvider {
    
    func getPullRequestList(repository : String, user : String, success:@escaping (Array<PullRequest>) -> Void, failure:@escaping (String) -> Void ){
        
        BaseProvider().makeGetRequest(
            url: "/repos/\(user)/\(repository)/pulls",
            params: nil,
            success : { responseData in
                
                if let j: Any = responseData {
                    
                    let pullrequests: Array<PullRequest> = decode(j)!
                    
                    success(pullrequests)
                    
                } else {
                    failure("ERROR")
                }
                
        }, failure : { responseError in
            
            failure("ERROR")
            
        });
        
    }
}

