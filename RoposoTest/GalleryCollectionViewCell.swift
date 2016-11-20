//
//  GalleryCollectionViewCell.swift
//  RoposoTest
//
//  Created by raghav vij on 11/18/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    var image:Image?
    var index:Int?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupImageView() {
        guard let imageString = image?.image  else {
            return
        }
        let url = URL(string: imageString)
        if let cacheImage = WebserviceManager.sharedInstance.imageCache.object(forKey: NSNumber.init(integerLiteral: index!)) {
            self.imageView.image = cacheImage
        }else{
            WebserviceManager.sharedInstance.downloadImage(url: url!, imageView: imageView, activityIndicator:self.activityIndicator,index: index!)
        }
    }

}
