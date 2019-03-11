//
//  SharpenSkillsCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SharpenSkillsCell: GenericTableCell<ProductMedia> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    override var model : ProductMedia! {
        didSet {
            cellImageView.urlSetImage(model.image)
            titleLabel.text = model.title
            dateLabel.text = model.type
            descriptionLabel.text = model.description
        }
    }
}
