import 'dart:async';
import 'dart:convert';
import 'dart:io';

class HttpGetRequest {
  final HttpClient client = HttpClient();

  Future<String?> fetchUrl(String url, {int timeoutSeconds = 10}) async {
    try {
      final HttpClientRequest request = await client.getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final String responseBody =
            await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        // Manejar el caso de respuesta no exitosa aquí
        return null;
      }
    } catch (e) {//tIempo de conexion agotado
      return null;
    } finally {
      client.close(); // Cierra el cliente
    }
  }
}
