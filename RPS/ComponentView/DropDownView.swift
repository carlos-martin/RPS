//
//  DropDownView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct DropDownView: View {
    @Binding var selection: String

    var source: [String] = MoveType.cases

    var body: some View {
        Menu {
            Picker(selection: $selection, label: EmptyView()) {
                ForEach(source, id: \.self) { element in
                    Text(element.description)
                        .font(.title)
                }
            }
        } label: {
            Image(systemName: "chevron.up.chevron.down")
        }

    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(selection: .constant(""))
    }
}

