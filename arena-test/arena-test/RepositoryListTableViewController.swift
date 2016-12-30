//
//  RepositoryListViewController.swift
//  arena-test
//
//  Created by Rodolfo Helfenstein Bulgam on 12/29/16.
//  Copyright © 2016 Helfens Studios. All rights reserved.
//

import UIKit
import Argo
import PullToRefreshSwift

class RepositoryListTableViewController: UITableViewController {
    
    var repositoryList : Array<Repository> = []
    var pageCount : Int = 0
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageCount = 1
        
        self.tableView.addPullRefresh {
        
            self.pageCount = 1
            
            self.loadRepositoriesByPage(page: self.pageCount)
            self.tableView.reloadData()
            self.tableView.stopPullRefreshEver()
        
        }
        
        self.tableView.addPushRefresh {
            
            self.pageCount = self.pageCount + 1
            
            self.loadRepositoriesByPage(page: self.pageCount)
            self.tableView.reloadData()
            self.tableView.stopPushRefreshEver()
        }
        
        self.loadRepositoriesByPage(page: self.pageCount)
    }
    
    
    
    func loadRepositoriesByPage(page : Int) {
    
        indicator.color = #colorLiteral(red: 0.8255655169, green: 0.3298256993, blue: 0, alpha: 1)
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()

        
        RepositoryListProvider().getRepositoriesByPage(page: page, success: {
            ( repositories ) in
            
            if (page == 1) {
                self.repositoryList = repositories
            } else {
                self.repositoryList += repositories
            }
            
            self.tableView.reloadData()
            
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
            
        }, failure: {
            ( error ) in
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPullRequest" {
            let pullRequestListTableViewController = segue.destination as! PullRequestListTableViewController
            let repository = sender as! Repository
            pullRequestListTableViewController.repository = repository
            self.navigationItem.title = nil
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationItem.title = "Github JavaPop"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RepositoryListTableViewController {


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let repository = self.repositoryList[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryListDefaultCell", for: indexPath) as! RepositoryListTableViewCell

        cell.setItem(repositoryItem: repository)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPullRequest", sender: self.repositoryList[indexPath.row])
    }
    
}
