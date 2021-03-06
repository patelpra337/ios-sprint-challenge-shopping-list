//
//  ShoppingListCollectionViewController.swift
//  Shopping List
//
//  Created by patelpra on 12/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShoppingItemCell"

class ShoppingListCollectionViewController: UICollectionViewController {
    
    var shoppingListController = ShoppingListController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSendOrder" {
            guard let shoppingListDetailVC = segue.destination as?
                ShoppingListDetailViewController else { return }
            shoppingListDetailVC.shoppingListController = self.shoppingListController
        }
    }
    
    // MARK: UICollectionViewDataSource
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shoppingListController.shoppingItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ShoppingItemCollectionViewCell else {
            return UICollectionViewCell() }
        
        let ShoppingItem = self.shoppingListController.shoppingItems[indexPath.item]
        cell.shoppingItem = ShoppingItem
        //cell.nameLabel.text = ShoppingItem.name
        //cell.imageView.image = UIImage(named: ShoppingItem.name)
        //cell.hasBeenAddedLabel.text = ShoppingItem.hasBeenAdded ? "Added" : "Not Added"
        cell.delegate = self
        
        return cell
    }
}
            
    // MARK: UICollectionViewDelegate
extension ShoppingListCollectionViewController: ShoppingItemCollectionViewCellDelegate {
    func toggleHasBeenAdd(for cell: ShoppingItemCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
            
        let shoppingItem = self.shoppingListController.shoppingItems[indexPath.item]
        self.shoppingListController.updateHasBeenAdded(for: shoppingItem)
            
        collectionView.reloadData()
    }
}
