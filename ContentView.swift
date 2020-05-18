
//  Created by Simon Burke on 5/16/20.
//  Copyright © 2020 Simon Burke. All rights reserved.
//


import SwiftUI
import MessageUI

var response = FormResponse(requestType: "", name: "", reason: "", date: "", returnDate: "", advisorEmail: "", teacher1: "", teacher2: "", teacher3: "", transportation: "", host: "", location: "")
var emails: [String]?

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Form {
                
                NavigationLink(destination: TripView()) {
                    Text("Trip Request")
                        .foregroundColor(Color.blue)
                }
                
                NavigationLink(destination: LongView()) {
                    Button(action: {
                    }) {
                        Text("Long Weekend")
                    }
                }
                
                NavigationLink(destination: ShortView()) {
                    Button(action: {
                    }) {
                        Text("Short Weekend")
                    }
                }
                
                NavigationLink(destination: NightView()) {
                    Button(action: {
                    }) {
                        Text("Late Night")
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TripView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var showingMail = false
    
    
    @State var name: String = ""
    @State public var requestType: String = ""
    @State public var date: String = ""
    @State public var returnDate: String = ""
    @State public var advisorEmail: String = ""
    @State public var t1: String = ""
    @State public var t2: String = ""
    @State public var t3: String = ""
    @State var reason: String = ""
    @State var location: String = ""
    var body: some View {
        Form {
            Section(header: Text("Trip Request")) {
                TextField("Name", text: $name)
                TextField("Destination", text: $location)
                TextField("Reason for trip", text: $reason)
                TextField("Date", text: $date)
                TextField("Return date", text: $returnDate)
                TextField("Advisor", text: $advisorEmail)
                TextField("Teacher 1", text: $t1)
                TextField("Teacher 2", text: $t2)
                TextField("Teacher 3", text: $t3)
                Button(action: {
                    response = FormResponse(requestType: "Trip", name: self.name, reason: self.reason, date: self.date, returnDate: self.returnDate, advisorEmail: self.advisorEmail, teacher1: self.t1, teacher2: self.t2, teacher3: self.t3, transportation: "", host: "", location: self.location)
                    emails = [self.advisorEmail, self.t1, self.t2, self.t3]
                    self.showingMail.toggle()
                }) {
                    Text("Submit")
                }
                .sheet(isPresented: $showingMail) {
                    MailView(result: self.$result)
                }
                
            }
        }
    }
}

struct LongView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    @State var name: String = ""
    @State public var date: String = ""
    @State public var returnDate: String = ""
    @State public var advisorEmail: String = ""
    @State var transportation: String = ""
    @State var host: String = ""
    @State var location: String = ""
    var body: some View {
        Form {
            Section(header: Text(response.requestType)) {
                TextField("Name", text: $name)
                TextField("Destination", text: $location)
                TextField("Date", text: $date)
                TextField("Return date", text: $returnDate)
                TextField("Host email address", text: $host)
                TextField("Transportation", text: $transportation)
                TextField("Advisor email address", text: $advisorEmail)
                Button(action: {
                    response = FormResponse(requestType: "Long", name: self.name, reason: "", date: self.date, returnDate: self.returnDate, advisorEmail: self.advisorEmail, teacher1: "", teacher2: "", teacher3: "", transportation: self.transportation, host: self.host, location: self.location)
                    emails = [self.advisorEmail, self.host]
                    self.isShowingMailView.toggle()
                }) {
                    Text("Submit")
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result)
                }
                
            }
        }
    }
}

struct ShortView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    @State var name: String = ""
    @State public var date: String = ""
    @State public var returnDate: String = ""
    @State public var advisorEmail: String = ""
    @State var reason: String = ""
    @State var transportation: String = ""
    @State var host: String = ""
    @State var location: String = ""
    var body: some View {
        Form {
            Section(header: Text("Long Weekend Request")) {
                TextField("Name", text: $name)
                TextField("Reason for trip", text: $reason)
                TextField("Date", text: $date)
                TextField("Return date", text: $returnDate)
                TextField("Host email address", text: $host)
                TextField("Transportation", text: $transportation)
                TextField("Advisor email adress", text: $advisorEmail)
                Button(action: {
                    response = FormResponse(requestType: "Short", name: self.name, reason: "", date: self.date, returnDate: self.returnDate, advisorEmail: self.advisorEmail, teacher1: "", teacher2: "", teacher3: "", transportation: self.transportation, host: self.host, location: self.location)
                    emails = [self.advisorEmail, self.host]
                    self.isShowingMailView.toggle()
                }) {
                    Text("Submit")
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result)
                }
                
            }
        }
    }
}

struct NightView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    @State var name: String = ""
    @State public var date: String = ""
    @State public var advisorEmail: String = ""
    @State var location: String = ""
    @State var transportation: String = ""
    var body: some View {
        Form {
            Section(header: Text("Late Night Request")) {
                TextField("Name", text: $name)
                TextField("Destination", text: $location)
                TextField("Date", text: $date)
                TextField("Advisor email address", text: $advisorEmail)
                TextField("Transportation", text: $transportation)
                Button(action: {
                    response = FormResponse(requestType: "Night", name: self.name, reason: "", date: self.date, returnDate: "", advisorEmail: self.advisorEmail, teacher1: "", teacher2: "", teacher3: "", transportation: self.transportation, host: "", location: self.location)
                    emails = [self.advisorEmail]
                    self.isShowingMailView.toggle()
                }) {
                    Text("Submit")
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result)
                }
                
            }
        }
    }
}

//referenced from https://stackoverflow.com/questions/56784722/swiftui-send-email and swift docs
struct MailView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    //create coordinator for mail view
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
           
            defer {
                $presentation.wrappedValue.dismiss()
            }
            //if there is error, report
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            //otherwise, return result
            self.result = .success(result)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        
        //autopopulate emails with request info for each request type
        if response.requestType == "Trip" {
            
            mail.setSubject("Trip Request")
            mail.setToRecipients(emails)
            mail.setCcRecipients(["I don't want to email Beth Wilson, so this is a placeholder"])
            mail.setMessageBody("\(response.name) has submitted a trip request awaiting your approval.\nReason for Trip: \(response.reason)\nDate of Departure: \(response.date)\nReturn Date: \(response.returnDate)", isHTML: false)
        }
            
        else if response.requestType == "Long" {
            
            mail.setSubject("Long Weekend Request")
            mail.setToRecipients(emails)
            mail.setCcRecipients(["I don't want to email Beth Wilson, so this is a placeholder"])
            mail.setMessageBody("\(response.name) has submitted a long weekend request awaiting your approval.\nDestionation: \(response.location)\nHost: \(response.host)\nTransportation: \(response.transportation)\nDate of Departure: \(response.date)\nReturn Date: \(response.returnDate)", isHTML: false)
        }
        else if response.requestType == "Short" {
            
            mail.setSubject("Short Weekend Request")
            mail.setToRecipients(emails)
            mail.setCcRecipients(["I don't want to email Beth Wilson, so this is a placeholder"])
            mail.setMessageBody("\(response.name) has submitted a short weekend request awaiting your approval.\nDestionation: \(response.location)\nHost: \(response.host)\nTransportation: \(response.transportation)\nDate of Departure: \(response.date)\nReturn Date: \(response.returnDate)", isHTML: false)
        }
        else if response.requestType == "Night" {
            
            mail.setSubject("Late Night Request")
            mail.setToRecipients(emails)
            mail.setCcRecipients(["Placeholder for faculty member"])
            mail.setMessageBody("\(response.name) has submitted a late night request awaiting your approval.\nDestionation: \(response.location)\nTransportation: \(response.transportation)\nDate: \(response.date)\n", isHTML: false)
        }
        mail.mailComposeDelegate = context.coordinator
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
        
    }
}
