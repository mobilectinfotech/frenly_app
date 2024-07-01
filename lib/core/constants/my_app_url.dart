class Appurls {
  static const baseUrl = 'http://192.168.1.25:8000/api/';
  //static const baseUrl = 'http://18.233.72.175:4000';
  static final  Uri register = Uri.parse('http://192.168.1.25:8000/api/register');
  static final  Uri login = Uri.parse('$baseUrl/login');
}

class Appurl{
  static final  Uri signupp = Uri.parse('http://192.168.1.48:4200/signup');
  static final  Uri loginn = Uri.parse('http://192.168.1.48:4200/login');
}

class Appp{
  static final  Uri sign_Up = Uri.parse('http://18.233.72.175:4000/sign_Up');
  static final  Uri loginUser = Uri.parse('http://18.233.72.175:4000/loginUser');
}

class Apppurls{
  static final  Uri signUp = Uri.parse('http://192.168.1.35:3001/user/signup');
  static final  Uri loggin = Uri.parse('http://192.168.1.35:3001/user/login');
  static final  Uri forgetpassword = Uri.parse('http://192.168.1.35:3001/user/forgotPassword');

  static final  Uri home = Uri.parse('http://192.168.1.35:3001/home');

}