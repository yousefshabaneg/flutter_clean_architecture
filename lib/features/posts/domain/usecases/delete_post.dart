import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepository repository;
  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
