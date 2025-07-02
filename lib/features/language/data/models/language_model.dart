
import '../../domain/entities/app_language.dart'; 

class LanguageModel {
  final String languageCode;

  LanguageModel({required this.languageCode});

  
  AppLanguage toEntity() {
    return AppLanguage.fromLanguageCode(languageCode);
  }

  // Factory constructor untuk membuat LanguageModel dari AppLanguage Entity
  factory LanguageModel.fromEntity(AppLanguage entity) {
    return LanguageModel(
      languageCode: entity.locale.languageCode,
    );
  }
}
