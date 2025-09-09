// lib/features/language/domain/repositories/language_repository.dart

import 'package:dartz/dartz.dart'; // Untuk Either
import 'package:flutter/material.dart'; // Untuk Locale
import 'package:newsistime/core/error/message_exc.dart';


abstract class AppLanguageRepository {
  Future<Either<MessageExc, Locale>> getCurrentLocale();
  Future<Either<MessageExc, void>> saveLocale(Locale locale);
}
