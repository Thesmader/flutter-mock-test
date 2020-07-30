import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/ui/views/startup/startup_viewmodel.dart';

import '../setup/test_helpers.dart';

void main() {
  group('StartupViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    group('initialise -', () {
      test('When called should check hasUser on SharedPreferences', () async {
        var sharedPreferences = getAndRegisterSharedPreferencesMock();
        var model = StartupViewModel();
        await model.initialise();
        verify(sharedPreferences.hasUser);
      });
      test(
          'When called and hasUser returns true, should call replaceWith Routes.homeView',
          () async {
        var navigationService = getAndRegisterNavigationServiceMock();
        var model = StartupViewModel();
        await model.initialise();
        verify(navigationService.replaceWith(Routes.homeViewRoute));
      });

      test(
          'When called and hasUser returns true, should get currentUser from disk',
          () async {
        var database = getAndRegisterDatabaseMock();
        var model = StartupViewModel();
        await model.initialise();
        verify(database.getCurrentAddress());
      });

      test(
          'When hasUser is true and getCurrentAddress returns null, should navigate to add addressSelection',
          () async {
        getAndRegisterDatabaseMock(returnAddress: false);
        var navigation = getAndRegisterNavigationServiceMock();
        var model = StartupViewModel();
        await model.initialise();
        verify(navigation.replaceWith(Routes.addressSelectionViewRoute));
      });
    });
  });
}
