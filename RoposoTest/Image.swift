//
//  Image.swift
//  RoposoTest
//
//  Created by raghav vij on 11/18/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import Foundation

class Image {
    var title:String?
    var link:String?
    var image:String?
    var date:String?
    var description:String?
    var published:String?
    var author:String?
    var author_id:String?
    var tags:String?
    
    init(withDictionary dict:[String:AnyObject]?) {
        guard let modelDict = dict else {
            return
        }
        if let modelDictTitle = modelDict["title"] as? String {
            self.title = modelDictTitle
        }
        if let modelDictLink = modelDict["link"] as? String {
            self.link = modelDictLink
        }
        if let modelDictMedia = modelDict["media"] as? [String:String] {
            if let modelDictImage = modelDictMedia["m"] {
                self.image = modelDictImage
            }
        }
        if let modelDictDate = modelDict["date_taken"] as? String {
            self.date = modelDictDate
        }
        if let modelDictDescription = modelDict["description"] as? String {
            self.description = modelDictDescription
        }
        if let modelDictPublished = modelDict["published"] as? String {
            self.published = modelDictPublished
        }
        if let modelDictAuthor = modelDict["author"] as? String {
            self.author = modelDictAuthor
        }
        if let modelDictAuthorID = modelDict["author_id"] as? String {
            self.author_id = modelDictAuthorID
        }
        if let modelDictTags = modelDict["tags"] as? String {
            self.tags = modelDictTags
        }
    }
}
