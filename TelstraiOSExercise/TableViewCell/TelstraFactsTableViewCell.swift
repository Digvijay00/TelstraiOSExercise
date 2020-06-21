//
//  TelstraFactsTableViewCell.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/21/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import UIKit

//MARK:  - TELSTAR FACTS TABLE VIEW CELL
class TelstraFactsTableViewCell: UITableViewCell {
    // Telstra TableView Cell UI Components declaration
    /// Telstra Cell Title Text
    let cellTitle = UILabel()
    
    /// Telstra Cell Description Text View
    let descriptionTextView : UITextView = {
        // Initial Settings for the cell Text View
        let description = UITextView()
        description.font = UIFont.systemFont(ofSize: 14)
        description.isEditable = false
        description.isSelectable = false
        description.isScrollEnabled = false
        return description
    }()
    
    /// Telstra Cell Image
    let cellImage : UIImageView = {
        // Initial Settings for the cell Image View
        let imageView = UIImageView(image: UIImage(named: "noImg"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    let spacing: CGFloat = 20
    //MARK:  - INITILIZATION
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        // UI Components added to the Cell
        setupUI()
        
        // Constraints added to the UI components inside the cell
        setupConstraint()
    }
    
    func setupConstraint() {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        cellImage.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing).isActive = true
        cellTitle.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: spacing).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: (spacing/4)).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: cellTitle.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: cellTitle.trailingAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -(spacing/2)).isActive = true
    }
    
    func setupUI() {
        addSubview(cellTitle)
        addSubview(descriptionTextView)
        addSubview(cellImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: TelstraFactData) {
        cellTitle.text = data.title
        descriptionTextView.text = data.description
        cellImage.image = UIImage(named: "noImg")
    }
}
