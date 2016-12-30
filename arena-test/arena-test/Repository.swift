//
//  Repository.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import Argo
import Curry
import Runes

struct Repository {
    let repositoryId: Int
    let repositoryName: String?
    let repositoryDesc: String?
    let repositoryOwnerLogin: String
    let repositoryOwnerAvatar: String?
    let repositoryStarCount: Int
    let repositoryForkCount: Int
}

extension Repository: Decodable {
    /**
     Decode an object from JSON.
     
     This is the main entry point for Argo. This function declares how the
     conforming type should be decoded from JSON. Since this is a failable
     operation, we need to return a `Decoded` type from this function.
     
     - parameter json: The `JSON` representation of this object
     
     - returns: A decoded instance of the `DecodedType`
     */
    public static func decode(_ json: JSON) -> Decoded<Repository> {
        return curry(Repository.init)
            <^> json <| "id"
            <*> json <|? "name"
            <*> json <|? "description"
            <*> json <| ["owner", "login"]
            <*> json <|? ["owner", "avatar_url"]
            <*> json <| "stargazers_count"
            <*> json <| "forks_count"
    }
    
}
