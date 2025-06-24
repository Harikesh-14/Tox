//
//  NoTaskView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 22/06/25.
//

import SwiftUI

struct NoTaskView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.appPrimary.opacity(0.9))
            
            Text("No Tasks Yet")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .fontDesign(.rounded)
            
            Text("You're all caught up! Add a task to get started.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoTaskView()
}
