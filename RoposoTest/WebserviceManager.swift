//
//  WebserviceManager.swift
//  RoposoTest
//
//  Created by raghav vij on 11/18/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import Foundation
import UIKit
class WebserviceManager {
    static let sharedInstance = WebserviceManager()
    let fetchImagesURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    var imageCache:NSCache<NSNumber, UIImage> = NSCache<NSNumber, UIImage>()
    
    func fetchTheImages(onfinish:@escaping (_ data:Any?)->Void) {
        let getDic = ["format":"json#"]
        self.executeRequest(withURL: fetchImagesURL, getDict: getDic as [String : AnyObject]?, postDict: nil, onFinish: { (data) in
            onfinish(data)
        })
        { (error) in
                print("error")
            //retry the request
            self.fetchTheImages(onfinish: onfinish)
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL,imageView: UIImageView,activityIndicator:UIActivityIndicatorView,index:Int) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                self.imageCache.setObject(UIImage(data: data)!, forKey: NSNumber.init(integerLiteral: index))
                activityIndicator.stopAnimating()
            }
        }
    }
    
    func executeRequest(withURL url:String?, getDict:[String:AnyObject]?, postDict:[String:AnyObject]?,onFinish:@escaping (_ data:Any?) -> Void,onError: @escaping (_ errorData:Any?) -> Void) {
        guard var urlString:String = url else {
            return
        }
        var stringToAppend:String = "?"
        if let getDictionary = getDict {
            var string:String?
            for key in getDictionary.keys {
                string = String(format: "%@=%@&", key,getDictionary[key] as! CVarArg)
                stringToAppend.append(string!)
            }
        }
        let urlToExecute:NSURL?
        if stringToAppend.characters.count > 1 {
           urlString.append(stringToAppend)
           urlToExecute = NSURL(string: String(format: "%@", urlString))
           let request = NSMutableURLRequest(url: urlToExecute as! URL)
            let session = URLSession.shared
            
            request.httpMethod = "GET"
            let task = session.dataTask(with: request as URLRequest) {
                (data, response, error) in
                
                guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                    print("error")
                    return
                }
                let range = NSRange.init(location: 0, length: 15)
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                let string =  dataString?.replacingCharacters(in: range, with: "")
                let range2 = NSRange.init(location: (string?.characters.count)! - 1, length: 1)
                let string2 = NSString(string: string!).replacingCharacters(in: range2, with: "")
                do {
                    let obj = try JSONSerialization.jsonObject(with: (string2.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)))!, options: .allowFragments)
                    DispatchQueue.main.async {
                        onFinish(obj)
                    }
                }
                catch {
                    print("error")
                    //Retry till not successful
                    onError(error)
                }
            }
            
            task.resume()
        }
    }
    
}
