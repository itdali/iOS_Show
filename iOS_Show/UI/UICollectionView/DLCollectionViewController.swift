//
//  DLCollectionViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/18.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DLCollectionViewCellDelegate {
    
    var collectionView: UICollectionView!
    let cellID = "collectionCellID"
    let headerID = "headerID"
    let footerID = "footerID"
    
    let nomalColor = UIColor.orange
    let selectedColor = UIColor.red
    let headerColor = UIColor.magenta
    let footerColor = UIColor.green
    let cellWidth: CGFloat = 80
    let cellHeight: CGFloat = 100
    var enableCellEdit: Bool = false
    
    var dataArray: NSMutableArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllUI()
    }
    
    func addAllUI () {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: 100, height: 200)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        //collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "DLCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID)
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        self.view.addSubview(collectionView)
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(DLCollectionViewController.editButtonClick(_:)))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DLCollectionViewController.addButtonClick))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]
    }
    
    func addButtonClick() {
        collectionView.performBatchUpdates({ () -> Void in
            let newObject = Int(self.dataArray.lastObject as! String)! + 1
            self.dataArray.add(String(newObject))
            let indexPath = IndexPath(item: self.dataArray.count-1, section: 0)
            self.collectionView.insertItems(at: [indexPath])
            }, completion: nil)
    }
    
    //MARK: Collection View Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DLCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DLCollectionViewCell
        cell.delegate = self
        cell.backgroundColor = nomalColor
        cell.titleLabel.text = dataArray[(indexPath as NSIndexPath).item] as? String
        cell.enableEdit = enableCellEdit
        cell.indexPath = indexPath
        return cell
    }

    //MARK: Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // print(kind)
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
            headerView.backgroundColor = headerColor
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
            footerView.backgroundColor = footerColor
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataArray.exchangeObject(at: (sourceIndexPath as NSIndexPath).row, withObjectAt: (destinationIndexPath as NSIndexPath).row)
    }
    // 开启/关闭Edit状态
    func editButtonClick(_ buttonItem: UIBarButtonItem) {
        enableCellEdit = !enableCellEdit
        buttonItem.title = (enableCellEdit ? "Done" : "Edit")
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = selectedColor
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = nomalColor
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLprint("[\((indexPath as NSIndexPath).section), \((indexPath as NSIndexPath).row)]")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = selectedColor
        
        DLprint(collectionView.indexPathsForSelectedItems)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = nomalColor
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        DLprint(action.description)
        return true
    }
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        DLprint("")
    }
    
    
    //MARK: Collection View Flow Layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 20)
    }
    
    // Cell外边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // 左右item最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 上下两行item最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //MARK: Collection View Cell Deleggate
    func collectionViewCell(collectionViewCell cell: UICollectionViewCell, deleteButton button: UIButton, atIndexPath indexPath: IndexPath) {
        DLprint(indexPath)
        dataArray.removeObject(at: (indexPath as NSIndexPath).item)
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
