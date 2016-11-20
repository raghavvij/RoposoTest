//
//  ViewController.swift
//  RoposoTest
//
//  Created by raghav vij on 11/18/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        webView.delegate = self
//        
//        )
//        webView.loadHTMLString(" <p><a href=\"https://www.flickr.com/people/142456913@N08/\">eugeniomilani</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/142456913@N08/31090956925/\" title=\"PA220626\"><img src=\"https://farm6.staticflickr.com/5498/31090956925_1da3a147c7_m.jpg\" width=\"240\" height=\"180\" alt=\"PA220626\" /></a></p> ", baseURL: nil)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

