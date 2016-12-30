//
//  PullRequestListHeaderTableViewCell.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import UIKit

class PullRequestListHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pullRequestTotalOpen: UILabel!
    
    @IBOutlet weak var pullRequestTotalClosed: UILabel!
    
    func setItem(openCount : Int, closedCount : Int) -> Void {
        
        self.pullRequestTotalOpen.text = String(openCount) + " opened"
        self.pullRequestTotalClosed.text = String(closedCount) + " closed"
        
    }
    
}
