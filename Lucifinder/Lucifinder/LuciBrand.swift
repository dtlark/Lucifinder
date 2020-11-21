//
//  LuciBrand.swift
//  Lucifinder
//
//  Created by Jeremy Palavecino on 10/17/20.
//

import SwiftUI

struct LuciBrand: View {
    var body: some View {
        GeometryReader { geo in
            Image("Brand")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width)
        }.frame(maxHeight: 125, alignment: .top)
    }
}

struct LuciBrand_Previews: PreviewProvider {
    static var previews: some View {
        LuciBrand()
    }
}
