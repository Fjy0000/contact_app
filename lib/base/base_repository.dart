import 'base_response.dart';

typedef OnFailed<int, String> = void Function(int code, String message,
    {BaseResponse? response});
typedef OnSuccess<T> = void Function(T value);

class BaseRespository {}
