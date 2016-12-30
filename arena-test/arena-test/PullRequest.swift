//
//  PullRequest.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import Argo
import Curry
import Runes

struct PullRequest {
    let pullRequestId: Int
    let pullRequestTitle: String?
    let pullRequestBody: String?
    let pullRequestDate: String
    let pullRequestOwnerAvatar: String?
    let pullRequestOwnerLogin: String?
    let pullRequestOwnerState: String
}

extension PullRequest: Decodable {
    /**
     Decode an object from JSON.
     
     This is the main entry point for Argo. This function declares how the
     conforming type should be decoded from JSON. Since this is a failable
     operation, we need to return a `Decoded` type from this function.
     
     - parameter json: The `JSON` representation of this object
     
     - returns: A decoded instance of the `DecodedType`
     */
    public static func decode(_ json: JSON) -> Decoded<PullRequest> {
        return curry(PullRequest.init)
            <^> json <|  "id"
            <*> json <|? "title"
            <*> json <|? "body"
            <*> json <|  "created_at"
            <*> json <|? ["user", "avatar_url"]
            <*> json <|? ["user", "login"]
            <*> json <|  "state"
    }
    
}
