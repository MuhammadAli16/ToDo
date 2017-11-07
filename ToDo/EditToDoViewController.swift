//
//  EditToDoViewController.swift
//  ToDos
//
//  Created by Muhammad Ali on 15/03/2017.
//  Copyright © 2017 Muhammad Ali. All rights reserved.
//

import UIKit
import CoreData

class EditToDoViewController: UIViewController {
    
    
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var priorityValue: UISegmentedControl!
    @IBOutlet weak var completeValue: UISwitch!
    var seguedDataEdit: [ToDo] = []
    
    @IBAction func updatedata(_ sender: Any) {
        
        // Get Values from Inputs
        let title = titleValue.text
        let priority = priorityValue.titleForSegment(at:priorityValue.selectedSegmentIndex)
        var complete = false
        
        if completeValue.isOn{
            complete = true
        }else{
            complete = false
        }
        
        
        // Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        seguedDataEdit[0].title = title //setValue(title, forKey: "title")
        seguedDataEdit[0].priority = priority //setValue(priority, forKey: "priority")
        seguedDataEdit[0].complete = complete // setValue(complete, forKey: "complete")
        
        do{
            try managedContext.save()
            //self.seguedDataEdit.append(song)
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        // Dismiss after processing
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Values
        titleValue.text = seguedDataEdit[0].title
        
        if (seguedDataEdit[0].priority == "Low") {
            priorityValue.selectedSegmentIndex = 0
        } else if (seguedDataEdit[0].priority == "Medium") {
            priorityValue.selectedSegmentIndex = 1
        } else{
            priorityValue.selectedSegmentIndex = 2
        }
        
        if (seguedDataEdit[0].complete == true )  {
            completeValue.setOn(true, animated: true)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ToDoViewController {
            let object = seguedDataEdit[0]
            destination.seguedData = [object]
        }
    }
    
    
}
