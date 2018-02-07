//
//  ViewController.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit

class ContentsViewController: UITableViewController {
    
    fileprivate let SEGUE_OPEN_WEB_VIEW = "ContentsToWebViewSegue"
    
    fileprivate var contents = [Content]()
    
    fileprivate var currentPage = 0
    fileprivate var loadingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Newest"
        
        getContents()
    }
    
    func getContents() {
        CacheManager
            .sharedInstance
            .serviceManager
            .getContent(page: self.currentPage, size: 10, successBlock: { (contents) in
                self.contents.append(contentsOf: contents)
                self.tableView.reloadData()
                
                self.loadingData = false
            }) { (errorMessage) in
                self.loadingData = false
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? WebViewViewController {
            destinationViewController.content = sender as? Content
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.CELL_NAME, for: indexPath) as! ContentTableViewCell
        
        let content = self.contents[indexPath.row]
        cell.setContent(content: content)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let content = self.contents[indexPath.row]
        self.performSegue(withIdentifier: SEGUE_OPEN_WEB_VIEW, sender: content)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.loadingData || indexPath.row != self.contents.count - 1 {
            return
        }
        
        self.loadingData = true
        self.currentPage = self.currentPage + 1
        
        getContents()
    }
}

