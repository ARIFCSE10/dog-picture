import 'package:dartz/dartz.dart';
import 'package:dog_picture/app/pages/home/api/home_api.dart';
import 'package:dog_picture/app/shared/constants/enum.dart';
import 'package:dog_picture/app/shared/model/response.dart';

class HomeRepo {
  Future<Either<String, List<String>?>> getDogBreedList() async {
    final HomeApi api = HttpHomeApi();
    // final HomeApi api = MockHomeApi();
    final Either<String, BaseResponse> response = await api.getDogBreedList();
    return response.fold((dynamic error) {
      return Left<String, List<String>?>(error.toString());
    }, (BaseResponse result) {
      if (result.status == ResponseStatus.success.name) {
        return Left<String, List<String>?>(result.message);
      }
      Map<String, dynamic> dogBreeds = result.message;
      return Right<String, List<String>?>(dogBreeds.keys.toList());
    });
  }
}
