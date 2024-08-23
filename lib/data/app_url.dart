class AppUrl {
  static var baseUrl = "http://swabi.ap-south-1.elasticbeanstalk.com";
  static var baseUrlForImage = "http://swabi.ap-south-1.elasticbeanstalk.com";

  ///registration URL
  static var login = "$baseUrl/login";
  static var signUp = "$baseUrl/user/register_user";
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
}
