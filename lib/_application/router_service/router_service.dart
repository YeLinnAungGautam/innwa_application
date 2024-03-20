import "dart:async";

import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:nested/nested.dart";

class RouterService {
  RouterService({
    required BuildContext context,
  }) {
    _context = context;
  }

  final String _providerKey = "providers";

  late BuildContext _context;

  static RouterService of(BuildContext context) {
    return RouterService(context: context);
  }
  Future<void> push<T extends Bloc>(
    String fullPath, {
    T? provider,
    Map<String, dynamic> arguments = const {},
    FutureOr<bool> Function(BuildContext context)? willPush,
    FutureOr<void> Function(BuildContext context)? fallBack,
    bool redirect = false,
  }) async {
    if (willPush != null) {
      final isWillPush = await willPush(_context);

      if (!isWillPush && _context.mounted) {
        await fallBack?.call(_context);
        return;
      }

      if (!_context.mounted) {
        return;
      }
    }

    if (redirect) {
      _context.go(
        fullPath,
        extra: {
          _providerKey: provider == null ? [] : [provider],
          ...arguments,
        },
      );
    } else {
      await _context.push(
        fullPath,
        extra: {
          _providerKey: provider == null ? [] : [provider],
          ...arguments,
        },
      );
    }
  }
  Future<void> pushMultiBloc(
    String fullPath, {
    List<SingleChildWidget> providers = const [],
    Map<String, dynamic> arguments = const {},
    FutureOr<bool> Function(BuildContext context)? willPush,
    FutureOr<void> Function(BuildContext context)? fallBack,
    bool redirect = false,
  }) async {
    if (willPush != null) {
      final isWillPush = await willPush(_context);

      if (!isWillPush && _context.mounted) {
        await fallBack?.call(_context);
        return;
      }

      if (!_context.mounted) {
        return;
      }
    }

    if (redirect) {
      _context.go(
        fullPath,
        extra: {
          _providerKey: providers,
          ...arguments,
        },
      );
    } else {
      await _context.push(
        fullPath,
        extra: {
          _providerKey: providers,
          ...arguments,
        },
      );
    }
  }
  void pop<T extends Object?>({BuildContext? context, T? result}) {
    Navigator.of(context ?? _context).pop(result);
  }
  T firstProvider<T extends Bloc>() {
    final arguments = GoRouterState.of(_context).extra! as Map<String, dynamic>;

    final provider = arguments[_providerKey] as List<Bloc>;
    return provider[0] as T;
  }
  List<SingleChildWidget> allProviders() {
    final arguments = GoRouterState.of(_context).extra! as Map<String, dynamic>;

    final provider = arguments[_providerKey] as List<SingleChildWidget>;
    return provider;
  }

  Map<String, dynamic> getArguments() {
    final arguments = GoRouterState.of(_context).extra! as Map<String, dynamic>
      ..remove(_providerKey);
    return arguments;
  }
}
