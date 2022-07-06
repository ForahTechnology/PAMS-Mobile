//AUTHOR: EWANFO LUCKY PETER

import 'dart:io';

class Strings {
  //LINKED DATA
  static String appStoreLink() {
    return Platform.isIOS
        ? 'itms-apps://itunes.apple.com/app/id1413887430'
        : 'market://details?id=com.ncktech.easydispatch';
  }

  //SHARED PREFERENCE KEYS FOR EASY ACCESS AND MODIFICATION
  static const String token_pref = "token";
  static const String email_pref = "email";
  static const String f_name_pref = "first_name";
  static const String l_name_pref = "last_name";
  static const String phone = "phone";
  static const String role = "role";
  static const String is_logged_in = "is_logged_in";
  static const String app_launched = "app_launched";




  //OTHER STRINGS
  static const String nigerianLocale = 'en_NG';
  static const String customFont = "Circular";
  static const String restaurantLoc = 'Enter restaurant location';
  static const String findRestaurant = "SEARCH";
  static const String category = "Category";
  static const String offer = "Offer";
  static const String myaccount = "Account";
  static const String more = "More";
 
  static const String signin = "Sign In";
  static const String signup = "Sign Up";
  static const String searchrestaurant = "SEARCH";
  static const String restaurant = "Restaurants";
  static const String emailInvalid = "Enter a valid email address";
  static const String blogTitle =
      "Blog title e.g Recipe for cooking fried rice with goat meat";
  static const String dateTimes = "20/09/2018";


  static const String confirm = 'Confirm';
  static const String delConfirm =
      'Are you sure you want to delete this menu item?';
  static const String areYouSureProceed = "Are you sure want to proceed?";
  static const String areYouSureDelete =
      "Are you sure want to delete this card?";
  static const String savedPaymentCards = 'Saved Payments Cards';
  static const String expiration = 'Expiration';
  static const String cvv = 'CVV';
  static const String next = 'Next';
  static const String addPaymentCard = 'Add Payment Card';
  static const String addNew = 'Add New';
  static const String addCard = 'Add Card';
  static const String enterCard = 'Enter Card';
  static const String securePaystack = "Secured by Paystack";
  static const String noSavedCard = 'No saved card';
  static const String expiryDate = 'Expiry Date';
  static const String cardNumber = 'Card Number';
  static const String nameOnCard = 'Name on Card';
  static const String makePayment = 'Make Payment';
  static const String cancel = 'Cancel';



  static const String paymentVerificationMsg = 'Unable to verify payment';
  static const String error = 'Error';
  static const String cardText =
      "Once you save your cards, you can find them right here.";
  static const String fieldReq = 'This field is required';
  static const String continueCaps = "CONTINUE";
  static const String continueSmall = "Continue";
  static const String accountCredit =
      ' and your payment will be refunded to your credits';
  static const String fullCreditWarning =
      'The cost of this order will be deducted from '
      'your credits';
  static const String partCreditWarning =
      'Your credits is not enough to pay for this '
      'order';
  static const String xAmountDebit = 'will be deducted from your card.';
  static const String notGenerated = 'NOT GENERATED';
  static const String creditSuccessful = 'Credit Payment Successful';
  static const String selectPaymentCard = 'Select Payment Card';
  static const String paymentCancelled = 'Payment cancelled';
  static const String ride = 'Ride details';
  static const String driverRating = "Driver Rating";
  static const String name = "Name";
  static const String phoneNumber = "Phone Number";
  static const String completeOrder = 'Complete Order';
  static const String emailAddress = "Email Address";
  static const String estimatedTime = 'Estimated Time';
  static const String pickupLoc = "Find your restaurants";
  static const String pickLoc = 'Pickup Location';
  static const String restLoc = 'Restaurant/Pickup Location';
  static const String dropOffLoc = 'Dropoff Location';
  static const String enterDropOffLoc = 'Enter Dropoff Location';
  static const String submit = "Submit Rating";
  static const String viewRoute = 'View Route';
  static const String viewOrder = 'View Order';
  static const String retry = "Retry";
  static const String whereDeliveryTo = 'Where are you delivering to?';
  static const String sthWentWrg = "Something went wrong";
  static const String networkError = "No internet connection";
  static const String checkInternet =
      "Please check your internet connect to complete setup";
  static const String loadWallet = "Load wallet";
  static const String requestTimeOutMsg = 'Connection timed out';
  static const String allTrans = "All Transactions";
  static String closedMessage(bool isBeforeOpening) =>
      'We are still taking orders, but '
      'they will be fulfilled by 8:00 AM ${isBeforeOpening ? 'today' : 'tomorrow'}.';
  static const String latestTrans = "Latest Transactions";
  static const String viewMore = "view more";
}
