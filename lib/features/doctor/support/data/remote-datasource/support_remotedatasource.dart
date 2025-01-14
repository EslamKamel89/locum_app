import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/doctor/support/domain/models/support_model.dart';

class SupportRemoteDatasource {
  final ApiConsumer api;
  SupportRemoteDatasource({
    required this.api,
  });
  Future<List<SupportModel>> fetchAllSupport() async {
    final t = prt('fetchAllSupport - MessageRemoteDatasource');
    final data = await api.get(EndPoint.getAllSupport);
    List<SupportModel> models = data['data'].map<SupportModel>((e) => SupportModel.fromJson(e)).toList();

    return pr(models, t);
  }
}
