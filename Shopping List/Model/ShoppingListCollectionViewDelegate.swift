//
//  ShoppingListCollectionViewDelegate.swift
//  Shopping List
//
//  Created by patelpra on 12/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol ShoppingItemCollectionViewCellDelegate: class {
    func toggleHasBeenAdd(for cell: ShoppingItemCollectionViewCell)
}
