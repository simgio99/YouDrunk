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
    @State var isTappedStats: Bool = false
    @State var gramsPerLiter: String = "0,4 g/L"
    @State var alcoholPercentage: String = "13%"
    @State var soberTime: String = "2.5 hours"
    @State var isTappedFullStomach = false
    let today = Date.now
    let rows = [
        GridItem(.flexible(minimum: 25))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("",
                    destination: StatsView(),
                    isActive: $isTappedStats)
                
                HStack {
                    //Big, grey rectangle
                    RoundedRectangle(cornerRadius: 26)
                        .frame(width:50, height: 500)
                        .foregroundColor(primary_color)
                    Spacer()
                        .frame(width:110)
                    VStack {
                        Spacer()
                            .frame(height:50)
                        
                        //stats rectangle
                        ZStack {
                            StatusRectangle()
                                .shadow(color: .gray, radius: 4.0, x: 0.0, y: 2.0)
                                .onTapGesture {
                                    isTappedStats = true
                            }
                            VStack(alignment: .leading) {
                                Text(today.formatted(date: .abbreviated, time: .omitted))
                                    .foregroundColor(.black)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                Text("")
                                Text(gramsPerLiter)
                                    .foregroundColor(primary_color)
                                Text(alcoholPercentage)
                                    .foregroundColor(primary_color)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .shadow(color: .gray, radius: 7, x: 0, y: 1)
                            }
                        }
                        Spacer()
                            .frame(height:50)
                        
                        //sober in:... rectangle
                        ZStack {
                            StatusRectangle()
                            VStack(alignment: .leading){
                                Text("Sober in:")
                                    .bold()
                                Text(soberTime)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(primary_color)
                            }
                        }
                        Spacer()
                            .frame(height:50)
                        
                        //full stomach rectangle
                        ZStack {
                            StatusRectangle()
                                .shadow(color: .gray, radius: 4.0, x: 0.0, y: 2.0)
                            Text("Full Stomach")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .padding(.all)
                                .foregroundColor(isTappedFullStomach ? primary_color : .gray)
                                .onTapGesture {
                                    isTappedFullStomach.toggle()
                                }
                        }
                        Spacer()
                            .frame(height:50)
                    }
                    .background(background_color)
                    .clipShape(RoundedRectangle(cornerRadius:20))
                }
                VStack(alignment: .leading, spacing: -10) {
                    Text("Drink Type")
                        .fontWeight(.thin)
                        .font(.title)
                        .padding(.top, 45)
                        .padding(.bottom, -29)
                        .padding(.leading)
                        
                    ScrollView(.horizontal) {
                        HStack {
                            VStack {
                                ZStack {
                                    DrinkButton(image_name: "")
                                    Image("Beer")
                                }
                                Text("Beer")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                            VStack {
                                ZStack {
                                    DrinkButton(image_name: "")
                                    Image("Cocktail")
                                }
                                Text("Cocktail")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                            VStack {
                                ZStack {
                                    DrinkButton(image_name: "")
                                    Image("Negroni")
                                }
                                Text("Long Drink")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    
                            }
                            VStack {
                                ZStack {
                                    DrinkButton(image_name: "")
                                    Image("Sweet_wine")
                                }
                                Text("White wine")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    
                            }
                            VStack {
                                ZStack {
                                    DrinkButton(image_name: "")
                                    Image("Wine_bottle")
                                }
                                Text("Red Wine")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    
                                    
                            }
                        }
                    }
                    .background(background_color)
                    .padding(0)
                    .offset(y:40)
                }
                .padding(.bottom, 40)
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
