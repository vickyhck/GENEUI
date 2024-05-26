//
//  photoPreviewViewController.swift
//  Gene
//
//  Created by manoj on 06/01/24.
//
import UIKit
import Photos

class photoPreviewViewController : UIView {
    let imageView = UIImageView()
    let saveButton = UIButton()
    let uploadButton = UIButton()
    let retakeButton = UIButton()
    weak var cameraVC : cameraViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
        
        imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            addSubview(saveButton)
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(.black, for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
          addSubview(uploadButton)
        
        retakeButton.setTitle("Retake", for: .normal)
        retakeButton.setTitleColor(.black, for: .normal)
        retakeButton.addTarget(self, action: #selector(retakeButtonTapped), for: .touchUpInside)
           addSubview(retakeButton)
        
        // Add constraints
        // Assuming you want buttons at the bottom of the view and imageView to take the remaining space
        imageView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            uploadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            uploadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            retakeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            retakeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            retakeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    @objc func saveButtonTapped() {
        
        
        cameraVC!.savePhotoToLibrary(imageView.image!)
        showAlert(message: "Photo Saved Successfully")
        
        saveButton.setTitle("Saved!", for: .normal)
        saveButton.isUserInteractionEnabled = true
    }
    
    @objc func uploadButtonTapped() {
        
  //      let uploadImage = cameraViewController()
        
        guard imageView.image != nil else {
            print("No image to upload")
            return
        }
//uploadImage(image: )
        
        
        
        cameraVC!.uploadImage(image: imageView.image!)
        
       showAlert(message: "Uploaded Succesfully")
        
        uploadButton.setTitle("Uploaded!", for: .normal)
        
        uploadButton.isUserInteractionEnabled = true
        
        
    }
    
    @objc func retakeButtonTapped() {
        
      removeFromSuperview()


    }
    
    private func showAlert(message: String) {
           let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           cameraVC?.present(alertController, animated: true, completion: nil)
       }

}


