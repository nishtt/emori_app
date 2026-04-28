import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get languageSubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change colors and appearance'**
  String get themeSubtitle;

  /// No description provided for @moodPacks.
  ///
  /// In en, this message translates to:
  /// **'Mood Packs'**
  String get moodPacks;

  /// No description provided for @moodPackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your emoji style'**
  String get moodPackSubtitle;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get dailyReminder;

  /// No description provided for @dailyReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to log your mood'**
  String get dailyReminderSubtitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get logoutSubtitle;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get logoutConfirm;

  /// No description provided for @mo.
  ///
  /// In en, this message translates to:
  /// **'MO'**
  String get mo;

  /// No description provided for @tu.
  ///
  /// In en, this message translates to:
  /// **'TU'**
  String get tu;

  /// No description provided for @we.
  ///
  /// In en, this message translates to:
  /// **'WE'**
  String get we;

  /// No description provided for @th.
  ///
  /// In en, this message translates to:
  /// **'TH'**
  String get th;

  /// No description provided for @fr.
  ///
  /// In en, this message translates to:
  /// **'FR'**
  String get fr;

  /// No description provided for @sa.
  ///
  /// In en, this message translates to:
  /// **'SA'**
  String get sa;

  /// No description provided for @su.
  ///
  /// In en, this message translates to:
  /// **'SU'**
  String get su;

  /// No description provided for @howAreYou.
  ///
  /// In en, this message translates to:
  /// **'How are you?'**
  String get howAreYou;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calm;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// No description provided for @tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get tired;

  /// No description provided for @anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get anxious;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @noEntries.
  ///
  /// In en, this message translates to:
  /// **'No entries for this month'**
  String get noEntries;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get deleteTitle;

  /// No description provided for @deleteMessage.
  ///
  /// In en, this message translates to:
  /// **'The note will be permanently removed.'**
  String get deleteMessage;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteConfirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @changeMood.
  ///
  /// In en, this message translates to:
  /// **'Change mood'**
  String get changeMood;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind today?'**
  String get noteHint;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @entries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get entries;

  /// No description provided for @avgScore.
  ///
  /// In en, this message translates to:
  /// **'Avg Score'**
  String get avgScore;

  /// No description provided for @moodFlow.
  ///
  /// In en, this message translates to:
  /// **'Mood Flow'**
  String get moodFlow;

  /// No description provided for @moodStability.
  ///
  /// In en, this message translates to:
  /// **'Mood stability'**
  String get moodStability;

  /// No description provided for @soundscape.
  ///
  /// In en, this message translates to:
  /// **'Soundscape'**
  String get soundscape;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @appThemes.
  ///
  /// In en, this message translates to:
  /// **'App Themes'**
  String get appThemes;

  /// No description provided for @chooseMoodPack.
  ///
  /// In en, this message translates to:
  /// **'Choose Mood Pack'**
  String get chooseMoodPack;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @notRegistered.
  ///
  /// In en, this message translates to:
  /// **'Not registered yet?'**
  String get notRegistered;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get loginError;

  /// No description provided for @loginEmptyFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password.'**
  String get loginEmptyFields;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields.'**
  String get fillAllFields;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak Password'**
  String get weakPassword;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordLengthError;

  /// No description provided for @passwordsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match!'**
  String get passwordsNoMatch;

  /// No description provided for @registrationError.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get registrationError;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login now'**
  String get loginNow;

  /// No description provided for @resetInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send you a link to reset your password'**
  String get resetInstructions;

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send Link'**
  String get sendLink;

  /// No description provided for @emptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Empty email'**
  String get emptyEmail;

  /// No description provided for @enterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to reset password.'**
  String get enterEmailToReset;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for this email, a reset link has been sent.'**
  String get resetLinkSent;

  /// No description provided for @pickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a time'**
  String get pickTime;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to record your mood!'**
  String get notificationBody;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @quote1.
  ///
  /// In en, this message translates to:
  /// **'It\'s no use going back to yesterday, because I was a different person then.'**
  String get quote1;

  /// No description provided for @quote2.
  ///
  /// In en, this message translates to:
  /// **'A great day to be yourself.'**
  String get quote2;

  /// No description provided for @quote3.
  ///
  /// In en, this message translates to:
  /// **'Little steps lead you to a big future'**
  String get quote3;

  /// No description provided for @quote4.
  ///
  /// In en, this message translates to:
  /// **'There\'s nothing wrong with letting people who love you help you.'**
  String get quote4;

  /// No description provided for @quote5.
  ///
  /// In en, this message translates to:
  /// **'Find what you\'d die for and then live for it.'**
  String get quote5;

  /// No description provided for @quote6.
  ///
  /// In en, this message translates to:
  /// **'Shoot for the moon; even  if you miss, you\'ll land among the stars.'**
  String get quote6;

  /// No description provided for @quote7.
  ///
  /// In en, this message translates to:
  /// **'Feelings are just visitors, let them come and go.'**
  String get quote7;

  /// No description provided for @quote8.
  ///
  /// In en, this message translates to:
  /// **'The only way to do great work is to love what you do.'**
  String get quote8;

  /// No description provided for @quote9.
  ///
  /// In en, this message translates to:
  /// **'In the middle of every difficulty lies opportunity.'**
  String get quote9;

  /// No description provided for @quote10.
  ///
  /// In en, this message translates to:
  /// **'If you look for the light, you can often find it. But if you look for the dark, that is all you will ever see.'**
  String get quote10;

  /// No description provided for @quote11.
  ///
  /// In en, this message translates to:
  /// **'In the darkest of times, hope is all we have to believe in. It is the source of our inner strength.'**
  String get quote11;

  /// No description provided for @quote12.
  ///
  /// In en, this message translates to:
  /// **'Let your smile change the world, but don\'t let the world change your smile.'**
  String get quote12;

  /// No description provided for @quote13.
  ///
  /// In en, this message translates to:
  /// **'The greatest glory in living lies not in never falling, but in rising every time we fall.'**
  String get quote13;

  /// No description provided for @quote14.
  ///
  /// In en, this message translates to:
  /// **'Every day may not be good, but there\'s something good in every day.'**
  String get quote14;

  /// No description provided for @quote15.
  ///
  /// In en, this message translates to:
  /// **'You can still be lost on the right path.'**
  String get quote15;

  /// No description provided for @quote16.
  ///
  /// In en, this message translates to:
  /// **'The things we do do things to us.'**
  String get quote16;

  /// No description provided for @quote17.
  ///
  /// In en, this message translates to:
  /// **'Bad days are part of a good life, too.'**
  String get quote17;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @activity_walk.
  ///
  /// In en, this message translates to:
  /// **'walk'**
  String get activity_walk;

  /// No description provided for @activity_sport.
  ///
  /// In en, this message translates to:
  /// **'sport'**
  String get activity_sport;

  /// No description provided for @activity_water.
  ///
  /// In en, this message translates to:
  /// **'water'**
  String get activity_water;

  /// No description provided for @activity_medicine.
  ///
  /// In en, this message translates to:
  /// **'medicine'**
  String get activity_medicine;

  /// No description provided for @activity_healthy_food.
  ///
  /// In en, this message translates to:
  /// **'healthy food'**
  String get activity_healthy_food;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @activity_good_sleep.
  ///
  /// In en, this message translates to:
  /// **'good sleep'**
  String get activity_good_sleep;

  /// No description provided for @activity_bad_sleep.
  ///
  /// In en, this message translates to:
  /// **'bad sleep'**
  String get activity_bad_sleep;

  /// No description provided for @activity_early_wake.
  ///
  /// In en, this message translates to:
  /// **'early wake'**
  String get activity_early_wake;

  /// No description provided for @activity_nap.
  ///
  /// In en, this message translates to:
  /// **'nap'**
  String get activity_nap;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @activity_sunny.
  ///
  /// In en, this message translates to:
  /// **'sunny'**
  String get activity_sunny;

  /// No description provided for @activity_rain.
  ///
  /// In en, this message translates to:
  /// **'rain'**
  String get activity_rain;

  /// No description provided for @activity_cloudy.
  ///
  /// In en, this message translates to:
  /// **'cloudy'**
  String get activity_cloudy;

  /// No description provided for @activity_snow.
  ///
  /// In en, this message translates to:
  /// **'snow'**
  String get activity_snow;

  /// No description provided for @activity_windy.
  ///
  /// In en, this message translates to:
  /// **'windy'**
  String get activity_windy;

  /// No description provided for @hobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get hobbies;

  /// No description provided for @activity_reading.
  ///
  /// In en, this message translates to:
  /// **'reading'**
  String get activity_reading;

  /// No description provided for @activity_music.
  ///
  /// In en, this message translates to:
  /// **'music'**
  String get activity_music;

  /// No description provided for @activity_drawing.
  ///
  /// In en, this message translates to:
  /// **'drawing'**
  String get activity_drawing;

  /// No description provided for @activity_games.
  ///
  /// In en, this message translates to:
  /// **'games'**
  String get activity_games;

  /// No description provided for @work_or_study.
  ///
  /// In en, this message translates to:
  /// **'Work or Study'**
  String get work_or_study;

  /// No description provided for @activity_study.
  ///
  /// In en, this message translates to:
  /// **'study'**
  String get activity_study;

  /// No description provided for @activity_work.
  ///
  /// In en, this message translates to:
  /// **'work'**
  String get activity_work;

  /// No description provided for @activity_deadline.
  ///
  /// In en, this message translates to:
  /// **'deadline'**
  String get activity_deadline;

  /// No description provided for @activity_meeting.
  ///
  /// In en, this message translates to:
  /// **'meeting'**
  String get activity_meeting;

  /// No description provided for @activity_junk_food.
  ///
  /// In en, this message translates to:
  /// **'junk food'**
  String get activity_junk_food;

  /// No description provided for @activity_alcohol.
  ///
  /// In en, this message translates to:
  /// **'alcohol'**
  String get activity_alcohol;

  /// No description provided for @activity_smoking.
  ///
  /// In en, this message translates to:
  /// **'smoking'**
  String get activity_smoking;

  /// No description provided for @activity_doomscrolling.
  ///
  /// In en, this message translates to:
  /// **'doomscrolling'**
  String get activity_doomscrolling;

  /// No description provided for @social_activity.
  ///
  /// In en, this message translates to:
  /// **'Social activity'**
  String get social_activity;

  /// No description provided for @activity_friends.
  ///
  /// In en, this message translates to:
  /// **'friends'**
  String get activity_friends;

  /// No description provided for @activity_family.
  ///
  /// In en, this message translates to:
  /// **'family'**
  String get activity_family;

  /// No description provided for @activity_argument.
  ///
  /// In en, this message translates to:
  /// **'argument'**
  String get activity_argument;

  /// No description provided for @activity_awkward_situation.
  ///
  /// In en, this message translates to:
  /// **'awkward situation'**
  String get activity_awkward_situation;

  /// No description provided for @activity_staying_at_home.
  ///
  /// In en, this message translates to:
  /// **'staying at home'**
  String get activity_staying_at_home;

  /// No description provided for @monthlyActivities.
  ///
  /// In en, this message translates to:
  /// **'Monthly activities'**
  String get monthlyActivities;

  /// No description provided for @usuallyWithMood.
  ///
  /// In en, this message translates to:
  /// **'Usually with'**
  String get usuallyWithMood;

  /// No description provided for @noActivitiesForMood.
  ///
  /// In en, this message translates to:
  /// **'No activities for the selected mood'**
  String get noActivitiesForMood;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
