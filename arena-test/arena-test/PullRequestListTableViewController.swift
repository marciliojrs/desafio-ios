//
//  PullRequestListViewController.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import UIKit
import PullToRefreshSwift

class PullRequestListTableViewController: UITableViewController {
    
    var repository : Repository?
    var pullRequestsList : Array<PullRequest> = []
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.repository?.repositoryName
        
        self.tableView.addPullRefresh {
            self.loadPullRequests()
            self.tableView.reloadData()
            self.tableView.stopPullRefreshEver()
        }
        
        self.loadPullRequests()
    }
    
    func loadPullRequests(){
    
        indicator.color = #colorLiteral(red: 0.8255655169, green: 0.3298256993, blue: 0, alpha: 1)
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()
        
        PullRequestListProvider().getPullRequestList(
            repository: (self.repository?.repositoryName)!,
            user: (self.repository?.repositoryOwnerLogin)!, success: { ( pullRequests ) in
            
                self.pullRequestsList = pullRequests
            
                self.tableView.reloadData()
                
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            
            }, failure: { ( error ) in
                
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension PullRequestListTableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ( section == 0) {
            return 1
        } else {
            return self.pullRequestsList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0) {
            return 44
        } else {
            return 128
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.section == 0) {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "pullRequestHeaderCell", for: indexPath) as! PullRequestListHeaderTableViewCell
            
            cell.setItem(openCount:
                            self.pullRequestsList.lazy.filter{ c in c.pullRequestOwnerState == "open" }.count,
                         closedCount:
                            self.pullRequestsList.lazy.filter{ c in c.pullRequestOwnerState == "closed" }.count)
            
            return cell

            
        } else {
            
            let pullRequest = self.pullRequestsList[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "pullRequestDefaultCell", for: indexPath) as! PullRequestListTableViewCell
            
            cell.setItem(pullRequestItem: pullRequest)
            
            return cell
        
        }
    }
    
}
