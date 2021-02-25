//
//  NewCases.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-18.
//

import SwiftUI
import UIKit
import PhotosUI

struct NewCases: View {
    
    @State var text : String = ""
    @State var newTilte = "Elias Kyviat"
    @Binding var isOpen : Bool
    @ObservedObject var chatroomModel = ChatRoomViewModel()
    var body: some View {
        
        ZStack{
           
            VStack{
                Text("Skapa ärende")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,40)
                
                HStack {
                    MultiTextField(text: $text).padding().background(Color.white).cornerRadius(30)
                        .frame(width: 350, height: 150, alignment: .center)
                        .shadow(radius: 8)
                    
                }.padding()
               
                Photos().padding(.top,60)
                Doctor().padding(.top,30)
                Button(action: {
                    chatroomModel.createChatRoom(title: newTilte, handler: {
                        self.isOpen = false
                    })
                }, label: {
                    Text("Boka")
                }).frame(width: 250, height: 60, alignment: .center)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top,50)
                
            }
        }
    }
}

struct Doctor : View {
    
    
    let doctor = ["doctor_profile_image","doctor-img-01-free-img"]
    let doctorName = ["Amanda Nilsson","Lars Sten"]
    
    var body: some View{
        VStack(spacing: 15){
            ForEach(0..<2){ i in
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .frame(width: 350, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .shadow(radius: 8)
                    HStack{
                        Image("\(doctor[i])")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            Spacer()
                        VStack(alignment: .leading, spacing: 5, content: {
                            Text("\(doctorName[i])")
                                .font(.system(size: 18))
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Nästa ledigt tid 8:00")
                                .font(.system(size: 15))
                            
                        }).padding(.trailing,100)
                    }.padding(.horizontal,50)
                    
                }
            }
        }
    }
}

struct Photos: View {
    @State var images : [UIImage] = []
    @State var picker = false
    
    
    var body: some View{
        VStack{
            if !images.isEmpty{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15){
                        ForEach(images,id: \.self){ img in
                            Image(uiImage: img)
                                .resizable()
                            frame(width: UIScreen.main.bounds.width - 45, height: 100)
                                .cornerRadius(20)
                        }
                    }
                })
            }else{
                Button(action: {
                    picker.toggle()
                }, label: {
                    Text("Select images")
                })
                .foregroundColor(.white)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color.green)
                .clipShape(Capsule())
            }
        }.sheet(isPresented: $picker, content: {
            ImagePicker(images: $images, picker: $picker)
        })
        
        
    }
}


struct ImagePicker : UIViewControllerRepresentable {

    
    @Binding var images : [UIImage]
    @Binding var picker : Bool
    
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
         
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator : NSObject,PHPickerViewControllerDelegate{
        
        var parent : ImagePicker
        
        init(parent1 : ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking result: [PHPickerResult]){
            
            parent.picker.toggle()
            
            for img in result{
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    img.itemProvider.loadObject(ofClass: UIImage.self){ (Image, err) in
                        
                        guard let image1 = Image else{
                            print(err)
                            return
                        }
                        
                        self.parent.images.append(image1 as! UIImage)
                        
                    }
                    
                    
                }else{
                    //Connot load
                    print("Cant Load Images")
                }
            }
        }
        
    }
    
}

struct NewCases_Previews: PreviewProvider {
    static var previews: some View {
        NewCases(isOpen: .constant(true))
    }
}

struct MultiTextField : UIViewRepresentable {
    
    @Binding var text : String
    
    func makeCoordinator() -> Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        
        let view = UITextView()
        view.font = .systemFont(ofSize: 19)
        view.text = "What happened?"
        view.textColor = UIColor.black.withAlphaComponent(0.35)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>){
        
    }
    
    
    class Coordinator: NSObject,UITextViewDelegate {
        
        
        var parent : MultiTextField
        
        init(parent1 : MultiTextField) {
            parent = parent1
        }
        
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .label
        }
        
    }
}
