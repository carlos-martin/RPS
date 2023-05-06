//
//  DropDownView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct DropDownView: View {
    @Binding var selection: String

    var source: [String] = MoveOption.cases

    var body: some View {
        Menu {
            Picker(selection: $selection, label: EmptyView()) {
                ForEach(source, id: \.self) { element in
                    Text(element.description)
                        .font(.title)
                }
            }
        } label: {
            Image.DropDown.icon
        }

    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(selection: .constant(MoveOption.paper.description))
    }
}

