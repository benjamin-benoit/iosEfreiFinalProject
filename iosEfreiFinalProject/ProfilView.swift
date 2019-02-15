//
//  ProfilView.swift
//  iosEfreiFinalProject
//
//  Created by Benjamin BENOIT on 14/02/2019.
//  Copyright © 2019 Benjamin BENOIT. All rights reserved.
//

import UIKit

class ProfilView: UIView {
    
    var delegate : ProfilViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    @IBOutlet weak var messageError: UILabel!
    @IBOutlet weak var constraintWithError: NSLayoutConstraint!
    @IBOutlet weak var constraintWithoutError: NSLayoutConstraint!
    
    @IBAction func changePasswordAction() {
        delegate?.changePasswordAction()
    }
    
    @IBAction func logoutAction() {
        delegate?.logoutAction()
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
        Bundle.main.loadNibNamed("ProfilView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
