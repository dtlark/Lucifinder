//
//  ItemSelectionViewController.swift
//  Lucifinder
//
//  Created by Alexandra Spector on 10/18/20.
//

import UIKit
import AVFoundation

protocol ItemSelectionViewControllerDelegate: class {
    func itemSelectionViewController(_itemSelectionViewController: ItemSelectionViewController, didFinishSelectingItems selectedItems: [AVSemanticSegmentationMatte.MatteType])
}

class ItemSelectionViewController: UITableViewController {
    weak var delegate: ItemSelectionViewControllerDelegate?
    
    let identifier: String
    
    let allItems: [AVSemanticSegmentationMatte.MatteType]
    
    var selectedItems: [AVSemanticSegmentationMatte.MatteType]
    
    let allowsMultipleSelection: Bool
    
    private let itemCallIdentifier = "Item"
    
    init(delegate: ItemSelectionViewControllerDelegate,
         identifier: String,
         allItems: [AVSemanticSegmentationMatte.MatteType],
         selectedItems: [AVSemanticSegmentationMatte.MatteType],
         allowsMultipleSelection: Bool) {
        
        self.delegate = delegate
        self.identifier = identifier
        self.allItems = allItems
        self.selectedItems = selectedItems
        self.allowsMultipleSelection = allowsMultipleSelection
        
        super.init(style: grouped)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystem:.done, target: self, action: #selector(done))
        tableView.register(UITableViewCell.self, for CellReuseIdentifier: itemCellIdentifier)
        
        
    }
}
