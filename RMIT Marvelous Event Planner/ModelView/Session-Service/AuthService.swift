/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 8/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://docs.google.com/presentation/d/1-QV6pqZBkdGgKGImB7t0izYk0OqzFdrf/edit#slide=id.g25839ad1222_0_435
    https://www.youtube.com/watch?v=XsDtO7lpeO0&t=1438s
    https://www.youtube.com/watch?v=5gIuYHn9nOc
*/


import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine


class AuthService {
    var db = Firestore.firestore()
    
    func register(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                
                Auth.auth().createUser(withEmail: email,
                                       password: password) { res, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            // Create new document in users collection, and put the uid as id document
                            let ref = self.db.collection("user").document(uid)
                            ref.setData(
                                [
                                    "email": email,
                                    "name": "",
                                    "profilePicture": "",
                                    "major": ""
                                ]
                            ){ err in
                                if let err = err {
                                    promise(.failure(err))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void, Error> {
            
            Deferred {
                
                Future { promise in
                    
                    Auth
                        .auth()
                        .signIn(withEmail: email,
                                password: password) { res, error in
                            
                            if let err = error {
                                promise(.failure(err))
                            } else {
                                promise(.success(()))
                            }
                        }
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
}

