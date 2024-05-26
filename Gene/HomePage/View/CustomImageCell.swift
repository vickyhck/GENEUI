
 // CustomImageCell.swift
//  Gene

//  Created by manoj on 02/02/24.


import UIKit
import SDWebImage

protocol CustomImageCellDelegate: AnyObject {
    func reloadCellAt(_ index: Int)
}

class CustomImageCell : UITableViewCell {
    

    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postsView: UIImageView!

    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    @IBOutlet var useButton: UIButton!
    
    static let reuseIdentifier = "CustomImageCell"
    
    weak var delegate: CustomImageCellDelegate?


    func configure(with image : String?, likeCounts : String, commentCounts : String, index: Int) {
        let imageurl =  URL(string: image!)

        DispatchQueue.main.async {
            
            self.postsView.sd_setImage(with: imageurl) {  image, _, _, _ in
                if let image = image {
                    
                    let aspectRatio = image.size.width / image.size.height
                    let imageviewHeight = self.contentView.frame.width / aspectRatio
                    if self.imageHeightConstraint.constant != imageviewHeight {
                        self.imageHeightConstraint.constant = imageviewHeight
                        self.delegate?.reloadCellAt(self.useButton.tag)
                    }
                    
                }
          
            }
        }
        likeCountLabel.text = likeCounts
        commentsCountLabel.text = commentCounts 
        useButton.tag = index
       
//        if let image = image {
//            
//            let aspectRatio = image.size.width / image.size.height
//            let imageviewHeight = contentView.frame.width / aspectRatio
//            imageHeightConstraint.constant = imageviewHeight
//        }
    }
}
