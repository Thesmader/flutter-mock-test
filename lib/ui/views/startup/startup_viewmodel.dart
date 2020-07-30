import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/services/permissions_service.dart';
import 'package:my_app/services/shared_preferences_service.dart';
import 'package:my_app/system/app_database.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AppDatabase _database = locator<AppDatabase>();
  Future initialise() async {
    var hasUser = _sharedPreferencesService.hasUser;
    if (hasUser) {
      var currentAddress = _database.getCurrentAddress();
      if (currentAddress == null) {
        await _navigationService.replaceWith(Routes.addressSelectionViewRoute);
      } else {
        await _navigationService.replaceWith(Routes.homeViewRoute);
      }
    }
  }
}
