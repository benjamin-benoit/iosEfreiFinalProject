//
//  SignUpView.swift
//  iosEfreiFinalProject
//
//  Created by Benjamin BENOIT on 14/02/2019.
//  Copyright © 2019 Benjamin BENOIT. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    var delegate : SignUpViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var messageError: UILabel!
    @IBOutlet weak var constraintWithError: NSLayoutConstraint!
    @IBOutlet weak var constraintWithoutError: NSLayoutConstraint!
    
    @IBAction func signUpAction() {
        delegate?.signUpAction()
    }

    @IBAction func goToLoginAction() {
        delegate?.goToLoginAction()
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
        Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
