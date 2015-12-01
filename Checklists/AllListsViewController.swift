//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Qiushi Li on 11/29/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    var lists: [Checklist]

    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]()
        super.init(coder: aDecoder)
        
        let list0 = Checklist(name: "Birthdays")
        let list1 = Checklist(name: "Groceries")
        let list2 = Checklist(name: "Cool Apps")
        let list3 = Checklist(name: "To Do")
        
        lists.append(list0)
        lists.append(list1)
        lists.append(list2)
        lists.append(list3)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        cell.textLabel!.text = lists[indexPath.row].name
        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // preform segue manually
        let checklist = lists[indexPath.row]
        // define which segue to perform and the sender
        // still have to use prepareForSegue method to do destination viewcontroller initialization stuff
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.checklist = sender as! Checklist
        }
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell{
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            // create a cell manually
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }
}
