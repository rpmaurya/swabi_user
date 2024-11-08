class AppUrl {
  static var baseUrl = "http://swabi.ap-south-1.elasticbeanstalk.com";
  static var baseUrlForImage = "http://swabi.ap-south-1.elasticbeanstalk.com";

  ///registration URL
  static var login = "$baseUrl/login";
  static var loginUrl = "/login";
  static var signUp = "$baseUrl/user/register_user";
  static var signupUrl = '/user/register_user';
  static var rental = "$baseUrl/rental";
  static var rentalBooking = "$baseUrl/rental/booking";
  static var rentalBookingCancel = "$baseUrl/rental/cancel_rental_booking";
  static var rentalBookingList = "$baseUrl/rental/get_rental_booking_by_userId";
  static var rentalViewDetails = "$baseUrl/rental/get_rental_booking_by_id";
  static var userProfile = "$baseUrl/user/get_user_by_userId";
  static var userProfileUpdate = "$baseUrl/user/update_user";
  static var userProfileimg = "$baseUrl/user/upload_profile";
  static var rentalRangeList = "$baseUrl/rental/get_rental_metrics_list";
  static var getPackageList = "$baseUrl/package/get_package_list";
  static var createPaymentOrder = "/payment/create_order";
  static var verifyPayment = "/payment/verify_payment";
  static var changepasswordUrl = "/user/change_user_password";
  static var rentalCarBookingUrl = "/rental/booking_v2";
  static var rentalCarSearchUrl = '/rental/rental_car_price';
  static var paymentDetailUrl = "/payment/get_payment_by_payment_id";
  static var changeMobileUrl = "/package_booking/change_mobile_number";
  static var raiseIssueUrl = "/booking_issue/raise_issue";
  static var getIssueUrl = "/booking_issue/get_issue_raised_by";
  static var getIssueDetailsUrl = "/booking_issue/get_issue_detail";
  static var getIssueBybbokingId = "/booking_issue/get_issue_by_booking_id";
  static var sendOtpsUrl = "/otp_send";
  static var verifyOtpUrl = "/otp_verify";
  static var resetPassordUrl = "/password_update";
  static var getOfferListUrl = "/offer/get_available_offer";
  static var getOfferDetailUrl = "/offer/get_offer_by_id";
  static var validateOfferUrl = "/offer/validate_offer";
  static var getTransactionByIdUrl = "/payment/get_transaction_by_userId";
  static var getRefundPaymentUrl = "/payment/get_refund_by_payment_id";
  static var packageCancellUrl = "/package_booking/cancel_package_booking";
  static var rentalCancellUrl = "/rental/cancel_rental_booking";
  static var getPackagelistUrl =
      "/package_booking/get_package_booking_by_userId";
}
