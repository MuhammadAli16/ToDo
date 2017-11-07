//
//  ToDoViewController.swift
//  ToDos
//
//  Created by Muhammad Ali on 14/03/2017.
//  Copyright © 2017 Muhammad Ali. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var priorityItem: UILabel!
    @IBOutlet weak var completeItem: UILabel!
    
    var theTitle: String?
    
    var seguedData: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStuff()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureStuff()
    }
    
    
    func configureStuff() {
        titleItem.text = seguedData[0].title //value(forKey: "title") as? String
        priorityItem.text = seguedData[0].priority //value(forKey: "priority") as? String
        if (seguedData[0].complete  == true){
            completeItem.text = "Complete"
        } else {
            completeItem.text = "Not Complete"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let destination = segue.destination as? EditToDoViewController {
            let object = seguedData[0]
            destination.seguedDataEdit = [object]
        }
        
    }
    
    
}
