//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 09.06.2024.
//

import UIKit
final class SingleImageViewController: UIViewController{
    var image: UIImage?
    
    @IBOutlet var imageView: UIImageView! //private?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
