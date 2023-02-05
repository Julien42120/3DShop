class APIResponse {
  static String baseUrl = 'https://3dshopapi.fr/public';
  static String categoriesUrl = '/categories';
  static String categoryIdUrl = '/category/';
  static String printIdUrl = '/printing/';
  static String register = '/api/users';
  static String login = '/authentication_token';
  static String profile = '/profile';
  static String user = '/api/users/';
  static String modifyUser = '/api/users/';
  static String logout = '/logout';
  static String material = '/api/materials';
  static String config = '/get_price';
  static String cart = '/api/carts';
  static String order = '/api/orders';
  static String orderPrintConfiguration = '/api/configs';
  static String orderId = '/order/';

// Route utilisé pour l'envoi de commande en bdd
  static String pathOrderPostConfig = 'api/orders/';
  static String pathPrintPostConfig = 'api/printings/';
  static String pathMaterialPostConfig = 'api/materials/';
}
