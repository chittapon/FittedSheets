//
//  TouchThroughSheetViewController.swift
//  FittedSheetsPod
//
//  Created by Chittapon Thongchim on 14/10/2562 BE.
//  Copyright © 2562 Gordon Tucker. All rights reserved.
//

import UIKit

public class TouchThroughSheetViewController: SheetViewController {
    
    weak var baseViewController: UIViewController?
    lazy var touchView = TouchThroughView(baseView: baseViewController?.view)
    open var touchThroughEnable: Bool = false {
        didSet {
            touchView.touchThroughEnable = touchThroughEnable
        }
    }
    
    public convenience init(baseViewController: UIViewController?, controller: UIViewController, sizes: [SheetSize] = []) {
        self.init(nibName: nil, bundle: nil)
        self.baseViewController = baseViewController
        self.childViewController = controller
        if sizes.count > 0 {
            self.setSizes(sizes, animated: false)
        }
        self.modalPresentationStyle = .overFullScreen
    }
    
    public override func loadView() {
        super.loadView()
        view = touchView
    }
    

}

class TouchThroughView: UIView {
    
    weak var baseView: UIView?
    var touchThroughEnable = false
    
    init(baseView: UIView?) {
        super.init(frame: UIScreen.main.bounds)
        self.baseView = baseView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        if touchThroughEnable {
            
            if super.hitTest(point, with: event)?.accessibilityLabel == "Pull bar" {
                return self
            }
            
            guard let point = baseView?.convert(point, from: self) else {
                return self
            }
            
            return baseView?.hitTest(point, with: event)
            
        }else {
            
            return super.hitTest(point, with: event)
            
        }
        
    }
}
