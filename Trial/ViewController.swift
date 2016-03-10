//
//  ViewController.swift
//  Trial
//
//  Created by Roshan Thapaliya on 3/8/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

import UIKit


class Event : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var location: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
            "location" : "location",
            "metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "kid_bk3toMpXJZ",
            withAppSecret: "60f26725324b4a97959b4dc73399425a",
            usingOptions: nil
        )
        
        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
            if result.pingWasSuccessful {
                NSLog("Kinvey Ping Success")
                self.save()
            } else {
                NSLog("Kinvey Ping Failed")
            }
        }
        
        
        // Create a new user with the username 'kinvey' and the password '12345'
        if KCSUser.activeUser() == nil {
            KCSUser.userWithUsername(
                "kinvey",
                password: "12345",
                fieldsAndValues: nil,
                withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                    if errorOrNil == nil {
                        //user is created
                    } else {
                        //there was an error with the create
                    }
                }
                
            )
            
        }
        else{
            print("already created")
            
        }
        
        
        
        
        
        
    }
    
    func save(){
        let store = KCSAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Events",
            KCSStoreKeyCollectionTemplateClass : Event.self
            ])
        
        let event = Event()
        event.name = "Launch Party"
        event.location = "Kinvey HQ"
        event.date = NSDate(timeIntervalSince1970: 1352149171) //sample date
        store.saveObject(
            event,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

