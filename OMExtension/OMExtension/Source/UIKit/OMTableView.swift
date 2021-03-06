//
//  OMTableView.swift
//  OMExtension
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 OctMon
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

public extension UITableView {
    
    func omReloadAnimationWithWave() {
        
        setContentOffset(contentOffset, animated: false)
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.isHidden = true
            self.reloadData()
            
        }, completion: { (_) in
            
            self.isHidden = false
            self.visibleRowsBeginAnimation()
        }) 
    }
    
    fileprivate func visibleRowsBeginAnimation() {
        
        let array = indexPathsForVisibleRows
        
        if let pathArray = array {
            
            for path in pathArray {
                
                let cell = cellForRow(at: path)
                cell?.center = CGPoint(x: frame.size.width * 0.5, y: cell!.center.y)
            }
            
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
            for (num, item) in pathArray.enumerated() {
                
                let cell = self.cellForRow(at: item)
                cell?.isHidden = true
                let i: Double = Double(num)
                
                perform(#selector(UITableView.animationStart(_:)), with: item, afterDelay: 0.1 * (i + 1))
            }
        }
    }
    
    @objc fileprivate func animationStart(_ path: IndexPath) {
        
        let cell = cellForRow(at: path)
        
        if let animationCell = cell {
            
            let originPoint = animationCell.center
            animationCell.center = CGPoint(x: animationCell.frame.size.width, y: originPoint.y)
            
            UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(), animations: {
                
                animationCell.center = CGPoint(x: originPoint.x - 2, y: originPoint.y)
                animationCell.isHidden = false
                
            }) { (_) in
                
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions(), animations: {
                    
                    animationCell.center = CGPoint(x: originPoint.x + 2, y: originPoint.y)
                    
                    }, completion: { (_) in
                        
                        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions(), animations: {
                            
                            animationCell.center = originPoint
                            
                            }, completion: nil)
                })
            }
        }
    }

}
