//
//  FullscreenVC.swift
//  Photo Gallery
//
//  Created by Kishore on 06/12/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import UIKit

class FullscreenVC: UIViewController {

    @IBOutlet weak var fullScreenIV: UIImageView!
    var image: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let image = image else {
            return
        }
        
        fullScreenIV.image = image
    }
    
    @IBAction func deleteTapped(_ sender: UIBarButtonItem) {
        guard let image = image, let navController = self.navigationController, navController.viewControllers.count >= 2 else {
            return
        }
        
        presentAlertWithTitle(title: "Alert", message: "Are you sure you want to delete this photo?", options: "Delete", "Cancel") { (buttonNumber) in
            if buttonNumber == 0 {
                let viewController = navController.viewControllers[navController.viewControllers.count - 2] as? PhotosCollectionVC
                viewController?.removeImageFromList(image: image)
                navController.popViewController(animated: true)
            }
        }
        
    }
}
