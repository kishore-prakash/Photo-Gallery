//
//  ViewController.swift
//  Photo Gallery
//
//  Created by Kishore on 06/12/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import UIKit

class PhotosCollectionVC: UIViewController, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    var images: [UIImage] = []
    @IBOutlet weak var photosCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photosCV.reloadData()
    }


    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case "fullPhotoSegue":
            let vc = segue.destination as? FullscreenVC
            vc?.image = sender as? UIImage
//            vc?.index = sender as? IndexPath
        default:
            break
        }
    }
    
    func removeImageFromList(image: UIImage) {
        images.remove(object: image)
    }
}

extension PhotosCollectionVC: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
        })
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        images.append(image)
        photosCV.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: { () -> Void in
        })
    }
}

extension PhotosCollectionVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCVC else {
            return UICollectionViewCell()
        }
        cell.photoIV.image = images[indexPath.item]
        return cell
    }
}

extension PhotosCollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullPhotoSegue", sender: images[indexPath.item])
    }
}



