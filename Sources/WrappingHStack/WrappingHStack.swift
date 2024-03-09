// Author: Alejandro Luján López

import SwiftUI

public struct WrappingHStack: Layout {
	public init() {}
	public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		guard let proposedWidth = proposal.width else {
			return CGSize(width: 0, height: 0)
		}
		
		// Loop over all subview sizes and see how many fit in one row
		// When they don't fit, create another row and append the height.
		// The height of each row should be the max of the subviewSize.height.
		var currentRowWidth: CGFloat = 0
		var currentRowHeight: CGFloat = 0
		var totalHeight: CGFloat = 0
		
		for index in subviews.indices {
			
			let subview = subviews[index]
			let subviewSize =  subview.sizeThatFits(.unspecified)
			var newElementWidth = subviewSize.width
			if index < subviews.count - 1 {
				let nextSubview = subviews[index + 1]
				newElementWidth += subview.spacing.distance(to: nextSubview.spacing, along: .horizontal)
			}
			
			if currentRowWidth + newElementWidth > proposedWidth { // Needs to go to the next row.
				totalHeight += currentRowHeight
				currentRowWidth = 0
				currentRowHeight = 0
			}
			currentRowWidth += newElementWidth
			currentRowHeight = max(currentRowHeight, subviewSize.height)
		}
		totalHeight += currentRowHeight
		return CGSize(width: proposedWidth, height: totalHeight)
	}
	
	public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		
		guard let proposedWidth = proposal.width else {
			return
		}
		
		/// Place one view after the other while they fit in the available width,
		/// When they don't fit, start placing them in the next row.
		var currentX: CGFloat = bounds.minX
		var currentY: CGFloat = bounds.minY
		var rowMaxHeight: CGFloat = 0
		
		for (i, subview) in subviews.enumerated() {
			let subviewSize = subviews[i].sizeThatFits(.unspecified)
			if currentX + subviewSize.width > proposedWidth { // Needs to go to the next row.
				currentX = bounds.minX
				currentY += rowMaxHeight
				rowMaxHeight = 0
			}
			subview.place(at: CGPoint(x: currentX, y: currentY), anchor: .topLeading, proposal: ProposedViewSize(subviewSize))
			currentX += subviewSize.width
			rowMaxHeight = max(rowMaxHeight, subviewSize.height)
			if i < subviews.count - 1 {
				let nextSubview = subviews[i + 1]
				currentX += subview.spacing.distance(to: nextSubview.spacing, along: .horizontal)
			}
		}
	}
	
	
	
}

private let arrayOfFruits: [String] = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Honeydew", "Icaco", "Jackfruit", "Kiwi", "Lemon", "Mango", "Nectarine", "Orange", "Peach", "Quince", "Raspberry", "Strawberry", "Tangerine", "Ugli", "Vanilla", "Watermelon", "Xigua", "Yuzu", "Zucchini"]

#Preview {
	WrappingHStack {
		ForEach(arrayOfFruits, id: \.self) { fruit in
			Button(fruit) {
				// Do nothing
			}
			.buttonStyle(.bordered)
		}
	}
}
