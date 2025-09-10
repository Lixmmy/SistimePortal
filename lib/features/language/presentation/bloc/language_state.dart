part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  final Locale locale; // Tambahkan properti locale
  const LanguageState(this.locale); // Tambahkan constructor

  @override
  List<Object?> get props => [locale];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({Locale locale = const Locale('id')}) : super(locale); // Set default locale
}

class LanguageLoading extends LanguageState {
  const LanguageLoading({required Locale locale}) : super(locale); // Tambahkan locale
}

class LanguageLoaded extends LanguageState {
  @override
  // ignore: overridden_fields
  final Locale locale;

  const LanguageLoaded({required this.locale}) : super(locale);

  @override
  List<Object> get props => [locale];
}

class LanguageError extends LanguageState {
  final String message;
  @override
  // ignore: overridden_fields
  final Locale locale; // Tambahkan locale untuk menjaga state sebelumnya

  const LanguageError({required this.message, required this.locale}) : super(locale);

  @override
  List<Object> get props => [message, locale];
}
class LanguageChangedSuccess extends LanguageLoaded { // Atau bisa jadi state terpisah
  const LanguageChangedSuccess({required super.locale});

  @override
  List<Object> get props => [locale];
}