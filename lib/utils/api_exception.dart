import 'package:dio/dio.dart';

class ApiException {
  static String exceptionMsg = '';
  static String normalExceptionMsg = '';
  String getExceptionMessages(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        exceptionMsg = 'Bad Response or Inputed credentials are incorrect';

        return exceptionMsg;
      case DioExceptionType.badCertificate:
        exceptionMsg = 'Bad cerificate Error';
        return exceptionMsg;
      case DioExceptionType.connectionError:
        exceptionMsg = 'Connection Error, check your internet connectivity';
        return exceptionMsg;
      case DioExceptionType.connectionTimeout:
        exceptionMsg = 'Connection Timeout, check your internet connectivity';
        return exceptionMsg;
      case DioExceptionType.cancel:
        exceptionMsg = 'Request Cancelled, check url or parameters are invalid';
        return exceptionMsg;
      case DioExceptionType.receiveTimeout:
        exceptionMsg = 'Recieve Timeout, check url or parameters are invalid';
        return exceptionMsg;
      // case DioExceptionType.unknown:
      //  return
      default:
        exceptionMsg = 'Unknown Error, something went wrong';
        return exceptionMsg;
    }
  }
}
