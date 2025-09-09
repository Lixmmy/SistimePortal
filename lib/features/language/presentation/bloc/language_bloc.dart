import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/language/domain/entities/app_language.dart';
import 'package:newsistime/features/language/domain/usecases/get_current_local.dart';
import 'package:newsistime/features/language/domain/usecases/save_locale.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetCurrentLocal getCurrentLanguage;
  final SaveLocale setLanguage; 

  LanguageBloc({required this.getCurrentLanguage, required this.setLanguage})
    : super(const LanguageInitial(locale: Locale('id'))) {
    // Sesuaikan dengan locale default Anda
    on<GetLanguageEvent>(_onGetLanguage);
    on<LanguageChangedEvent>(_onLanguageChanged);
  }
  Future<void> _onGetLanguage(
    GetLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading(locale: state.locale));
    Either<MessageExc, Locale> hasilGetCurrentLanguage = await getCurrentLanguage
        .execute();
    hasilGetCurrentLanguage.fold(
      (failure) => emit(
        LanguageError(message: 'Failed to get language', locale: state.locale),
      ), // Sertakan locale saat error
      (locale) => emit(LanguageLoaded(locale: locale)),
    );
  }

  // language_bloc.dart
  // ...
  Future<void> _onLanguageChanged(
    LanguageChangedEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading(locale: state.locale));
    Either<MessageExc, Locale> result = await setLanguage.execute(
      event.appLanguage.locale,
    );
    result.fold(
      (failure) => emit(
        LanguageError(
          message: 'Failed to change language',
          locale: state.locale,
        ),
      ),
      (locale) => emit(
        LanguageChangedSuccess(locale: event.appLanguage.locale),
      ), 
    );
  }
  
}
