import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/language/domain/repositories/app_language_repository.dart';

class GetCurrentLocal {
  final AppLanguageRepository appLanguageRepository;
  const GetCurrentLocal(this.appLanguageRepository);

  Future<Either<MessageExc, Locale>> execute() async {
    return await appLanguageRepository.getCurrentLocale();
  }
}
