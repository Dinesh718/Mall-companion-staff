import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class SearchQueueUseCase {
  final QueueRepository repository;

  SearchQueueUseCase(this.repository);

  Future<List<QueueEntity>> call(String query, {List<QueueEntity>? localList}) async {
    if (localList != null) {
      if (query.isEmpty) return localList;
      final lowercaseQuery = query.toLowerCase();
      return localList.where((item) =>
        item.customerName.toLowerCase().contains(lowercaseQuery) ||
        item.token.toLowerCase().contains(lowercaseQuery) ||
        item.phoneNumber.contains(lowercaseQuery) ||
        item.id.toLowerCase().contains(lowercaseQuery)
      ).toList();
    }
    return repository.searchQueue(query);
  }
}
