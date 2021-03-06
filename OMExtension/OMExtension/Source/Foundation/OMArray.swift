//
//  OMArray.swift
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

public extension Array {
    
    func omRandom() -> (Int, Element)? {
        
        guard count > 0 else {
            
            return nil
        }
        
        let idx = Int(arc4random_uniform(UInt32(count)))
        
        return (idx, self[idx])
    }
    
    func omAtIndex(_ index: Int) -> Element? {
        
        return index >= 0 && index < count ? self[index] : nil
    }
    
    func omFilter(_ valid: (Element) -> Bool) -> Bool {
        
        for item in self {
            
            if !valid(item) {
                
                return false
            }
        }
        
        return true
    }
}

public extension Array where Element: Equatable {
    
    func omDifference(_ values: [Element]...) -> [Element] {
        
        var elements = [Element]()
        
        tag: for element in self {
            
            for value in values {
                
                if value.contains(element) {
                    
                    continue tag
                }
            }
            
            elements.append(element)
        }
        
        return elements
    }
    
    func omUnion(_ values: [Element]...) -> Array {
        
        var elements = self
        
        for element in values {
            
            for value in element {
                
                if !elements.contains(value) {
                    
                    elements.append(value)
                }
            }
        }
        
        return elements
    }
    
    func omIntersection(_ values: [Element]...) -> Array {
        
        var elements = self
        var intersection = Array()
        
        for (offset, element) in values.enumerated() {
            
            if offset > 0 {
                
                elements = intersection
                intersection = Array()
            }
            
            element.forEach({ item in
                
                if elements.contains(item) {
                    
                    intersection.append(item)
                }
            })
        }
        
        return intersection
    }
}
