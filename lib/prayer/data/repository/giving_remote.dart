import 'package:GLC/prayer/data/remote/giving_remote_datasource.dart';
import 'package:GLC/utils/constants.dart';
import 'package:GLC/utils/sharedPref.dart';

abstract class GivingRepository{
  Future<String> getPaymentUrl({double amount, String type});
}

class GivingRepositoryImpl extends GivingRepository {
  final GivingRemoteDatasource givingRemoteDatasource;
  final SharedPreference _sharedPreference;

  Future<String> getToken()async{
    return await _sharedPreference.getString(Constants.USER_TOKEN, "");
  }

  GivingRepositoryImpl(this.givingRemoteDatasource, this._sharedPreference);

  @override
  Future<String> getPaymentUrl({double amount, String type})async {
    var token = await getToken();
   return givingRemoteDatasource.fetchPaymentUrl(amount: amount,type: type,token: token);
  }



}