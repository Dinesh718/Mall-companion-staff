import 'package:equatable/equatable.dart';
import 'queue_filter.dart';
import 'queue_sort_option.dart';

class QueueSearchRequest extends Equatable {
  final String query;
  final QueueFilter filter;
  final QueueSortOption sort;

  const QueueSearchRequest({
    required this.query,
    required this.filter,
    required this.sort,
  });

  @override
  List<Object?> get props => [query, filter, sort];
}
