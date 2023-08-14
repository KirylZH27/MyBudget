//
//  MainViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import Foundation
import Combine
import FirebaseAuth

final class MainViewModel: HideAuthorizationNavigationResponder, TransactionWasAddedNavigationResponder, SignOutNavigationResponder, ShowUserAditionalInfoNavigationResponder, HideUserAdditionalInfoNavigationResponder {
    
    private let userStore: UserStore
    private let darkModeGetter: DarkModeGetter
    private let transactionCategoryGetter: TransactionCategoryGetter
    private let transactionCategoryCreator: TransactionCategoryCreator
    
    private (set) var isPresentAuthorization = PassthroughSubject<Bool,Never>()
    private (set) var showTransactionWasAddedAnimation = PassthroughSubject<Bool, Never>()
    private (set) var isPresentUserAdditionalInfo = PassthroughSubject<Bool,Never>()
    
    init(userStore: UserStore, transactionCategoryGetter: TransactionCategoryGetter, transactionCategoryCreator: TransactionCategoryCreator) {
        self.userStore = userStore
        self.darkModeGetter = UserDefaultDarkModeStateDataSource()
        self.transactionCategoryGetter = transactionCategoryGetter
        self.transactionCategoryCreator = transactionCategoryCreator
        
        self.setDarkModeIfNeeded()
        self.createDefaultCategoriesIfNeeded()
    }
    
    func hideAuthorization() {
        isPresentAuthorization.send(false)
    }
    
    func showTransactionWasAddedNavigationResponder() {
        showTransactionWasAddedAnimation.send(true)
    }
    
    func checkAuthorization(){
        let user = Auth.auth().currentUser
        if let user = user{
            userStore.checkIfUserExist(by: user.uid) { userExist in
                if userExist {
                    self.isPresentAuthorization.send(false)
                } else {
                    self.isPresentUserAdditionalInfo.send(true)
                }
            }
        } else {
            isPresentAuthorization.send(true)
        }
    }
    
    func signOut() {
        isPresentAuthorization.send(true)
    }
    
    func hideUserAdditionalInfo() {
        isPresentUserAdditionalInfo.send(false)
    }
    
    func showUserAdditionalInfo() {
        isPresentUserAdditionalInfo.send(true)
    }
    
    private func setDarkModeIfNeeded(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            let state = self.darkModeGetter.getDarkModeState()
            let appDelegate = UIApplication.shared.windows.first
            appDelegate?.overrideUserInterfaceStyle = state ? .dark : .light
        }
    }
    
    private func createDefaultCategoriesIfNeeded(){
        transactionCategoryGetter.getAllCategories(type: nil) { transactionCategories in
            guard transactionCategories.isEmpty else { return }
            
            self.createDefaultIncomeCategories()
            self.createDefaultExpenditureCategories()
        }
    }
 
    private func createDefaultIncomeCategories(){
        guard let salaryImageData = UIImage(named: "salary")?.jpegData(compressionQuality: 0.8) else { return }
        let salaryCategory = TransactionCategory(id: UUID().uuidString,
                                                  name: "Зарплата",
                                                  imageData: salaryImageData,
                                                 type: .income)
        transactionCategoryCreator.createCategory(category: salaryCategory, completion: {_ in})
    }
    
    private func createDefaultExpenditureCategories(){
        guard let houseImageData = UIImage(named: "house")?.jpegData(compressionQuality: 0.8) else { return }
        let houseCategory = TransactionCategory(id: UUID().uuidString,
                                                  name: "Дом",
                                                  imageData: houseImageData,
                                                type: .expenditure)
        transactionCategoryCreator.createCategory(category: houseCategory, completion: {_ in})
    }
}
