import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  Widget customWhen({
    required WidgetRef ref,
    required Refreshable<Future<T>> refreshable,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = false,
    bool skipError = false,
    required Widget Function(T data) data,
    Widget Function(Object error, StackTrace stackTrace)? error,
    Widget Function()? loading,
  }) {
    return when(
      loading: () => Center(child: loading?.call() ?? const CircularProgressIndicator()),
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipError: skipError,
      data: data,
      error: (err, trace) =>
          error?.call(error, trace) ??
              Image.asset(
                "assets/images/img2.png",
                height: 200.h,
                color: Colors.green,
              ),
    );
  }
}
