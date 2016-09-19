//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.
//
//

import UIKit

public class GTProgressBar: UIView {
    private let backgroundView = UIView()
    private let fillView = UIView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSubviews() {
        addSubview(backgroundView)
        addSubview(fillView)
    }
}
