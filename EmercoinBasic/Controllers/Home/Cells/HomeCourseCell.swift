//
//  HomeCourseCell.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 15/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import UIKit

class HomeCourseCell: BaseTableViewCell {

    @IBOutlet weak var arrowImageView:UIImageView!
    
    var views:[CourseView] = []
    
    override var isExpanded: Bool {
        didSet{
            let arrowImage = (isExpanded) ? "arrow_col_icon" : "arrow_exp_icon"
            arrowImageView.image = UIImage(named: arrowImage)
        }
    }
    
    override func updateUI() {
        
        if views.count == 0 {
            
            var point = CGPoint(x: 0, y: Constants.CellHeights.HomeMyMoneyCell.Collapsed)
            
            for i in 0...1 {
                
                if views.count > 0 {
                    let separator = UIView(frame:frame)
                    separator.frame.size.height = 1.0
                    separator.frame.origin.y = point.y
                    separator.backgroundColor = .lightGray
                    point.y += 1
                    
                    let sepWhite = UIView(frame:separator.frame)
                    sepWhite.backgroundColor = .white
                    sepWhite.frame.size.width = 75
                    sepWhite.frame.origin = .zero
                    separator.addSubview(sepWhite)
                    addSubview(separator)
                }
                let courseView:CourseView = loadViewFromXib(name: "Home", index: 1, frame: .zero) as! CourseView
                var newFrame = frame
                newFrame.origin = point
                newFrame.size.height = CGFloat(Constants.CellHeights.HomeCourseCell.CourseView)
                if i == 1 {
                    courseView.titleLabel.text = "Best bid"
                }
                courseView.frame = newFrame
                addSubview(courseView)
                point.y += newFrame.height
                
                views.append(courseView)
            }
        }
    }
    
    @IBAction func pressedButton(sender:UIButton) {
        
        isExpanded = !isExpanded
        
        if pressedCell != nil {
            pressedCell!(indexPath!)
        }
    }
}
