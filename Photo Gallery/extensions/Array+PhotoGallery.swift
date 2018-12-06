//
//  Array+PhotoGallery.swift
//  Photo Gallery
//
//  Created by Kishore on 06/12/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
