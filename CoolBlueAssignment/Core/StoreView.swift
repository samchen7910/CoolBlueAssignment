//
//  StoreView.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//
import SwiftUI

struct StoreView: View {
	var name: String? = "Rotterdam Oostplein"
	var address: String? = "Burgerstraat 1, 1234 AA, Rotterdam NL"
	var todayOpeningHours: String? = "9:00 - 17:00"
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.fill(.blue)
			VStack(alignment: .leading, spacing: 4) {
				if let name {
					Text(name)
						.font(.headline)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
				if let address {
					Text(address)
						.font(.subheadline)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
				
				if let todayOpeningHours {
					Text(todayOpeningHours)
						.font(.subheadline)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
			}
			.padding(8)
		}
	}
}


#Preview("StoreView - With All Information") {
	StoreView()
		.frame(height: 120)
		.padding()
}

#Preview("AppView - With Only Name") {
	StoreView(address: nil, todayOpeningHours: nil)
		.frame(height: 120)
		.padding()
}

#Preview("AppView - With Only Address") {
	StoreView(name: nil, todayOpeningHours: nil)
		.frame(height: 120)
		.padding()
}

#Preview("AppView - With Only OperatingTime") {
	StoreView(name: nil, address: nil)
		.frame(height: 120)
		.padding()
}





