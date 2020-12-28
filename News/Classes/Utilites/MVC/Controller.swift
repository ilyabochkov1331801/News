//
//  Controller.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit

open class Controller<ContentView: View>: UIViewController {
    var contentView: ContentView {
        guard let view = view as? ContentView else {
            fatalError("View in \(Controller.self)  isn't \(ContentView.self)")
        }
        return view
    }
    
    open override func loadView() {
        view = ContentView()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    open func setupSubviews() { }
}
