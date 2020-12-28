//
//  View.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit

open class View: UIView {
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        
        arrangeView()
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func arrangeView() { }
    
    open func setupView() { }
}
