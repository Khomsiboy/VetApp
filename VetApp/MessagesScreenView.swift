//
//  MessagesScreenView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-01.
//

import SwiftUI
import FirebaseAuth

struct MessagesScreenView: View {
    
    let chatroom : ChatRoom
    @ObservedObject var messages = MessageViewModel()
    @State var messagesValue = ""
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker : Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    
    init(chatroom : ChatRoom) {
        self.chatroom = chatroom
        messages.getMessages(docId: chatroom.id)
    }
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack{
                    ForEach(messages.messages){ message in
                        
                        Chatcell(userText: message.content, UserEmail: message.name)
                        
                    }
                    
                }
            }).padding(.horizontal,15)
            
            HStack{
               
                HStack(spacing:40){
                    
                    TextField("Enter Message...", text : $messagesValue)
                        .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    Button(action: {
                        self.showSheet = true
                    }, label: {
                        Image(systemName: "paperclip.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("ChatIcon"))
                    }).offset(x: 8.0, y: 0)
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"),
                                  message : Text("Choose"), buttons: [
                                    
                                    .default(Text("Photo Library")){
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                    },
                                    .default(Text("Camera")){
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    },
                                    .cancel()
                                    
                                    
                                 ]
                         )
                    }
                    
                }
                .padding(.horizontal,15)
                .background(Color("ChatColor"))
                .clipShape(Capsule())
                .padding(.leading,20)
                .padding(.bottom,15)
               
                
                Spacer()
                Button(action: {
                    
                    if messagesValue != ""{
                        messages.sendMessage(messageContent: messagesValue, docId: chatroom.id)
                        messagesValue = ""
                        print("Messages Send")
                    }
                    if self.image != nil{
                        messages.sendPhoto(uiImage: image!, docId: chatroom.id)
                        print("Photo Send")
                        self.image = nil
                    }
                    
                }, label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color("Color1"))
                            .clipShape(Circle())
                           
                }).padding(.trailing,20)
                .padding(.bottom,15)
                .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                        .ignoresSafeArea()
                    
                
               
            }
           
            
        }
        .navigationBarTitle(chatroom.title)
    }
}

struct MessagesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesScreenView(chatroom: ChatRoom(id: "101", title: "Test", joinCode: 123))
    }
}


struct Chatcell: View {
    
     @ObservedObject var messages = MessageViewModel()
     private let user = Auth.auth().currentUser
     var userText: String
     var UserEmail: String
    
    var body: some View{
        
       // om image is not nil 
        
        HStack{
            if UserEmail == user!.email {
                Spacer()
                Text(userText) // check if it text or image, if image show image or text
                    .padding()
                    .background(Color("Color1"))
                    .clipShape(MessageShape(user: true))
                    .foregroundColor(.white)
                
               
                        
            }else{
                Text(userText)
                    .padding()
                    .background(Color("ChatColor"))
                    .clipShape(MessageShape(user: false))
                    .foregroundColor(.white)
                
                Spacer()
            }
           
            
            
        }.padding(UserEmail == user!.email ? .leading : .trailing, 100)
        .padding(.vertical,2)
        
        
        
    }
}

struct MessageShape : Shape {
    
    var user : Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,user ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
    
}

//struct ImagePicker : UIViewControllerRepresentable {
//
//
//    @Binding var imagePicker : Bool
//    @Binding var imgData : Data
//
//    func makeCoordinator() -> Coordinator {
//        return ImagePicker.Coordinator(parent1: self)
//    }
//
//
//
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//         let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//
//    }
//
//    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
////        var parent : ImagePicker
////
////        init(parent1 : ImagePicker) {
////            parent = parent1
////        }
//
////        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////            parent.imagePicker.toggle()
////        }
////
////        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////            let image = info[.originalImage] as! UIImage
////            parent.imgData = image.jpegData(compressionQuality: 0.5)
////            parent.imagePicker.toggle()
////        }
////    }
//
//    }
//}
}
