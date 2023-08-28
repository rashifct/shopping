//
//  NotchedTriangleView.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import Foundation
import UIKit

class NotchedTriangleView: UIView {

    @IBInspectable var triangleBaseSize: CGFloat = 10.0
    @IBInspectable var triangleHeightSize: CGFloat = 5.0

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updatePath()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updatePath()
    }
    
    private func updatePath() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = createPath().cgPath
        layer.mask = maskLayer
    }
    
    private func createPath() -> UIBezierPath {
        let path = UIBezierPath(rect: bounds)
        
        let startPoint = CGPoint(x: bounds.width, y: (bounds.height - triangleHeightSize) / 2)
        let middlePoint = CGPoint(x: bounds.width - triangleBaseSize, y: bounds.height / 2)
        let endPoint = CGPoint(x: bounds.width, y: (bounds.height + triangleHeightSize) / 2)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: middlePoint)
        trianglePath.addLine(to: endPoint)
        trianglePath.close()
        
        path.append(trianglePath)
        path.usesEvenOddFillRule = true
        
        return path
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
}

