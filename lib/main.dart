import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'data/datasources/product_remote_data_source.dart';
import 'domain/repositories/product_repository_impl.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'presentation/pages/splash/splash_screen.dart';
import 'presentation/pages/onboarding/onboarding_screen.dart';
import 'presentation/pages/products/views/products_screen.dart';
import 'presentation/pages/products/viewmodels/product_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        Provider<ProductRemoteDataSource>(
          create: (context) => ProductRemoteDataSourceImpl(
            dio: context.read<Dio>(),
          ),
        ),
        Provider<ProductRepositoryImpl>(
          create: (context) => ProductRepositoryImpl(
            remoteDataSource: context.read<ProductRemoteDataSource>(),
          ),
        ),
        Provider<GetProductsUseCase>(
          create: (context) => GetProductsUseCase(
            repository: context.read<ProductRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider<ProductViewModel>(
          create: (context) => ProductViewModel(
            getProductsUseCase: context.read<GetProductsUseCase>(),
          )..loadProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'Store App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/products': (context) => const ProductsScreen(),
        },
      ),
    );
  }
}