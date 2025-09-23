class EnvironmentVariables {
  EnvironmentVariables._();

  // base url endpoint
  static String get baseUrl => 'https://api.slingacademy.com';
  // get product
  static String get getProducts => '$baseUrl/v1/sample-data/products?&limit=30';
}
