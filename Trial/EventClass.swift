//
//  EventClass.swift
//  Trial
//
//  Created by Roshan Thapaliya on 5/1/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

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
