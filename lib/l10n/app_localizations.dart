import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('pt')];

  /// No description provided for @textWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo!'**
  String get textWelcome;

  /// No description provided for @textWelcomeUser.
  ///
  /// In pt, this message translates to:
  /// **'Seja bem-vindo(a).'**
  String get textWelcomeUser;

  /// No description provided for @textEnsuranceName.
  ///
  /// In pt, this message translates to:
  /// **'TOKYO MARINE'**
  String get textEnsuranceName;

  /// No description provided for @textEnsurance.
  ///
  /// In pt, this message translates to:
  /// **'SEGURADORA'**
  String get textEnsurance;

  /// No description provided for @textWelcomeMessage.
  ///
  /// In pt, this message translates to:
  /// **'Aqui você garante mais segurança para você e sua família em poucos cliques!'**
  String get textWelcomeMessage;

  /// No description provided for @textLogin.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get textLogin;

  /// No description provided for @textRegister.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get textRegister;

  /// No description provided for @textCpf.
  ///
  /// In pt, this message translates to:
  /// **'CPF'**
  String get textCpf;

  /// No description provided for @textPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get textPassword;

  /// No description provided for @textRememberMe.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar sempre'**
  String get textRememberMe;

  /// No description provided for @texFforgotPasswordTitle.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu a senha?'**
  String get texFforgotPasswordTitle;

  /// No description provided for @textShowPassword.
  ///
  /// In pt, this message translates to:
  /// **'Mostrar senha'**
  String get textShowPassword;

  /// No description provided for @textHidePassword.
  ///
  /// In pt, this message translates to:
  /// **'Ocultar senha'**
  String get textHidePassword;

  /// No description provided for @textAccessOnSocialMedias.
  ///
  /// In pt, this message translates to:
  /// **'Acesse através das redes sociais'**
  String get textAccessOnSocialMedias;

  /// No description provided for @textForgotPasswordMessage.
  ///
  /// In pt, this message translates to:
  /// **'A recuperação de senha será conectada à API ou ao Firebase do projeto.'**
  String get textForgotPasswordMessage;

  /// No description provided for @textDemonstrationRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro demonstrativo. A integração com autenticação pode ser conectada aqui.'**
  String get textDemonstrationRegistration;

  /// No description provided for @textQuoteAndHire.
  ///
  /// In pt, this message translates to:
  /// **'Cotar e Contratar'**
  String get textQuoteAndHire;

  /// No description provided for @textMyFamily.
  ///
  /// In pt, this message translates to:
  /// **'Minha Família'**
  String get textMyFamily;

  /// No description provided for @textContracted.
  ///
  /// In pt, this message translates to:
  /// **'Contratados'**
  String get textContracted;

  /// No description provided for @textNoContractedInsurance.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não possui seguros contratados.'**
  String get textNoContractedInsurance;

  /// No description provided for @textAddFamilyMemberTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar membro da família'**
  String get textAddFamilyMemberTooltip;

  /// No description provided for @textAddFamilyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Adicione aqui membros da sua família e compartilhe os seguros com eles.'**
  String get textAddFamilyDescription;

  /// No description provided for @textAddMember.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar membro'**
  String get textAddMember;

  /// No description provided for @textPlaceholderDescription.
  ///
  /// In pt, this message translates to:
  /// **'Esta área está pronta para receber o conteúdo correspondente.'**
  String get textPlaceholderDescription;

  /// No description provided for @textBackToHome.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para Home'**
  String get textBackToHome;

  /// No description provided for @textWebViewLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar o conteúdo dentro do aplicativo.'**
  String get textWebViewLoadError;

  /// No description provided for @textOpenMenu.
  ///
  /// In pt, this message translates to:
  /// **'Abrir menu'**
  String get textOpenMenu;

  /// No description provided for @textNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get textNotifications;

  /// No description provided for @textNoNewNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Você não tem novas notificações.'**
  String get textNoNewNotifications;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
