//
//  AddToDoViewController.swift
//  ToDos
//
//  Created by Muhammad Ali on 14/03/2017.
//  Copyright © 2017 Muhammad Ali. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var priorityValue: UISegmentedControl!
    @IBOutlet weak var completeValue: UISwitch!
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        // Get User Values
        let title = titleValue.text
        let priority = priorityValue.titleForSegment(at:priorityValue.selectedSegmentIndex)
        
        var complete = false
        if completeValue.isOn{
            complete = true
        }else{
            complete = false
        }
        
        // Create New entity and Save
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let todo = ToDo(context : managedContext)
        
        todo.title = title
        todo.priority = priority
        todo.complete = complete
        
        do{
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        // Close Segue
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
