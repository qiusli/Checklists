//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Qiushi Li on 11/29/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // resume from the previous screen if app terminated in accident
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count{
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        cell.textLabel!.text = dataModel.lists[indexPath.row].name
        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        // preform segue manually
        let checklist = dataModel.lists[indexPath.row]
        // define which segue to perform and the sender
        // still have to use prepareForSegue method to do destination viewcontroller initialization stuff
        // we cannot see the relation between two scenes if segue manually
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    // enable user to swipe-to-delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        dataModel.lists.removeAtIndex(index)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navContr = storyboard!.instantiateViewControllerWithIdentifier("ListDetailNavigationController") as! UINavigationController
        let controller = navContr.topViewController as! ListDetailViewController
        controller.delegate = self
        controller.checkistToEdit = dataModel.lists[indexPath.row]
        
        // load a view controller manually when cell accessory tapped without segue
        presentViewController(navContr, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navContr = segue.destinationViewController as! UINavigationController
            let controller = navContr.topViewController as! ListDetailViewController
            controller.delegate = self
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
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        let indexRowPath = dataModel.lists.count
        dataModel.lists.append(checklist)
        let indexPath = NSIndexPath(forRow: indexRowPath, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        if let index = dataModel.lists.indexOf(checklist) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                // cell comes with a textLabel if it is generated manually
                cell.textLabel!.text = checklist.name
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
}
