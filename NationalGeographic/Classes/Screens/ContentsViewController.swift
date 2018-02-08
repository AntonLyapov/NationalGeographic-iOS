//
//  ContentsViewController.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContentsViewController: UITableViewController {
    
    fileprivate let SEGUE_OPEN_WEB_VIEW_CONTROLLER = "ContentsToWebViewControllerSegue"
    
    fileprivate var tableData = [Content]()
    
    fileprivate var currentPage = 0
    fileprivate var loadingData = false
    
    lazy var tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ContentsViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Newest"
        self.tableView.addSubview(tableRefreshControl)
        
        getContents(removeOldData: true)
    }
    
    func getContents(removeOldData: Bool) {
        SVProgressHUD.show()
        
        CacheManager
            .sharedInstance
            .serviceManager
            .getContent(page: self.currentPage, size: 10, successBlock: { (contents) in
                SVProgressHUD.dismiss()
                
                if removeOldData {
                    self.tableData.removeAll()
                }
                self.tableData.append(contentsOf: contents)
                self.tableView.reloadData()
                
                self.loadingData = false
            }) { (errorMessage) in
                SVProgressHUD.dismiss()
                
                self.loadingData = false
            }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        self.currentPage = 0
        getContents(removeOldData: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? WebViewViewController {
            destinationViewController.content = sender as? Content
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.CELL_NAME, for: indexPath) as! ContentTableViewCell
        
        let content = self.tableData[indexPath.row]
        cell.setContent(content: content)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let content = self.tableData[indexPath.row]
        self.performSegue(withIdentifier: SEGUE_OPEN_WEB_VIEW_CONTROLLER, sender: content)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.loadingData || indexPath.row != self.tableData.count - 1 {
            return
        }
        
        self.loadingData = true
        self.currentPage = self.currentPage + 1
        
        getContents(removeOldData: false)
    }
}
