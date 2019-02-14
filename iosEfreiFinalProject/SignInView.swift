//
//  SignInView.swift
//  iosEfreiFinalProject
//
//  Created by Benjamin BENOIT on 14/02/2019.
//  Copyright © 2019 Benjamin BENOIT. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
    var delegate : SignInViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction() {
        delegate?.loginAction()
    }
    
    @IBAction func registerAction() {
        delegate?.registerAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SignInView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
