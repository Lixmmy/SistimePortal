part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class GetLanguageEvent extends LanguageEvent {
  const GetLanguageEvent();
}

class LanguageChangedEvent extends LanguageEvent {
  final AppLanguage appLanguage; // Perbaiki typo di sini

  const LanguageChangedEvent(this.appLanguage);

  @override
  List<Object> get props => [appLanguage];
}