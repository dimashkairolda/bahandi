import 'dart:async';

import 'package:Etry/components/scan_equipment_page.dart';
import 'package:Etry/detailed_inspection/detailed_inspection_widget.dart';
import 'package:Etry/detailed_inspection_done/detailed_inspection_done_widget.dart';
import 'package:Etry/inspections/inspections_widget.dart';
import 'package:Etry/inspections_time_list/inspections_time_list_widget.dart';
import 'package:Etry/media_viewer/media_viewer_widget.dart';
import 'package:Etry/video_player/video_player_widget.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BahandiAuthUser? initialUser;
  BahandiAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BahandiAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,

      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : AuthLoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : AuthLoginWidget(),
        ),
        FFRoute(
          name: AuthLoginWidget.routeName,
          path: AuthLoginWidget.routePath,
          builder: (context, params) => AuthLoginWidget(),
        ),
        FFRoute(
          name: CreateDefectWidget.routeName,
          path: CreateDefectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectWidget(
            workable: params.getParam<String>(
              'workable',
              ParamType.String,
              isList: true,
            ),
            equipId: params.getParam(
              'equipId',
              ParamType.int,
            ),
            departmentid: params.getParam(
              'departmentid',
              ParamType.int,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            files: params.getParam<dynamic>(
              'files',
              ParamType.JSON,
              isList: true,
            ),
            ispravil: params.getParam(
              'ispravil',
              ParamType.bool,
            ),
            priority: params.getParam(
              'priority',
              ParamType.bool,
            ),
            equip: params.getParam(
              'equip',
              ParamType.String,
            ),
            typeId: params.getParam(
              'typeId',
              ParamType.int,
            ),
            formid: params.getParam(
              'formid',
              ParamType.int,
            ),
            inventory: params.getParam(
              'inventory',
              ParamType.String,
            ),
            area: params.getParam(
              'area',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DefectsWidget.routeName,
          path: DefectsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Defects')
              : DefectsWidget(),
        ),
        FFRoute(
          name: DetailedDefectsOfflineWidget.routeName,
          path: DetailedDefectsOfflineWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedDefectsOfflineWidget(
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'profilePage')
              : ProfilePageWidget(),
        ),
        FFRoute(
          name: EquipmentsTreeWidget.routeName,
          path: EquipmentsTreeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EquipmentsTreeWidget(),
        ),
        FFRoute(
          name: ScanEquipmentPageWidget.routeName,
          path: ScanEquipmentPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ScanEquipmentPageWidget(),
        ),
        FFRoute(
          name: EquipmentsDetailedWidget.routeName,
          path: EquipmentsDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EquipmentsDetailedWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: MainPageWidget.routeName,
          path: MainPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MainPageWidget(),
        ),
        FFRoute(
          name: DraftWidget.routeName,
          path: DraftWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DraftWidget(),
        ),
        FFRoute(
          name: InspectionsCopyWidget.routeName,
          path: InspectionsCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsCopyWidget(
            
          ),
        ),
        FFRoute(
          name: PdfviewerWidget.routeName,
          path: PdfviewerWidget.routePath,
          requireAuth: true,
          builder: (context, params) => PdfviewerWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            viewer: params.getParam(
              'viewer',
              ParamType.String,
            ),
            extension: params.getParam(
              'extension',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ChooseassetWidget.routeName,
          path: ChooseassetWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseassetWidget(),
        ),
        FFRoute(
          name: BarcodeWidget.routeName,
          path: BarcodeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => BarcodeWidget(),
        ),
        FFRoute(
          name: EditDefecWidget.routeName,
          path: EditDefecWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditDefecWidget(
            id: params.getParam(
              'id',
              ParamType.int,
            ),
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: CreateAccount1Widget.routeName,
          path: CreateAccount1Widget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateAccount1Widget(),
        ),
        FFRoute(
          name: SotrudnikiWidget.routeName,
          path: SotrudnikiWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SotrudnikiWidget(),
        ),
        FFRoute(
          name: ServiceActWidget.routeName,
          path: ServiceActWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ServiceActWidget(),
        ),
        FFRoute(
          name: SelectPodryadchikWidget.routeName,
          path: SelectPodryadchikWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SelectPodryadchikWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: SelectIspolnitelWidget.routeName,
          path: SelectIspolnitelWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SelectIspolnitelWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: DetailedServiceActsWidget.routeName,
          path: DetailedServiceActsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedServiceActsWidget(
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: CreateServiceActWidget.routeName,
          path: CreateServiceActWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateServiceActWidget(),
        ),
        FFRoute(
          name: SelectDefectWidget.routeName,
          path: SelectDefectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SelectDefectWidget(),
        ),
        FFRoute(
          name: CreateDefectCopyWidget.routeName,
          path: CreateDefectCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectCopyWidget(
            workable: params.getParam<String>(
              'workable',
              ParamType.String,
              isList: true,
            ),
            equipId: params.getParam(
              'equipId',
              ParamType.int,
            ),
            departmentid: params.getParam(
              'departmentid',
              ParamType.int,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            files: params.getParam<dynamic>(
              'files',
              ParamType.JSON,
              isList: true,
            ),
            ispravil: params.getParam(
              'ispravil',
              ParamType.bool,
            ),
            priority: params.getParam(
              'priority',
              ParamType.bool,
            ),
            typeId: params.getParam(
              'typeId',
              ParamType.int,
            ),
            formId: params.getParam(
              'formId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: PdfviewerCopyWidget.routeName,
          path: PdfviewerCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => PdfviewerCopyWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ChooseequipWidget.routeName,
          path: ChooseequipWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseequipWidget(),
        ),
        FFRoute(
          name: ObjectsAreasWidget.routeName,
          path: ObjectsAreasWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const ObjectsAreasWidget(),
        ),
        FFRoute(
          name: AreaEquipmentsSelectWidget.routeName,
          path: AreaEquipmentsSelectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AreaEquipmentsSelectWidget(
            areaId: params.getParam(
              'areaId',
              ParamType.int,
            ),
            parentObjectId: params.getParam(
              'parentObjectId',
              ParamType.int,
            ),
            areaTitle: params.getParam(
              'areaTitle',
              ParamType.String,
            ),
            initialSelectedIds: params.getParam<int>(
              'initialSelectedIds',
              ParamType.int,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: AreaResponsiblesSelectWidget.routeName,
          path: AreaResponsiblesSelectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AreaResponsiblesSelectWidget(
            areaId: params.getParam(
              'areaId',
              ParamType.int,
            ),
            parentObjectId: params.getParam(
              'parentObjectId',
              ParamType.int,
            ),
            areaTitle: params.getParam(
              'areaTitle',
              ParamType.String,
            ),
            initialSelectedIds: params.getParam<int>(
              'initialSelectedIds',
              ParamType.int,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: CreateEquipmentWidget.routeName,
          path: CreateEquipmentWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateEquipmentWidget(
            barcode: params.getParam(
              'barcode',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SitesListWidget.routeName,
          path: SitesListWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const SitesListWidget(),
        ),
        FFRoute(
          name: SiteEquipmentListWidget.routeName,
          path: SiteEquipmentListWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SiteEquipmentListWidget(
            areaId: params.getParam(
              'areaId',
              ParamType.int,
            ),
            areaTitle: params.getParam(
              'areaTitle',
              ParamType.String,
            ),
            objectTitle: params.getParam(
              'objectTitle',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddEquipmentSimpleWidget.routeName,
          path: AddEquipmentSimpleWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AddEquipmentSimpleWidget(
            areaId: params.getParam(
              'areaId',
              ParamType.int,
            ),
            areaTitle: params.getParam(
              'areaTitle',
              ParamType.String,
            ),
            objectTitle: params.getParam(
              'objectTitle',
              ParamType.String,
            ),
            categoryCode: params.getParam(
              'categoryCode',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditEquipmentSimpleWidget.routeName,
          path: EditEquipmentSimpleWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditEquipmentSimpleWidget(
            equipmentJson: params.getParam(
              'equipmentJson',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: MediaViewerWidget.routeName,
          path: MediaViewerWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MediaViewerWidget(
            data: params.getParam(
              'data',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: InspectionsWidget.routeName,
          path: InspectionsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Inspections')
              : InspectionsWidget(),
        ),
        FFRoute(
          name: InspectionsTimeListWidget.routeName,
          path: InspectionsTimeListWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsTimeListWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.DateTime,
            ),
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: DetailedInspectionWidget.routeName,
          path: DetailedInspectionWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedInspectionWidget(
            name: params.getParam(
              'name',
              ParamType.JSON,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
            nextIndex: params.getParam(
              'nextIndex',
              ParamType.int,
            ),
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: DetailedInspectionDoneWidget.routeName,
          path: DetailedInspectionDoneWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedInspectionDoneWidget(
            name: params.getParam(
              'name',
              ParamType.JSON,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
            nextIndex: params.getParam(
              'nextIndex',
              ParamType.int,
            ),
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: VideoPlayerWidget.routeName,
          path: VideoPlayerWidget.routePath,
          requireAuth: true,
          builder: (context, params) => VideoPlayerWidget(
            url: params.getParam(
              'url',
              ParamType.String,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver,FirebaseScreenObserver(),AppMetricaObserver(),],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/authLogin';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Welcome_page.png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child, name: state.name);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
class AppMetricaObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Получаем имя экрана
    final screenName = route.settings.name;
    print('Navigated to screen: $screenName');
    if (screenName != null) {
      // Используем метод ...WithMap и передаем Map вторым аргументом без имени
      AppMetrica.reportEvent(screenName);
      
    }
  }
}

class FirebaseScreenObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = route.settings.name;
    
    if (screenName != null) {
      // Отправляем стандартное событие просмотра экрана
      FirebaseAnalytics.instance.logEvent(
        name: screenName,
      );
      print('Firebase Analytics: logged screen $screenName');
    }
  }

  // Можно также добавить didPop, если хотите отслеживать возвраты назад
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = previousRoute?.settings.name;
    if (screenName != null) {
      FirebaseAnalytics.instance.logScreenView(screenName: screenName);
    }
  }
}

