// lib/features/language/domain/repositories/language_repository.dart

import 'package:dartz/dartz.dart'; // Untuk Either
import 'package:flutter/material.dart'; // Untuk Locale
import 'package:newsistime/core/error/failure.dart';


abstract class AppLanguageRepository {
  Future<Either<Failure, Locale>> getCurrentLocale();
  Future<Either<Failure, void>> saveLocale(Locale locale);
}