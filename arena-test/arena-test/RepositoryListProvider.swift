//
//  RepositoryListProvider.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import Foundation
import Argo

class RepositoryListProvider {
    
    func getRepositoriesByPage(page : Int, success:@escaping (Array<Repository>) -> Void, failure:@escaping (String) -> Void ){
        
        BaseProvider().makeGetRequest(
            url: "/search/repositories",
            params: ["q" : "language:Java", "sort" : "star", "page" : page],
            success : { responseData in
                
                if let j: Any = responseData {
                    
                    let repositories : Array<Repository> = (JSON(j) <|| "items").value!;
                    
                    success(repositories)
                    
                } else {
                    failure("ERROR")
                }
                
        }, failure : { responseError in
            
            failure("ERROR")
            
        });
        
    }
}

