import '../entities/create_queue_entry_entity.dart';

class ValidateQueueEntryUseCase {
  Future<Map<String, String>> call(CreateQueueEntryEntity entry) async {
    final Map<String, String> errors = {};

    if (entry.customerName.trim().isEmpty) {
      errors['customerName'] = 'Customer name is required';
    } else if (entry.customerName.trim().length < 2) {
      errors['customerName'] = 'Name must be at least 2 characters long';
    }

    final cleanPhone = entry.phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (entry.phoneNumber.trim().isEmpty) {
      errors['phoneNumber'] = 'Mobile number is required';
    } else if (cleanPhone.length < 10) {
      errors['phoneNumber'] = 'Enter a valid 10-digit mobile number';
    }

    if (entry.email.trim().isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(entry.email.trim())) {
        errors['email'] = 'Enter a valid email address';
      }
    }

    if (entry.partySize < 1) {
      errors['partySize'] = 'Party size must be at least 1';
    }

    return errors;
  }
}
