//
//  ImageDescriptionViewController.swift
//  RoposoTest
//
//  Created by raghav vij on 11/19/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import UIKit

class ImageDescriptionViewController: UIViewController,UIWebViewDelegate {
    var image:Image?
    var index:Int?
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webview.delegate = self
        // Do any additional setup after loading the view.
        if let descptionHTMLString = image?.description {
            self.webview.loadHTMLString(descptionHTMLString, baseURL: nil)
        }
        if let authorText = image?.author {
            self.authorLabel.text = authorText
        }
        guard let imageString = image?.image  else {
            return
        }
        let url = URL(string: imageString)
        if let cacheImage = WebserviceManager.sharedInstance.imageCache.object(forKey: NSNumber.init(integerLiteral: index!)) {
            self.imageView.image = cacheImage
            self.activityIndicator.stopAnimating()
        }else{
            WebserviceManager.sharedInstance.downloadImage(url: url!, imageView: imageView, activityIndicator:self.activityIndicator,index: index!)
        }
        if let imageTitle = image?.title {
            if imageTitle != "" {
                self.title = imageTitle
            }else{
                self.title = "Description"
            }
        }else{
            self.title = "Description"
        }
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("did start load")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("did Finish load")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
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
