import 'package:flutter/foundation.dart';
import '../../domain/entities/store_entity.dart';

@immutable
sealed class StoreProfileState {
  const StoreProfileState();
}

class StoreProfileInitial extends StoreProfileState {
  const StoreProfileInitial();
}

class StoreProfileLoading extends StoreProfileState {
  const StoreProfileLoading();
}

class StoreProfileLoaded extends StoreProfileState {
  final StoreEntity store;

  const StoreProfileLoaded(this.store);
}

class StoreProfileError extends StoreProfileState {
  final String errorMessage;

  const StoreProfileError(this.errorMessage);
}
