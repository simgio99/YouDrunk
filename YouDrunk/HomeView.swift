//
//  HomeView.swift
//  YouDrunk
//
//  Created by Simone Giordano on 13/11/21.
//

import SwiftUI

struct DrinkButton: View {
    var image_name: String!
    var drink_view: AnyView!
    var body: some View {
        
        Button {
            
        } label:
        {
            
            ZStack {
                Image(image_name)
                    .frame(width: 30, height: 40)
                Circle()
                    .foregroundColor(.white)
                    .frame(width:59, height:59)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
            }
            
        }
    }
}

struct StatusRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .frame(width: 157, height:105)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standard = UINavigationBarAppearance()
        standard.backgroundColor = UIColor(background_color) //When you scroll or you have title (small one)
        
        let compact = UINavigationBarAppearance()
        compact.backgroundColor = UIColor(background_color) //compact-height
        
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.backgroundColor = UIColor(background_color) //When you have large title
        
        navigationBar.standardAppearance = standard
        navigationBar.compactAppearance = compact
        navigationBar.scrollEdgeAppearance = scrollEdge
    }
}

struct HomeView: View {
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(background_color)
    }
    var body: some View {
        NavigationView {
            
            
            VStack {
                
                HStack {
                    RoundedRectangle(cornerRadius: 26)
                        .frame(width:50, height: 500)
                        .foregroundColor(primary_color)
                    Spacer()
                        .frame(width:110)
                    VStack {
                        Spacer()
                            .frame(height:50)
                        StatusRectangle()
                        Spacer()
                            .frame(height:50)
                        StatusRectangle()
                        Spacer()
                            .frame(height:50)
                        StatusRectangle()
                        Spacer()
                            .frame(height:50)
                        
                    }.background(background_color)
                        .clipShape(RoundedRectangle(cornerRadius:20))
                    
                    
                }
                
                HStack {
                    DrinkButton(image_name: "")
                    DrinkButton(image_name: "")
                    DrinkButton(image_name: "")
                    DrinkButton(image_name: "")
                    DrinkButton(image_name: "")
                }.background(background_color)
                    .padding(30)
                    .offset(x:20)
            }
            .navigationTitle("My Status")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Help tapped!")
                    }
                    label : {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(primary_color)
                    }
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
