//
//  ViewController.swift
//  coredatatest
//
//  Created by IOS1-PC on 3/31/16.
//  Copyright (c) 2016 AgdanL. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSave(sender: UIButton) {
        
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var newStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! NSManagedObject
        
        newStudent.setValue("\(txtFirstName.text)", forKey: "firstname")
        newStudent.setValue("\(txtLastName.text)", forKey: "lastname")
        
        context.save(nil)
    
        
        println(newStudent)
        println("Successfully Saved!")
        
        
    }

    @IBAction func btnSearch(sender: UIButton) {
        
        
        var AppDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = AppDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Student")
        
        
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "lastname = %@", "\(txtLastName.text)")
        var result:NSArray = context.executeFetchRequest(request, error: nil)!
        
        println("Result Count: \(result.count)")
        
        if(result.count>0){
            
            var res = result[0] as! NSManagedObject
            var firstname = res.valueForKey("firstname") as! String
            
            txtFirstName.text = "\(firstname)"
            
        }else{
            println("Student not found!")
        }
        
    }
    @IBAction func btnDelete(sender: UIButton) {
        
       
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Student")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "lastname = %@", "\(txtLastName.text)")
        var result:NSArray = context.executeFetchRequest(request, error: nil)!
        
        if result.count>0 {
            var res = result[0] as! NSManagedObject
            context.deleteObject(res)
            context.save(nil)
            println("Data has been successfully delete!")
            
        }else{
            println("Error deleting data..")
        }
        
        
    }
    @IBAction func btnUpdate(sender: UIButton) {
        
        //person.managedObjectContext?.save()
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Student")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "lastname = %@", "\(txtLastName.text)")
        var result:NSArray = context.executeFetchRequest(request, error: nil)!
        
        if result.count>0 {
            
            var res = result[0] as! NSManagedObject
            res.setValue("\(txtFirstName.text)", forKey:"firstname")
            res.managedObjectContext?.save(nil)
            //context.save(nil)
            println("Data has been updated!")
        }else{
            println("Error Updating")
        }
        
    }
}

