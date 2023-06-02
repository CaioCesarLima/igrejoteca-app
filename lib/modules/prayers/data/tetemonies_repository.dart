import 'package:igrejoteca_app/modules/prayers/data/models/testemonie_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class TestemoniesRepository {
  Future<Result<List<TestemonieModel>, Exception>> getTestimonies();
  Future<bool> createTestimony({required String description});
}