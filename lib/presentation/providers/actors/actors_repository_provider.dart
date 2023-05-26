import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/datasources/actors_datasource_impl.dart';
import 'package:movie_app/infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorsDataSourceImpl());
});
