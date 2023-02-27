import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

@injectable
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<_ThemeChanged>(_onThemeChanged);
    on<_ThemeTileChanged>(_onThemeTileChanged);
  }

  void _onThemeChanged(_ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: state.settingsValue!));
  }

  void _onThemeTileChanged(_ThemeTileChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(settingsValue: event.settingsValue));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
