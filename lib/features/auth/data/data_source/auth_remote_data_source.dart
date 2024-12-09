// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiConsumer api;
  AuthRemoteDataSource({
    required this.api,
  });
  Future<UserModel> signIn({required String email, required String password}) async {
    final t = prt('signIn - CommonDataRemoteSource');
    final data = await api.post(
      EndPoint.signin,
      data: {"email": email, "password": password},
    );
    UserModel userModel = UserModel.fromJson(data['data']);

    return pr(userModel, t);
  }
}
