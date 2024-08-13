//
//  SettingsView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.08.24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let urls = URLs()
    
    var body: some View {
        VStack {
            List {
                contactSection
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
    
    private var contactSection: some View {
        Section {
            linkItem("Visit our website", url: urls.websiteURL)
            linkItem("Send Feedback", url: urls.twitterURL)
            rateAppButton
            legalNoticeNavigationLink
            linkItem("Privacy Policy", url: urls.privacyPolicyURL)
            linkItem("Terms and Conditions", url: urls.termsAndConditionsURL)
        } header: {
            Text("Menu")
        }
        .bold()
        .foregroundColor(Color(.label))
        .listRowBackground(Color(.systemGray5))
        .listRowSeparator(.hidden)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Settings")
                    .font(.title)
                    .foregroundColor(.black)
                Spacer()
            }
            .bold()
        }
    }
    
    private var rateAppButton: some View {
        Button {
            rateApp()
        } label: {
            HStack {
                Text("Rate WorkoutPulse")
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var legalNoticeNavigationLink: some View {
        ZStack {
            NavigationLink {
                LegalNoticeView()
            } label: {
                Text("Legal Notice")
            }
            HStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
        }
    }
    
    private func linkItem(_ title: String, url: URL) -> some View {
        HStack {
            Link(title, destination: url)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
    }
    
    private func rateApp() {
        let appReviewURL = "itms-apps://itunes.apple.com/app/idid6444348524?action=write-review&mt=8"
        print(appReviewURL)
        UIApplication.shared.open(URL(string:appReviewURL)!, options: [:])
    }
}

struct URLs {
    let websiteURL = URL(string: "https://leongrimmeisen.de/projects/JustTabata/index.html")!
    let privacyPolicyURL = URL(string: "https://leongrimmeisen.de/projects/JustTabata/privacy-policy.html")!
    let termsAndConditionsURL = URL(string: "https://leongrimmeisen.de/projects/JustTabata/terms-and-conditions.html")!
    let twitterURL = URL(string: "https://twitter.com/LofiLeon")!
}

struct LegalNoticeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                vStack(title: "Angaben gemäß § 5 TMG", content: """
                Leon Grimmeisen
                Petersburger Straße 42
                10249 Berlin
                """)
                
                vStack(title: "Kontakt", content: """
                Telefon: +491743629023
                E-Mail: lmgrimmeisen(at)gmail.com
                """)
                
                vStack(title: "Haftung für Links", content: """
                Diese App enthält Links zu externen Websites Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung, soweit möglich, auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.
                """)
                
                vStack(title: "Quelle", content: """
                Link: e-recht24
                Destination: https://www.e-recht24.de/impressum-generator.html
                """)
            }
            .navigationTitle("Legal Notice")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(15)
        }
    }
    
    private func vStack(title: String, content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
            Text(content)
        }
        .padding(.vertical, 15)
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}
