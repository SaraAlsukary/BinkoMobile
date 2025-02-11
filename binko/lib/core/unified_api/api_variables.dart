import 'dart:developer';

import '../extensions/log_colors_extension.dart';
import '../utils/type_defs.dart';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'https';
  final _host = 'api.ewaae.com';
  // final _port = 5000;

  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      // port: _port,
      path: '/current/public/api/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  //////Auth Start///////
  Uri _authUri({required String path, Map<String, String>? params}) =>
      _mainUri(path: 'auth/$path', queryParameters: params);
  Uri login() => _authUri(path: 'login');
  Uri logout() => _authUri(path: 'logout');
  Uri register() => _authUri(path: 'register');
  Uri registerInvestor() => _authUri(path: 'register-investor');
  Uri verifyOtp(String id) => _authUri(path: 'verify-otp/$id');
  Uri resendOtp(String id) => _authUri(path: 'resend-otp/$id');
  Uri forgotPassword() => _authUri(path: 'forgot-password');
  Uri resetPassword(String id) => _authUri(path: 'reset-password/$id');
  Uri deleteAccount() => _authUri(path: 'delete-account');
  Uri verifyToken() => _authUri(path: 'verify-token');
  Uri getProfile() => _authUri(path: 'get-customer-profile');
  Uri updateProfile() => _authUri(path: 'update-customer-profile');
  Uri updateContact() => _authUri(path: 'update-customer-contact');

  Uri resetProfilePassword() => _authUri(path: 'reset-profile-password');
  Uri verifyUpdateContact() => _authUri(path: 'verify-update-customer-contact');
  //////Auth End///////
  /////Categories//////
  Uri indexCategories({ParamsMap? params}) => _mainUri(
      path: 'product-categories/get-product-categories',
      queryParameters: params);
  Uri getHomeCategories({ParamsMap? params}) => _mainUri(
      path: 'product-categories/get-home-categories', queryParameters: params);
  Uri getHomeRandom() =>
      _mainUri(path: 'mobile/product-categories/get-random-categories');
  Uri getSlider(String key) => _mainUri(path: 'mobile/sliders/get-slider/$key');
  Uri indexFeaturedCategories({ParamsMap? params}) => _mainUri(
      path: 'product-categories/get-featured-product-categories',
      queryParameters: params);
  //////Categories End///////
  //////Stores///////
  Uri indexStores({ParamsMap? params}) => _mainUri(path: 'stores/get-stores');
  Uri showStore({required int id}) => _mainUri(path: 'stores/get-store/$id');
  //////Stores End///////

  //////Countries Start///////
  Uri getCountries({ParamsMap? params}) =>
      _mainUri(path: 'countries/get-countries');
  Uri getStates({ParamsMap? params}) =>
      _mainUri(path: 'states/get-states', queryParameters: params);
  Uri getCities({ParamsMap? params}) =>
      _mainUri(path: 'cities/get-cities', queryParameters: params);
  //////Countries End///////
  //////UserAddress End///////
  Uri createUserAddress() =>
      _mainUri(path: 'customer-addresses/create-customer-address');
  Uri updateUserAddress(int id) =>
      _mainUri(path: 'customer-addresses/update-customer-address/$id');
  Uri getUserAddresses({ParamsMap? params}) => _mainUri(
      path: 'customer-addresses/get-customer-addresses',
      queryParameters: params);
  Uri showUserAddress(int id) =>
      _mainUri(path: 'customer-addresses/get-customer-addresses/$id');
  Uri deleteUserAddress(int id) =>
      _mainUri(path: 'customer-addresses/delete-customer-address/$id');
  Uri toggleIsDefaultUserAddress(int id) =>
      _mainUri(path: 'customer-addresses/toggle-is-default/$id');
  //////Countries End///////
  //////Products Start/////////
  Uri createReview() => _mainUri(path: 'reviews/create');
  Uri getWishlist() => _mainUri(
      path: 'mobile/wishlist/get', queryParameters: {'perPage': '1000'});
  Uri addWishlist(int id) => _mainUri(path: 'wishlist/add/$id');
  Uri removeWishlist(int id) => _mainUri(path: 'wishlist/delete/$id');
  Uri featuredProducts(ParamsMap params) => _mainUri(
      path: 'mobile/products/get-featured-products', queryParameters: params);
  Uri indexProducts(ParamsMap params) =>
      _mainUri(path: 'mobile/products/get-products', queryParameters: params);
  Uri showProducts(int id) => _mainUri(path: 'mobile/products/get-product/$id');
  Uri getFlashSale() => _mainUri(path: 'mobile/flash-sales');
  Uri indexSaleProducts(ParamsMap params) => _mainUri(
      path: 'mobile/products/get-sale-products', queryParameters: params);
  Uri indexRelatedProducts(int id, ParamsMap params) => _mainUri(
      path: 'mobile/products/get-related-products/$id',
      queryParameters: params);
  //////Products End/////////
  //////Brands Start////////
  Uri indexBrands(ParamsMap params) =>
      _mainUri(path: 'brands/get-home-brands', queryParameters: params);
  //////Brands End/////////
  //////Orders Start////////
  Uri createOrder() => _mainUri(path: 'orders/create');
  Uri indexMyOrders(ParamsMap params) =>
      _mainUri(path: 'mobile/orders', queryParameters: params);
  Uri showOrder(int id) => _mainUri(path: 'orders/show/$id');
  Uri cancelOrder(int id) => _mainUri(path: 'orders/cancel/$id');
  Uri getShippmentDetails() => _mainUri(path: 'mobile/shipping/calculation');
  Uri checkCoupon() => _mainUri(path: 'coupons/check-coupon');
  Uri getRewards() => _mainUri(path: 'rewards');
  Uri transformPointsToCoupon(int rewardId) =>
      _mainUri(path: 'coupons/create/$rewardId');
  Uri getProfilePointsHistory(ParamsMap params) =>
      _mainUri(path: 'loyalty-transactions', queryParameters: params);

  //////Orders End/////////
  /////// ContactUS Start///////
  Uri sendReport() => _mainUri(path: 'mobile/contact-us/create');
  Uri getTickets(ParamsMap params) =>
      _mainUri(path: 'contact-us', queryParameters: params);
  Uri getReplies(int id, ParamsMap params) =>
      _mainUri(path: 'contact-reply/$id', queryParameters: params);
  Uri changeStatus(int id) =>
      _mainUri(path: 'mobile/contact-us/update-status/$id');
  Uri createReply() => _mainUri(path: 'contact-reply/create');
  Uri deleteReply(int id) => _mainUri(path: 'contact-reply/delete/$id');
  /////// ContactUS End///////
  /////// Others Start///////
  Uri privacyPolicy() => _mainUri(path: 'pages/show/privacy-policy');
  Uri refundPolicy() => _mainUri(path: 'pages/show/refund-policy');
  Uri reviewGuidlines() => _mainUri(path: 'pages/show/review-guidlines');
  Uri settingsPage() => _mainUri(path: 'settings/get');
  Uri getCurrencies() => _mainUri(path: 'currency');
  /////// Notifications Start///////
  Uri getRandomAds() => _mainUri(path: 'ads/get-random-ad');
  Uri getNotifications() => _mainUri(path: 'notifications');
  Uri readNotification(int id) => _mainUri(path: 'notifications/read/$id');
  Uri readAllNotifications() => _mainUri(path: 'notifications/read-all');
  /////// Notifications End///////
  /////// Search Start///////
  Uri search(ParamsMap params) =>
      _mainUri(path: 'mobile/products/search', queryParameters: params);
  Uri indexAllCategories({ParamsMap? params}) => _mainUri(
      path: 'mobile/product-categories/get-all-categories',
      queryParameters: params);
  Uri getCoupon(ParamsMap? params) => _mainUri(
        path: 'mobile/coupons',
        queryParameters: params,
      );
  /////// Search End///////
}
