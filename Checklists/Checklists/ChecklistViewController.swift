//
//  ViewController.swift
//  Checklists
//
//  Created by Ankit on 30/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
//    var items: [ChecklistItem]
    var checklist: Checklist!

    required init?(coder aDecoder: NSCoder) {
        
//        items = [ChecklistItem]()
        super.init(coder: aDecoder)
//        loadChecklistItems()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        let item = checklist.items[indexPath.row]
            
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        saveChecklistItems()
    }

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
            let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
                self.removeChecklistItem(indexPath)
            }
            delete.backgroundColor = UIColor.redColor()
            
            let edit = UITableViewRowAction(style: .Normal, title: "Edit") { action, index in
                self.performSegueWithIdentifier("EditItem", sender: indexPath)
                print("favorite button tapped")
            }
            edit.backgroundColor = UIColor.lightGrayColor()

            return [delete, edit]
    }
    
    func removeChecklistItem(indexPath: NSIndexPath) {
        checklist.items.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        saveChecklistItems()
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
            let label = cell.viewWithTag(1000) as! UILabel
            label.text = item.text
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = sender as? NSIndexPath {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
            
        }
    }
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPaths = [NSIndexPath(forRow: newRowIndex, inSection: 0)]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            
//        saveChecklistItems()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        if let index = checklist.items.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
//        saveChecklistItems()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

