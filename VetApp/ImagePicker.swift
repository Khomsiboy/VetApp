//
//  ImagePicker.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-26.
//



import Foundation
import SwiftUI
import FirebaseStorage
import Firebase
import FirebaseFirestore


class ImagePickerCoordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @Binding var image : UIImage?
    @Binding var isShown : Bool

    @ObservedObject var chatroomModel = ChatRoomViewModel()
    private let user = Auth.auth().currentUser
    private let db = Firestore.firestore()
    
    
    init(image : Binding<UIImage?>, isShown : Binding<Bool>) {
        _image = image
        _isShown = isShown
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = uiImage
            isShown = false
            
            let imageName = UUID().uuidString

            let storage = Storage.storage().reference().child(imageName)

            storage.putData((image?.jpegData(compressionQuality: 0.35))!, metadata: nil){
                (_,err) in

                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }

                print("Success")

                storage.downloadURL { [self] (url, err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                    }

                    guard let url = url else{
                        print((err?.localizedDescription)!)
                        return
                    }

                    if self.user != nil{
                        let dataRef =  
                            db.collection("chatrooms").document("").collection("messages").addDocument(data: [
                            "sentAt" : Date(),
                            "displayName" : self.user!.email,
                            "content" : url.absoluteString,
                            "sender" : self.user!.uid
                        ])
                    }

                }
            }
                
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }

  }
    
}

}

struct ImagePicker : UIViewControllerRepresentable {
   
    
    typealias UIViewControllerType = UIImagePickerController
    // declare Coordinator
    
    typealias Coordinator = ImagePickerCoordinator

    @Binding var image: UIImage?
    @Binding var isShown : Bool
    
    var sourceType : UIImagePickerController.SourceType = .camera

    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:  UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown : $isShown)
    }
    
    
    
}
     
