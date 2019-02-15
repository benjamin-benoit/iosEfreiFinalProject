//
//  ViewController.swift
//  iosEfreiFinalProject
//
//  Created by Benjamin BENOIT on 14/02/2019.
//  Copyright © 2019 Benjamin BENOIT. All rights reserved.
//

import UIKit

//protocol SignUvar
//    func signUpAction()
//    func goToLoginAction()
//}
//
//protocol SignIn {
//    func loginAction()
//    func registerAction()
//}
//
//protocol Profil {
//    func changePasswordAction()
//    func logoutAction()
//}

class LoginViewController: UIViewController, SignUpViewDelegate, SignInViewDelegate, ProfilViewDelegate {
    
    @IBOutlet var signUpView: SignUpView!
    @IBOutlet var signInView: SignInView!
    @IBOutlet var profilView: ProfilView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.isHidden = false
        signInView.isHidden = true
        profilView.isHidden = true
        
        signUpView.delegate = self
        signInView.delegate = self
        profilView.delegate = self
    }
    
    func signUpAction() {
        if ((signUpView.email.text?.isEmpty ?? true) || (signUpView.password.text?.isEmpty ?? true) || (signUpView.confirmPassword.text?.isEmpty ?? true)) {
            signUpError(err: true)
            signUpView.messageError.text = "Some fields are empty"
        } else if (!isValidPassword(passw: signUpView.password.text ?? "") || !isValidPassword(passw: signUpView.password.text ?? "")) {
            signUpError(err: true)
            signUpView.messageError.text = "You need more than 8 characters for passwords"
        } else if (signUpView.password.text != signUpView.confirmPassword.text) {
            signUpError(err: true)
            signUpView.messageError.text = "Passwords are note the same"
        } else if (!isValidEmail(email: signUpView.email.text ?? "")){
            signUpError(err: true)
            signUpView.messageError.text = "Email is not valid"
        } else {
            signUpError()
            
            let user: User = User.init(email: signUpView.email.text ?? "", password: signUpView.password.text ?? "")
            
            RegisterUser.register(user: user)
            print("Successful sign up")
            
            changeView(signIn: false)
        }
    }
    
    func goToLoginAction() {
        changeView(signIn : false)
    }
    
    func loginAction() {
        if (RegisterUser.user == nil) {
            signInError(err: true)
            signInView.messageError.text = "Please register first"
        } else if ((signInView.email.text?.isEmpty ?? true) || (signInView.password.text?.isEmpty ?? true)) {
            signInError(err: true)
            signInView.messageError.text = "Some fields are empty"
        } else if (signInView.email.text == RegisterUser.user?.userEmail && signInView.password.text == RegisterUser.user?.userPassword){
            print("Successful login")
            
            if ((RegisterUser.user) != nil) {
                profilView.email.text = "Email: " + (RegisterUser.user?.userEmail ?? "")
            }
            
            changeView(profil: false)
        } else {
            signInError(err: true)
            signInView.messageError.text = "Unable to find a match with this pair of email / password"
        }
    }
    
    func registerAction() {
        changeView(signUp: false)
    }
    
    func changePasswordAction() {
        if((profilView.newPassword.text?.isEmpty ?? true) || (profilView.confirmNewPassword.text?.isEmpty ?? true)) {
            profilError(err: true)
            profilView.messageError.textColor = UIColor.red
            profilView.messageError.text = "Some fields are empty"
        } else if (profilView.newPassword.text != profilView.confirmNewPassword.text) {
            profilError(err: true)
            profilView.messageError.textColor = UIColor.red
            profilView.messageError.text = "Passwords are not matching"
        } else {
            profilError(err: true)
            RegisterUser.user?.userPassword = profilView.newPassword.text ?? ""
            profilView.messageError.textColor = UIColor.green
            profilView.messageError.text = "Password change is a success"
            profilView.newPassword.text = ""
            profilView.confirmNewPassword.text = ""
        }
    }
    
    func logoutAction() {
        changeView(signIn: false)
    }
    
    func changeView (signUp: Bool = true, signIn: Bool = true, profil: Bool = true) {
        signUpView.isHidden = signUp
        signUpError()
        signInView.isHidden = signIn
        signInError()
        profilView.isHidden = profil
        profilError()
        if (signUp == true) {
            signUpView.email.text = ""
            signUpView.password.text = ""
            signUpView.confirmPassword.text = ""
        }
        if (signIn == true) {
            signInView.email.text = ""
            signInView.password.text = ""
        }
        if (profil == true) {
            profilView.newPassword.text = ""
            profilView.confirmNewPassword.text = ""
        }
    }
    
    func signUpError(err: Bool = false) {
        if (err == true) {
            signUpView.messageError.isHidden = false
            signUpView.constraintWithError.priority = UILayoutPriority(rawValue: 999)
            signUpView.constraintWithoutError.priority = UILayoutPriority(rawValue: 995)
        } else {
            signUpView.messageError.isHidden = true
            signUpView.constraintWithError.priority = UILayoutPriority(rawValue: 995)
            signUpView.constraintWithoutError.priority = UILayoutPriority(rawValue: 999)
        }
    }
    
    func signInError(err: Bool = false) {
        if (err == true) {
            signInView.messageError.isHidden = false
            signInView.constraintWithError.priority = UILayoutPriority(rawValue: 999)
            signInView.constraintWithoutError.priority = UILayoutPriority(rawValue: 995)
        } else {
            signInView.messageError.isHidden = true
            signInView.constraintWithError.priority = UILayoutPriority(rawValue: 995)
            signInView.constraintWithoutError.priority = UILayoutPriority(rawValue: 999)
        }
    }
    
    func profilError(err: Bool = false) {
        if (err == true) {
            profilView.messageError.isHidden = false
            profilView.constraintWithError.priority = UILayoutPriority(rawValue: 999)
            profilView.constraintWithoutError.priority = UILayoutPriority(rawValue: 995)
        } else {
            profilView.messageError.isHidden = true
            profilView.constraintWithError.priority = UILayoutPriority(rawValue: 995)
            profilView.constraintWithoutError.priority = UILayoutPriority(rawValue: 999)
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        if (email.count < 7) {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(passw:String) -> Bool {
        let bool = passw.count < 8 ? false : true
        return bool
    }
}

