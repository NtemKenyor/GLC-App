import 'package:GLC/core/services/network_service.dart';
import 'package:GLC/utils/constants.dart';
import 'package:dio/dio.dart';

abstract class GivingRemoteDatasource extends NetworkService {
  GivingRemoteDatasource(Dio dioClient) : super(dioClient);

  fetchPaymentUrl({String token, double amount, String type});

}

class GivingRemoteDatasourceImpl extends GivingRemoteDatasource {
  GivingRemoteDatasourceImpl(Dio dioClient) : super(dioClient);

  @override
  fetchPaymentUrl({String token, double amount, String type})async {
    print("Your token is  $token");
    try {
      var _data = {
        'amount': amount,
        'type': type
      };
      var response = await dioClient
          .post("${Constants.BASE_URL}api/payments", data: _data);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {

      } else {
        print('left');
        //return Left(ServerFailure());
      }
    } catch (error) {
      print('error');
      print(error.response.toString());
      throw error.response;
    }

  }



}