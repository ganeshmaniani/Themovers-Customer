class ApiUrl {
  /// DOMAIN URL LOCAL & LIVE

  // static var baseUrl = 'http://192.168.1.7/themovers/';

  //

  static var baseUrl = 'https://app.themovers.com.my/';

  /// Google Map Base Api EndPoints
  static var baseGoogleApi = 'https://maps.googleapis.com/maps/';

  /// Auth API EndPoints
  static var loginEndPoint = '${baseUrl}api/customers_login';
  static var forgetPasswordEndPoint =
      '${baseUrl}api/customer_confirm_password_update';
  static var registerEndPoint = '${baseUrl}api/customers_register';
  static var storeFirebaseDeviceIdEndPoint =
      '${baseUrl}api/store_customer_device_id';
  static var sendOtpEndPoint = '${baseUrl}api/send_mail';
  static var verifyOtpEndPoint = '${baseUrl}api/email_otp_checking';
  static var validEmailCheckEndPoint =
      '${baseUrl}api/reset_password_email_validation_customer';

  /// Email & Mobile No Checker endpoint
  static var emailCheckEndPoint = '${baseUrl}api/customers_email_check';

  static var forgetPasswordMobileNumberCheckEndPoint =
      '${baseUrl}api/customers_mobile_check_password_update';
  static var mobileNoCheckEndPoint = '${baseUrl}api/customers_mobile_check';

  /// Budget API EndPoints
  static var vehicleTypeListEndPoint = '${baseUrl}api/vehicle_types_list';

  ///  Package Details API EndPoints
  static var budgetPackageDetailEndPoints =
      '${baseUrl}api/budget_moving_detail';
  static var premiumPackageDetailEndPoints =
      '${baseUrl}api/premium_package_detail';
  static var disposalPackageDetailEndPoints =
      '${baseUrl}api/disposal_package_detail';
  static var manpowerPackageDetailEndPoints =
      '${baseUrl}api/manpower_package_detail';

  /// LongPush Type Detail API EndPoints
  static var longPushTypeDetailEndPoints = '${baseUrl}api/longpush_type_detail';

  /// Booking API EndPoints
  static var budgetBookingEndPoint = '${baseUrl}api/booking_budget_submit';
  static var premiumBookingEndPoint = '${baseUrl}api/booking_premium_submit';
  static var disposalBookingEndPoint = '${baseUrl}api/booking_disposal_submit';
  static var manpowerBookingEndPoint = '${baseUrl}api/booking_manpower_submit';
  static var tumpangBookingEndPoint = '${baseUrl}api/booking_tumpang_submit';

  static var bookingStatusUploadEndPoint =
      '${baseUrl}api/customer_completed_booking';

  /// Booking List and Details API EndPoints
  static var bookingListEndPoint = '${baseUrl}api/booking_list';
  static var bookingDetailsEndPoint = '${baseUrl}api/booking_detail';
  static var unAssignedBookingListEndPoint =
      '${baseUrl}api/booking_list_unassigned';

  /// Google Map Api EndPoints
  /// Autocomplete Place API EndPoints
  static var autoCompletePlaceEntPoint =
      '${baseGoogleApi}api/place/autocomplete/json';

  /// Place Id To Get Latitude Longitude Api EndPoints
  static var placeIdToLatLangEntPoint =
      '${baseGoogleApi}api/geocode/json'; // place_id=gsdg3er&key=qdgf34

  /// Latitude Longitude To Get Place Api EndPoints
  static var latLangToPlaceEntPoint =
      '${baseGoogleApi}api/geocode/json'; // latlang=12.43,12.45&key=zxbveq43dvd

  /// Direction Api EndPoints
  static var directionEntPoint =
      '${baseGoogleApi}api/directions/json'; // origin=12.43,12.45&destination=23.43,54.21&key=zxbveq43dvd

  static var couponCodeCheckerEndPoint = '${baseUrl}api/coupon_check';

  ///Customer Details
  static var customerDetailsEndpoint = '${baseUrl}api/customer_details';

  ///Customer Details Update
  static var customerDetailsUpdateEndPoint =
      '${baseUrl}api/customer_update_details';

  ///Customer Upload Image
  static var customerProfileImageUpdateEndPoint =
      '${baseUrl}api/customer_profile_upload';

  ///Reset Password
  static var customerResetPassword = '${baseUrl}api/customer_reset_password';

  ///Customer Booking Rating

  static var bookingRatingEndpoint = '${baseUrl}api/review_submit';

  /// Image Slider
  static var imageSliderEndPoint = '${baseUrl}api/customer_slider_list';

  ///FAQ List
  static var faqListEndPoint = '${baseUrl}api/customer_faq_list';

  static var termsAndConditionEndPoint =
      '${baseUrl}api/customer_terms_condition_list';

  static var termsAndPoliciesEndPoint =
      '${baseUrl}api/customer_terms_policies_list';

  ///Delete Account
  static var customerAccountDeleteEndPoint =
      '${baseUrl}api/customer_account_delete_request';

  ///Version Code
  static var versionCodeEndPoint = '${baseUrl}api/get_app_playstore_version';
}
