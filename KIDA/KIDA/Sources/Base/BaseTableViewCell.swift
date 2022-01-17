//
//  BaseTableViewCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit

class BaseTableViewCell<R: Reactor>: UITableViewCell, ReactorKit.View {
    typealias Reactor = R
    
    var disposeBag = DisposeBag()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(reactor: R) {
        
    }
}
