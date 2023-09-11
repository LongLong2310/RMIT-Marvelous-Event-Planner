/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 12/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://docs.google.com/presentation/d/1-QV6pqZBkdGgKGImB7t0izYk0OqzFdrf/edit#slide=id.g25839ad1222_0_435
    https://www.youtube.com/watch?v=XsDtO7lpeO0&t=1438s
    https://www.youtube.com/watch?v=5gIuYHn9nOc
    https://stackoverflow.com/questions/62748666/why-does-swiftui-display-an-error-when-i-attempt-to-retrieve-database-info-from
*/


import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine


enum AuthenticatedState{
    case notAuthenticated
    case authenticated
    case failed(error: Error)
}

struct UserSessionDetails {
    let firstName: String
    let lastName: String
    let occupation: String
    let gender: String
}

class AuthState: ObservableObject {
    @Published var value: AuthenticatedState = .notAuthenticated
    @Published var service: AuthService = AuthService()
    @Published var userDetails: Account?
    
    private var db = Firestore.firestore()
    private var subscriptions = Set<AnyCancellable>()
    
    init(){
        Auth
            .auth()
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                self.value = currentUser == nil ? .notAuthenticated : .authenticated
                
                if let uid = currentUser?.uid {
                    let ref = self.db.collection("users").document(uid)
                    
                    
                    ref.getDocument { (document, error) in
                        if let document = document {
                            // Parse document as account value
                            let data = document.data()
                            if let data = data {
                                // Pass data account to published user details
                                self.userDetails = Account(
                                    id: uid,
                                    email: data["email"] as? String ?? "",
                                    name: data["name"] as? String ?? "",
                                    profilePicture: data["profilePicture"] as? String ?? "",
                                    major: data["major"] as? String ?? "")
                                
                                self.value = .authenticated
                            }
                            
                        }
                        else if let error = error {
                            // The document was not found.
                            self.value = .failed(error: error)
                        }
                    }
                }
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }

    func signUp(email: String, password: String){
        service
            .register(email: email, password: password)
            .sink { [weak self] res in
            
                switch res {
                    case .failure(let error):
                        self?.value = .failed(error: error)
                    default: break
                }
            } receiveValue: { [weak self] in
                self?.value = .authenticated
            }
            .store(in: &subscriptions)
    }
    
    func signIn(email: String, password: String){
        service
            .login(email: email, password: password)
            .sink { res in
                switch res {
                    case .failure(let err):
                        self.value = .failed(error: err)
                    default: break
                }
            } receiveValue: { [weak self] in
                self?.value = .authenticated
            }
            .store(in: &subscriptions)
    }
}
