class Endpoint {
  static const baseUrl = 'http://develop-at.vesperia.id:1091/api/v1';

  static const getUser = '/user';
  static const postUpdateProfile = '$getUser/profile';
  static const postSignIn = '/sign-in';
  static const postSignOut = '/sign-out';

  static const getProductList = '/product';
  static const getProductRatings = '/rating';
  static getProductDetail(String id) => '$getProductList/$id';
  static const flutterTutorialPdf =
      'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf';
  static const webviewUrl = 'https://www.youtube.com/watch?v=lpnKWK-KEYs';
}
