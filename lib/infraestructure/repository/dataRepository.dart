import 'package:emergentesapp/domain/models/dataModel.dart';

abstract class DataRepository {
  Future<List<DataModel>> getDataList();
}