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


enum AuthenticatedState: Hashable{
    case notAuthenticated
    case authenticated
}

struct UserSessionDetails {
    let firstName: String
    let lastName: String
    let occupation: String
    let gender: String
}

class AuthState: ObservableObject {
    @Published var value: AuthenticatedState = .notAuthenticated{
        didSet {
            if value == .authenticated{
                self.errorMessage = ""
            }
        }
    }
    @Published var service: AuthService = AuthService()
    @Published var account: Account?
    @Published var errorMessage = ""
    
    private var db = Firestore.firestore()
    private var subscriptions = Set<AnyCancellable>()
    private let auth = Auth.auth()
    
    init(){
        fetchUser()
    }
    
    func fetchUser(){
        auth
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                
                if let uid = currentUser?.uid {
                    let ref = self.db.collection("user").document(uid)
                    
                    
                    ref.getDocument { (document, error) in
                        if let document = document {
                            // Parse document as account value
                            let data = document.data()
                            if let data = data {
                                // Pass data account to published user details
                                self.account = Account(
                                    id: uid,
                                    email: data["email"] as? String ?? "",
                                    name: data["name"] as? String ?? "",
                                    profilePicture: data["profilePicture"] as? String ?? "",
                                    major: data["major"] as? String ?? "",
                                    darkModeSetting: data["darkModeSetting"] as? Bool ?? false,
                                    isMajorFilterSetting: data["isMajorFilterSetting"] as? Bool ?? false
                                )
                                self.value = .authenticated
                            }
                            
                        }
                        else if error != nil {
                            // The document was not found.
                            self.errorMessage = "Document was not found"
                        }
                    }
                }
            }
    }
    // Logout, call firebase auth to remove
    public func logout() {
        service.logout()
        value = .notAuthenticated
    }

    // Create user with email and password
    // If successful then store the uid to the firestore
    public func signUp(email: String, password: String){
        service
            .register(email: email, password: password)
            .sink { [weak self] res in
                // Receive promise from service and return status
                switch res {
                    case .failure(_):
                        self?.errorMessage = "Failed to create user! Email already exist"
                    default: break
                }
            } receiveValue: { [weak self] in
                // Success message then will direct to home page
                self?.value = .authenticated
            }
            .store(in: &subscriptions)
    }
    
    // Sign in function
    public func signIn(email: String, password: String){
        service
            .login(email: email, password: password)
            .sink { res in
                // Receive promise from service and return status
                switch res {
                    case .failure(_):
                        self.errorMessage = "Authenticate fail!! Wrong email or password"
                    default: break
                }
            } receiveValue: { [weak self] in
                // Success message then will direct to home page
                self?.value = .authenticated
            }
            .store(in: &subscriptions)
    }
    
    // Update data on Firebase
    public func setAccountData(name: String, profilePicture: String, major: String){
        let data:[String:AnyObject] = [
            "name": name as AnyObject,
            "profilePicture": profilePicture as AnyObject,
            "major": major as AnyObject
        ]
        self.updateAccountDataFirebase(data: data)
    }
    
    // Toggle darkMode
    public func setDarkModeSetting(darkModeSetting: Bool){
        let data:[String:AnyObject] = [
            "darkModeSetting": darkModeSetting as AnyObject
        ]
        self.updateAccountDataFirebase(data: data)
    }
    
    // Async data settings
    public func setisMajorFilterSetting(){
        let isMajorFilteringSetting = !account!.isMajorFilterSetting
        let data:[String:AnyObject] = [
            "isMajorFilterSetting": isMajorFilteringSetting as AnyObject
        ]
        self.updateAccountDataFirebase(data: data)
    }
    
    private func updateAccountDataFirebase(data: [String:AnyObject]){
        var userData = [
            "email": account?.email as Any,
            "name": account?.name as Any,
            "profilePicture":  account?.profilePicture as Any,
            "major": account?.major as Any,
            "darkModeSetting": account?.darkModeSetting as Any,
            "isMajorFilterSetting": account?.isMajorFilterSetting as Any
        ] as [String : Any]
        
        for (key,value) in data {
            userData[key] = value
        }
        
        // Find user id
        if let uid = auth.currentUser?.uid {
            let ref = self.db.collection("user").document(uid)
            // Update data with document with user id
            ref.setData(
                data
            ){ err in
                if err != nil {
                    // Return error true to log error
                    self.errorMessage = "Cannot save user data"
                } else {
                    self.account?.setAttribute(data: data)
                }
            }
        }
        else {
            // Not find the user then return error to true to log error
            self.errorMessage = "Token has expired, please refresh"
        }
    }
    
    // ----------- FAKE DATA TO FIREBASE HELPER --------------------//
    public func create_fake_accounts(){
        // Create fake account
        for index in 1...15{
            self.signUp(email: "user_\(index)@example.com", password: "123456")
        }
    }
    
    public func create_fake_events(){
        // Fetch all accounts and add events to the account
        db.collectionGroup("user").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }

            if let snapshot = snapshot {
                let eventVM = EventFormViewModel(event: nil)
                for document in snapshot.documents {
                    eventVM.addFakeDataToFirestore(uid: document.documentID)
                }
          }
        }
    }
    
    public func accounts_join_events(){
        // Fetch all accounts and add events to the account
        db.collectionGroup("user").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }

            if let snapshot = snapshot {
                let eventVM = EventFormViewModel(event: nil)
                
                for document in snapshot.documents {
                    eventVM.addEventToJoinEventsWithUid(uid: document.documentID)
                }
          }
        }
    }
}
