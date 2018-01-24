//
//  TableViewController.swift
//  ToDos
//
//  Created by Muhammad Ali on 14/03/2017.
//  Copyright © 2017 Muhammad Ali. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var todos: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        // Configure the cell...
        let x = indexPath.row
        
        // Get values from storage
        let title = todos[x].title //value(forKey: "title") as! String
        let priority = todos[x].priority //value(forKey: "priority") as! String
        let complete = todos[x].complete //value(forKey: "complete") as! Bool
        
        // Strike Through
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: title!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        
        
        // Configure cell using data
        cell.titleLabel.text = title
        
        if (priority == "Low"){
            cell.priorityView.backgroundColor = UIColor.green
        } else if(priority == "Medium"){
            cell.priorityView.backgroundColor = UIColor.orange
        } else{
            cell.priorityView.backgroundColor = UIColor.red
        }
        
        if(!complete) {
            cell.titleLabel.textColor = UIColor.black
        } else {
            cell.titleLabel.textColor = UIColor.darkGray
            cell.titleLabel.attributedText = attributeString
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        do {
            todos = try managedContext.fetch(ToDo.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let x = indexPath.row
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // Delete and Save to update Core Data
            managedContext.delete(todos[x])
            do{
                try managedContext.save()
            }catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            // Fetch to get the updated core data results
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "ToDo")
            do {
                todos = try managedContext.fetch(ToDo.fetchRequest())
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            // Remove row and Update View
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Needed to allow reordering of rows
    @IBAction func startEditing(_ sender: Any) {
        self.isEditing = !self.isEditing
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let managedContext =
        //            appDelegate.persistentContainer.viewContext
        //
        //        let itemToMove = todos[fromIndexPath.row]
        //        todos.remove(at: fromIndexPath.row)
        //        todos.insert(itemToMove, at: to.row)
        //
        //
        //        do{
        //            try managedContext.save()
        //            print("save row staete")
        //        }catch let error as NSError {
        //            print("Could not save. \(error), \(error.userInfo)")
        //        }
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        
        if let destination = segue.destination as? ToDoViewController {
            let x = tableView.indexPathForSelectedRow!.row
            print(x)
            let object = todos[x]
            destination.seguedData = [object]
        }
        
    }
    
    
}
