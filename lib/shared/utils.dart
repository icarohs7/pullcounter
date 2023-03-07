import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void registerSingleton<T extends Object>(
  FactoryFunc<T> factoryFunc, {
  String? instanceName,
  DisposingFunc<T>? dispose,
}) {
  GetIt.I.registerLazySingleton(
    factoryFunc,
    instanceName: instanceName,
    dispose: dispose,
  );
}

void registerSingletonAsync<T extends Object>(
  FactoryFuncAsync<T> factoryFunc, {
  String? instanceName,
  Iterable<Type>? dependsOn,
  bool? signalsReady,
  DisposingFunc<T>? dispose,
}) {
  GetIt.I.registerSingletonAsync(
    factoryFunc,
    instanceName: instanceName,
    dependsOn: dependsOn,
    signalsReady: signalsReady,
    dispose: dispose,
  );
}

void registerFactory<T extends Object>(
  FactoryFunc<T> factoryFunc, {
  String? instanceName,
}) {
  GetIt.I.registerFactory(
    factoryFunc,
    instanceName: instanceName,
  );
}

Future<void> awaitInjectionDependencies() => GetIt.I.allReady();

// ignore: avoid_classes_with_only_static_members
class Dependencies {
  static Future<void> init([String? subDir]) async {
    Core.setLocator(<T extends Object>() => GetIt.I<T>());
    Core.setPushFn((context, routeName, {params, extra}) {
      GoRouter.of(context).push(
        Uri(path: routeName, queryParameters: params).toString(),
        extra: extra,
      );
    });
    Core.setGoFn((context, routeName, {params, extra}) {
      GoRouter.of(context).go(
        Uri(path: routeName, queryParameters: params).toString(),
        extra: extra,
      );
    });
    Core.setReplaceFn((context, routeName, {params, extra}) {
      GoRouter.of(context).pushReplacement(
        Uri(path: routeName, queryParameters: params).toString(),
        extra: extra,
      );
    });
    Core.setReplaceAllFn((context, routeName, {params, extra}) {
      GoRouter.of(context).go(
        Uri(path: routeName, queryParameters: params).toString(),
        extra: extra,
      );
    });
    Core.setCurrentPathFn((context) => GoRouter.of(context).location);
    Core.setCurrentParamsFn((context) => Core.currentPath(context).toUri().queryParameters);
    Core.setCurrentExtrasFn((context) => ModalRoute.of(context)?.settings.arguments);
    await Hive.initFlutter(subDir);
  }
}
