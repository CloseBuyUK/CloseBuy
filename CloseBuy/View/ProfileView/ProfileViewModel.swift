
import SwiftUI
import FirebaseFirestore

extension ProfileView {
    class ViewModel: ObservableObject {
        
        @Published var user: User?
        
        let userId: String
        
        @Published var isFollowing: Bool = false
        
        init(id: String){
            self.userId = id
            fetchUser()
            isUserFollowing()
        }
        
        func unFollow() {
            UserService.unfollow(userId: userId) { _ in
                withAnimation {
                    self.isFollowing = false
                }
            }
        }
        
        func follow() {
            UserService.follow(userId: userId) { _ in
                withAnimation {
                    self.isFollowing = true
                }
            }
        }
        
        func fetchUser(){
            UserService.fetchUser(userId: userId) { user in
                self.user = user
            }
        }
        
        func isUserFollowing(){
            UserService.isUserFollowing(userId: userId) { response in
                withAnimation {
                    self.isFollowing = response
                }
            }
        }
        
        var isCurrentUser: Bool {
            return AuthViewModel.shared.currentUser?.id == userId
        }
        
    }
}
