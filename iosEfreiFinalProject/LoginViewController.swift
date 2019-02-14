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
        if (!isValidEmail(email: signUpView.email.text ?? "")){
            print("email non valide")
        } else if ((!(signUpView.email.text?.isEmpty ?? true) && !(signUpView.password.text?.isEmpty ?? true) && !(signUpView.confirmPassword.text?.isEmpty ?? true)) && signUpView.password.text == signUpView.confirmPassword.text){
            var user: User = User.init(email: signUpView.email.text ?? "", password: signUpView.password.text ?? "")
            
            RegisterUser.register(user: user)
            
            print("Successful sign up")
            
            signUpView.isHidden = true
            signInView.isHidden = false
            profilView.isHidden = true
        }
    }
    
    func goToLoginAction() {
        print("goToLoginAction")
        signUpView.isHidden = true
        signInView.isHidden = false
        profilView.isHidden = true
    }
    
    func loginAction() {
        if (RegisterUser.user == nil) {
            print("Please register first")
        } else if ((!(signInView.email.text?.isEmpty ?? true) && !	(signInView.password.text?.isEmpty ?? true)) && (signInView.email.text == RegisterUser.user?.userEmail && signInView.password.text == RegisterUser.user?.userPassword)){
            print("Successful login")
            
            if ((RegisterUser.user) != nil) {
                profilView.email.text = "Email: " + (RegisterUser.user?.userEmail ?? "")
            }
            
            signUpView.isHidden = true
            signInView.isHidden = true
            profilView.isHidden = false
        } else {
            print("Unable to find a match with this pair of email / password")
        }
    }
    
    func registerAction() {
        print("registerAction")
        signUpView.isHidden = false
        signInView.isHidden = true
        profilView.isHidden = true
    }
    
    func changePasswordAction() {
        if(!(profilView.newPassword.text?.isEmpty ?? true) || !(profilView.confirmNewPassword.text?.isEmpty ?? true)) {
            RegisterUser.user?.userPassword = profilView.newPassword.text ?? ""
            print("Password change is a success")
        } else {
            print("Passwords are not matching")
        }
    }
    
    func logoutAction() {
        signUpView.isHidden = true
        signInView.isHidden = false
        profilView.isHidden = true
    }
    
    //fonctions
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

