import 'package:http/http.dart' as http;
import 'package:sms_app/routes/api_routes.dart';

class CallApi {
  final String _url = "https://systrafo.com.br/ws/sms";

  login(String email, String passwd) async {
    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/login?email=$email&passwd=$passwd'),
    );
  }
}
