//
//  CZCollectionViewLeftAlignedLayout.swift
//  LeftAlignedSwift
//
//  Created by ChenZuo on 2017/2/5.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

protocol CZCollectionViewDelegateLeftAlignedLayout : UICollectionViewDelegateFlowLayout{
    
}

extension UICollectionViewLayoutAttributes {
    func leftAlignFrameWithSectionInset(sectionInset : UIEdgeInsets) -> (){
        var frame:CGRect = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class CZCollectionViewLeftAlignedLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesToReturn = super.layoutAttributesForElements(in: rect)
        
        guard attributesToReturn != nil else{
            return attributesToReturn;
        }
        
        for attributes in attributesToReturn! {
            if attributes.representedElementKind == nil {
                let indexPath = attributes.indexPath;
                attributes.frame = self.layoutAttributesForItem(at: indexPath).frame
            }
        }
        return attributesToReturn;
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)
        let sectionInset = self.evaluatedSectionInsetForItemAtIndex(index: indexPath.section)
        let isFirstItemInSection = (indexPath.item == 0)
        let layoutWidth = (self.collectionView?.frame.width)! - sectionInset.left - sectionInset.right
        if isFirstItemInSection {
            currentItemAttributes?.leftAlignFrameWithSectionInset(sectionInset: sectionInset)
            return currentItemAttributes!
        }
        
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = self.layoutAttributesForItem(at: previousIndexPath).frame
        
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width
        let currentFrame = currentItemAttributes?.frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left,
                                           y: currentFrame!.origin.y,
                                           width: layoutWidth,
                                           height: currentFrame!.size.height)
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
        if isFirstItemInRow {
            currentItemAttributes?.leftAlignFrameWithSectionInset(sectionInset: sectionInset)
            return currentItemAttributes!
        }
        
        var frame = currentItemAttributes!.frame
        frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex: indexPath.section)
        currentItemAttributes!.frame = frame
        return currentItemAttributes!
    }
    
    func evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex:Int) -> CGFloat {
        let selector = #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))
        let respond = self.collectionView?.delegate?.responds(to: selector)
        if (respond)! {
            let delegate = self.collectionView?.delegate as! CZCollectionViewDelegateLeftAlignedLayout
            return delegate.collectionView!(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex)
        }else{
            return self.minimumInteritemSpacing
        }
    }
    
    func evaluatedSectionInsetForItemAtIndex(index:Int) -> UIEdgeInsets {
        let selector = #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))
        let respond = self.collectionView?.delegate?.responds(to: selector)
        if (respond)! {
            let delegate = self.collectionView?.delegate as! CZCollectionViewDelegateLeftAlignedLayout
            return delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAt: index)
        }else{
            return self.sectionInset
        }
    }
}
