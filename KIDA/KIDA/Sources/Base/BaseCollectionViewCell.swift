//
//  BaseCollectionViewCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/24.
//
import UIKit

class BaseCollectionViewCell<R: Reactor>: UICollectionViewCell, ReactorKit.View {
    
    typealias Reactor = R
    
    var disposeBag = DisposeBag()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(reactor: R) { }
}

