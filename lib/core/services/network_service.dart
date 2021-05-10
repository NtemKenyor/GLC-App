import 'package:dio/dio.dart';

abstract class NetworkService {
  final Dio dioClient;
  NetworkService(this.dioClient){
    //dioClient.interceptors.add(LoggingInterceptors());
  }
}