// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;

import 'features/product/data/datasources/product_local_data_source.dart'
    as _i210;
import 'features/product/data/repositories/product_repository_impl.dart'
    as _i531;
import 'features/product/domain/entities/product.dart' as _i735;
import 'features/product/domain/repositories/product_repository.dart' as _i841;
import 'features/product/domain/usecases/get_products.dart' as _i591;
import 'features/product/domain/usecases/save_product.dart' as _i217;
import 'features/product/presentation/bloc/product_bloc.dart' as _i363;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> setupDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final databaseModule = _$DatabaseModule();
  await gh.singletonAsync<_i779.Database>(
    () => databaseModule.provideDatabase(),
    preResolve: true,
  );
  await gh.singletonAsync<_i979.Box<_i735.Product>>(
    () => databaseModule.provideProductBox(),
    preResolve: true,
  );
  gh.factory<_i210.ProductLocalDataSource>(
      () => _i210.ProductLocalDataSourceImpl(
            database: gh<_i779.Database>(),
            productBox: gh<_i979.Box<_i735.Product>>(),
          ));
  gh.factory<_i841.ProductRepository>(() => _i531.ProductRepositoryImpl(
      localDataSource: gh<_i210.ProductLocalDataSource>()));
  gh.factory<_i217.SaveProduct>(
      () => _i217.SaveProduct(gh<_i841.ProductRepository>()));
  gh.factory<_i591.GetProducts>(
      () => _i591.GetProducts(gh<_i841.ProductRepository>()));
  gh.factory<_i363.ProductBloc>(() => _i363.ProductBloc(
        getProducts: gh<_i591.GetProducts>(),
        saveProduct: gh<_i217.SaveProduct>(),
      ));
  return getIt;
}

class _$DatabaseModule extends _i464.DatabaseModule {}
