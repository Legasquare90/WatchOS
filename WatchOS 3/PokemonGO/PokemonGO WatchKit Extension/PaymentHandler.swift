/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	A shared class for handling payment across an app and its related extensions
 */

import UIKit
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .masterCard,
        .visa
    ]
    
    let merchantIdentifier = "merchant.com.demo.PokemonGO"

    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?

    func startPayment(item: String, quantity: Int, price: Double, completion: @escaping PaymentCompletionHandler) {

        let items = PKPaymentSummaryItem(label: "\(quantity) \(item)", amount: NSDecimalNumber(value: price), type: .final)
        let total = PKPaymentSummaryItem(label: "Pokemon GO", amount: NSDecimalNumber(value: price), type: .pending)

        paymentSummaryItems = [items, total];
        completionHandler = completion

        // Create our payment request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = merchantIdentifier
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "ES"
        paymentRequest.currencyCode = "EUR"
        paymentRequest.requiredShippingAddressFields = [.phone, .email]
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks

        // Display our payment request
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                NSLog("Presented payment controller")
            } else {
                NSLog("Failed to present payment controller")
                self.completionHandler!(false)
            }
        })
    }
}

/*
    PKPaymentAuthorizationControllerDelegate conformance.
 */
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {

        // Perform some very basic validation on the provided contact information
        if payment.shippingContact?.emailAddress == nil || payment.shippingContact?.phoneNumber == nil {
            paymentStatus = .invalidShippingContact
        } else {
            // Here you would send the payment token to your server or payment provider to process
            // Once processed, return an appropriate status in the completion handler (success, failure, etc)
            paymentStatus = .success
        }

        completion(paymentStatus)
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
            }
        }
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectPaymentMethod paymentMethod: PKPaymentMethod, completion: @escaping ([PKPaymentSummaryItem]) -> Void) {
        // The didSelectPaymentMethod delegate method allows you to make changes when the user updates their payment card
        completion(paymentSummaryItems)
    }
}
