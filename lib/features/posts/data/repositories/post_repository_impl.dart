import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/post_model.dart';
import '../../domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/post_local_datasource.dart';
import '../datasources/post_remote_datasource.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl extends PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedPosts = await localDataSource.getCachedPosts();
        return Right(cachedPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel = PostModel(title: post.title, body: post.body);
    return await _getMessage(
      () => remoteDataSource.addPost(postModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(
      () => remoteDataSource.deletePost(id),
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(
      () => remoteDataSource.updatePost(postModel),
    );
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
