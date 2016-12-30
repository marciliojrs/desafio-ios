//
//  PullRequestListTableViewCell.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//


import UIKit

class PullRequestListTableViewCell: UITableViewCell {
    

    @IBOutlet weak var pullRequestTitle: UILabel!
    @IBOutlet weak var pullRequestBody: UILabel!
    @IBOutlet weak var pullRequestOwnerAvatar: UIImageView!
    @IBOutlet weak var pullRequestOwnerLogin: UILabel!
    @IBOutlet weak var pullRequestDate: UILabel!
    @IBOutlet weak var pullRequestStatus: UIView!
    
    func setItem(pullRequestItem : PullRequest) -> Void {
        
        self.pullRequestTitle.text = pullRequestItem.pullRequestTitle
        self.pullRequestBody.text = pullRequestItem.pullRequestBody
        self.pullRequestDate.text = pullRequestItem.pullRequestDate
        self.pullRequestOwnerLogin.text = pullRequestItem.pullRequestOwnerLogin
        
        self.circularImage(photoImageView: self.pullRequestOwnerAvatar)
        
        if (pullRequestItem.pullRequestOwnerAvatar != nil){
            let url = URL(string: pullRequestItem.pullRequestOwnerAvatar!)!
            self.pullRequestOwnerAvatar.kf.setImage(with: url,
                                                   placeholder: nil,
                                                   options: [.transition(.fade(1))],
                                                   progressBlock: nil,
                                                   completionHandler: nil)
            
        }
        
        
        if (pullRequestItem.pullRequestOwnerState == "open") {
            self.pullRequestStatus.backgroundColor = #colorLiteral(red: 0.8255655169, green: 0.3298256993, blue: 0, alpha: 1)
        } else {
            self.pullRequestStatus.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
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
