part of 'language_bloc.dart'; // Penting: Ini adalah bagian dari language_bloc.dart

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}
