part of 'language_bloc.dart'; // Penting: Ini adalah bagian dari language_bloc.dart

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageChanged extends LanguageEvent {
  final Langugage;

  const LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}
