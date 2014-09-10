//
//  ViewController.swift
//  CMCoreDate
//
//  Created by WangXiaoXiang on 9/5/14.
//  Copyright (c) 2014 Next.FList. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
                            
    @IBOutlet weak var tf: UITextField!
    @IBAction func sb(sender: UIButton) {
        println("tf.text:\(tf.text)");
        var list:List = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: CMCoreDateManager.sharedInstance.managedObjectContext) as List
        list.item = tf.text;
        var error:NSError? = nil;
        if (CMCoreDateManager.sharedInstance.managedObjectContext?.save(&error) != nil) {
            println("存储成功!");
        }else{
            println("存储失败!");
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func load(){
        var request = NSFetchRequest();
        var entity = NSEntityDescription.entityForName("List", inManagedObjectContext: CMCoreDateManager.sharedInstance.managedObjectContext);
        request.entity = entity;
        var error:NSError? = nil;
        var list = CMCoreDateManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: &error);
        println("list:\(list)");
        for item in list!{
            var li = item as List;
            println("list:\(li.item)");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loadd(sender: AnyObject) {
        self.load();
    }


}

