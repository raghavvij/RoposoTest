//
//  ImageGalleryVC.swift
//  RoposoTest
//
//  Created by raghav vij on 11/18/16.
//  Copyright © 2016 raghav vij. All rights reserved.
//

import UIKit

class ImageGalleryVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingImagesLabel: UILabel!
    var imageObjectsArray:[Image]?
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageObjectsArray = []
        let nib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        self.galleryCollectionView.register(nib, forCellWithReuseIdentifier: "galleryCollecitonViewCell")
        // Do any additional setup after loading the view.
        WebserviceManager.sharedInstance.fetchTheImages {data in
            self.activityIndicator.stopAnimating()
            self.loadingImagesLabel.text = ""
            self.loadingImagesLabel.isHidden = true
            if let objectData = data as? [String:AnyObject] {
                if let title = objectData["title"] as? String {
                    self.title = title
                }else{
                    self.title = "Image Gallery"
                }
                if let items = objectData["items"] as? [AnyObject] {
                    for obj in items {
                        if let imageObj = obj as? [String:AnyObject] {
                            let imageObject = Image(withDictionary: imageObj)
                            self.imageObjectsArray?.append(imageObject)
                            self.galleryCollectionView.delegate = self
                            self.galleryCollectionView.dataSource = self
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let objectsArray = imageObjectsArray {
            return objectsArray.count
        }else{
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollecitonViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.image = imageObjectsArray?[indexPath.row]
        cell.index = indexPath.row
        cell.setupImageView()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        if (UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft) {
           return CGSize(width: screenWidth/3, height: screenHeight/2)
        }else{
           return CGSize(width: screenWidth/2, height: screenHeight/3)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDescriptionVC = self.storyboard?.instantiateViewController(withIdentifier: "imageDesciption") as! ImageDescriptionViewController
        imageDescriptionVC.image = imageObjectsArray?[indexPath.row]
        imageDescriptionVC.index = indexPath.row
        self.navigationController?.pushViewController(imageDescriptionVC, animated: true)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        // Reload Data here
        
        self.galleryCollectionView.reloadData()
        
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
