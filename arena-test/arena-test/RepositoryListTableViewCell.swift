//
//  RepositoryListTableViewCell.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDesc: UILabel!
    @IBOutlet weak var repositoryForkCount: UILabel!
    @IBOutlet weak var repositoryStarCount: UILabel!
    @IBOutlet weak var repositoryOwnerAvatar: UIImageView!
    @IBOutlet weak var repositoryOwnerLogin: UILabel!
    
    
    func setItem(repositoryItem : Repository) -> Void {
    
        self.repositoryName.text = repositoryItem.repositoryName
        self.repositoryDesc.text = repositoryItem.repositoryDesc
        self.repositoryForkCount.text = String(repositoryItem.repositoryForkCount)
        self.repositoryStarCount.text = String(repositoryItem.repositoryStarCount)
        self.repositoryOwnerLogin.text = repositoryItem.repositoryOwnerLogin
        
        self.circularImage(photoImageView: self.repositoryOwnerAvatar)
        
        if (repositoryItem.repositoryOwnerAvatar != nil){
            let url = URL(string: repositoryItem.repositoryOwnerAvatar!)!
            self.repositoryOwnerAvatar.kf.setImage(with: url,
                                                   placeholder: nil,
                                                   options: [.transition(.fade(1))],
                                                   progressBlock: nil,
                                                   completionHandler: nil)

        }
    }
    
    func circularImage(photoImageView: UIImageView?)
    {
        photoImageView!.layer.frame = photoImageView!.layer.frame.insetBy(dx: 0, dy: 0)
        photoImageView!.layer.borderColor = UIColor.gray.cgColor
        photoImageView!.layer.cornerRadius = photoImageView!.frame.height/2
        photoImageView!.layer.masksToBounds = false
        photoImageView!.clipsToBounds = true
        photoImageView!.layer.borderWidth = 0.5
        photoImageView!.contentMode = UIViewContentMode.scaleAspectFill
    }
}

