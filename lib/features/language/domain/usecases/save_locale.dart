import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/language/domain/repositories/app_language_repository.dart';

class SaveLocale {
  final AppLanguageRepository appLanguageRepository;
  const SaveLocale(this.appLanguageRepository);

  Future<Either<MessageExc, Locale>> execute(Locale locale) async {
    final result = await appLanguageRepository.saveLocale(locale);
    return result.map((_) => locale);
  }
}
