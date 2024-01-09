import 'dart:convert';
import 'package:emergentesapp/domain/models/dataModel.dart';
import 'package:emergentesapp/infraestructure/repository/dataRepository.dart';
import 'package:http/http.dart' as http;

class DynamoRepositoryImpl implements DataRepository {
  @override
  Future<List<DataModel>> getDataList() async {
    final response = await http.get(Uri.parse('https://nb16yv47i1.execute-api.us-east-1.amazonaws.com/test/transaction'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> items = List.from(data['items']);

      return items.map((item) => DataModel(
        motion: item['device_data']['motion'],
        light: item['device_data']['light'],
      )).toList();
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      throw Exception('Error al obtener datos de la API');
    }
  }
}
