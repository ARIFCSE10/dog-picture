import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dog_picture/app/shared/dio/dio.dart';
import 'package:dog_picture/app/shared/model/response.dart';

abstract class HomeApi {
  Future<Either<String, BaseResponse>> getDogBreedList();
}

class HttpHomeApi implements HomeApi {
  @override
  Future<Either<String, BaseResponse>> getDogBreedList() async {
    const String breedUrl = 'breeds/list/all';

    try {
      final Response<dynamic> response = await dio.get(
        breedUrl,
      );
      final BaseResponse profileResponse = BaseResponse.fromJson(response.data);
      return Right<String, BaseResponse>(profileResponse);
    } catch (e) {
      return Left<String, BaseResponse>(e.toString());
    }
  }
}

class MockHomeApi implements HomeApi {
  @override
  Future<Either<String, BaseResponse>> getDogBreedList() async {
    await Future<bool>.delayed(const Duration(seconds: 1));
    return Right<String, BaseResponse>(BaseResponse.fromRawJson('''
        '''));
  }
}
