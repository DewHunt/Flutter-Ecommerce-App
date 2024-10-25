class Urls {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const String sliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static const String readProfile = '$_baseUrl/ReadProfile';
  static const String addToCart = '$_baseUrl/CreateCartList';
  static const String createProfile = '$_baseUrl/CreateProfile';
  static const String logout = '$_baseUrl/logout';
  static const String cartList = '$_baseUrl/CartList';
  static const String createReview = '$_baseUrl/CreateProductReview';
  static const String wishList = '$_baseUrl/ProductWishList';

  static productListByRemark(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static productListByCategory(int id) => '$_baseUrl/ListProductByCategory/$id';

  static productDetailsById(int id) => '$_baseUrl/ProductDetailsById/$id';

  static verifyEmail(String email) => '$_baseUrl/UserLogin/$email';

  static verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static deleteFromCartList(int id) => '$_baseUrl/DeleteCartList/$id';

  static reviewListByProduct(int id) => '$_baseUrl/ListReviewByProduct/$id';
  static createWish(int id) => '$_baseUrl/CreateWishList/$id';
}
