import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:newsistime/features/language/data/datasources/language_local_data_source.dart';
import 'package:newsistime/features/language/domain/repositories/app_language_repository.dart';
import '../../../../core/error/failure.dart';

class AppLanguageRepositoryImplementation extends AppLanguageRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  AppLanguageRepositoryImplementation({required this.languageLocalDataSource});

  @override
  Future<Either<Failure, Locale>> getCurrentLocale() async {
    try {
      final languageCodeString = await languageLocalDataSource
          .getSavedLanguage();

      if (languageCodeString != null && languageCodeString.isNotEmpty) {
        return Right(Locale(languageCodeString));
      } else {
        return const Right(Locale('id'));
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> saveLocale(Locale locale) async {
    try {
      await languageLocalDataSource.saveLanguage(locale.languageCode);
      // ignore: void_checks
      return const Right(unit);
    } catch (e) {
      return Left(Failure());
    }
  }
}
