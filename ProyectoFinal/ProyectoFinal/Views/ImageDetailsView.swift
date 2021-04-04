//
//  ImageDetailsView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI

struct ImageDetailsView: View {
    var body: some View {
        VStack {
            Image("turtlerock")
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            VStack(alignment: .leading) {
                Text("Image Name")
                    .font(.title)
                    .padding(.bottom)
                   
                HStack {
                    Text("Fecha de subida")
                    Spacer()
                    Text("25 de abril del 2021")
                }
                .font(.headline)
                .foregroundColor(.secondary)
            }

        }
        .padding()
        Spacer()
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView()
    }
}
