import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/store_profile_repository.dart';
import '../models/store_model.dart';

class MockStoreProfileRepository implements StoreProfileRepository {
  @override
  Future<StoreEntity> getStoreProfile() async {
    // Simulate latency delay
    await Future.delayed(const Duration(milliseconds: 600));

    return const StoreModel(
      id: 'nike_flagship',
      name: 'Nike Flagship Store',
      brandName: 'Nike',
      category: 'Fashion & Sports',
      rating: 4.8,
      reviewsCount: 174,
      isOpen: true,
      floor: 'Level 1',
      unitNumber: 'Unit F-104',
      openingTime: '10:00 AM',
      closingTime: '10:00 PM',
      managerName: 'John David',
      wing: 'North Wing',
      visitorsCount: '1.2k',
      activeOffersCount: 5,
      reservationsCount: 12,
      mallName: 'Elite Plaza Mall',
      nearestGate: 'North Gate',
      accessPoint: 'Lift Lobby B',
      walkingTime: '2 mins from Escalator 4',
      mapImageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAO8L60NJrfSEocIZk7kAlTMvkW-Da09zeWik7gd02RhK85zhe2WXlRQwSe5BZUCBZ0vLlUlcXEKzZk80KNLIY34sp1CPKpflxExlW4bal_kqqqbxhKP_Q3gUHnV2V2iNQ9GbgxNdDblBrQKMVFUtt7D_5qea3RVmk1D17Pm_K0FjCiH4k51lrMO0f_tJu55kp_T4UQqlp4SB5hXvjabncpSk124apLEQEKtRbxo6THn2krgXljs9OWkTFJN4CsrK2kn5kxh6dhcQ',
      crowdLevel: 'MEDIUM',
      currentQueueTime: '~4 MINS',
      serviceElevatorsStatus: 'ACTIVE',
      amenities: ['WiFi', 'Digital Pay', 'Trial', 'Styling'],
      phoneNumber: '+1 (555) 012-3456',
      email: 'flagship@nike-elite.com',
      website: 'nike-eliteplaza.com',
      instagramUrl: 'https://instagram.com/nike',
      facebookUrl: 'https://facebook.com/nike',
      twitterUrl: 'https://twitter.com/nike',
      weeklyHours: {
        'Monday': '10:00 AM – 10:00 PM',
        'Tuesday': '10:00 AM – 10:00 PM',
        'Wednesday': '10:00 AM – 10:00 PM',
        'Thursday': '10:00 AM – 10:00 PM',
        'Friday': '10:00 AM – 11:00 PM',
        'Saturday': '10:00 AM – 11:00 PM',
        'Sunday': 'Closed',
      },
      galleryUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuC5ifQk7CshLyqplB2ihNbJwIkwU-rMXr5VTiNBMy-PVV2F0QybH1SqyLQ5obz5tIaZk3h2dWYCPFjUoZmpibMgKify3KVRXTd67AkZdzAaYtfGZDImNC1BE7z-0ryQv5R31ywbxbahUMfIUqXVaDvOLW8e200AAGcy9erc49VvQUFiXyj5aCTPtXF4aiMwanJFDXiWFxCS6EL7W6kackNxkLElNviel55tzZAzcn0vG7PPiRvKxT9ck2oSTYtBdZbzpOEz4XisYQ',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAkFVPfvdzeoPoOLZghfOB6-xPZ5LnnWlEn8bSLslPvicn3z9F6EHEtTvhVXLiEf-RoCMlKqXoU7TtWQSUvJcbuKoKf-5Q6gZ6C7hT-bPuefPyCcsTnFwcC2M200IaFMZznpoMNgZT6wUgG1oYhOgZyAge57BNdYXljFoBwM95J1SXiuHlrlxJQHb0bzMcsQJOEopJppHYhWXyeLZPvq-0vP0xv5PCUpu1aaexPN_N0t-WcxMfbaaqNfxAEcBlS9WHWbKlglfFpTw',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCGfSYmtHhFENhvBAqNL5UTlxFuHcqNRn98Vy0id-U9PJxk5vek1rrUs7UWwmguzVnHfzC_gHaqxjkaL4cBWvl0lWNCjn4J90XuaXMGKF9k8dvLlRMHhJEZt_tndx4Wq_7hf-8t_rMRGSjM1xzeZaW6HP1qvIoZPqIHP73B-Z7MikLPVVkA-3eHz6ZUecPeVhOE2Br1XHmmn0yTuzBOHyneqg1q2onJ5F0hQuYdDN5PZaHr6VEYW1wBfSSmwJV7STLarPEFg1Y1pw',
      ],
      logoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCzfP7eACOw4ImAGJ4PCZhmgHw5Bk2JmechQKPh3Rnf-QY2f7lzf0d7jSKv-8LYKHR_GMKbajD4rW4gYO-LHRe0h1bOvOqxB-Q3zYYCi_mcHduEH5JfRCRcZZDqf6fbEkbKxDzId1i9wff1JTTsNMwvd1q8zztA4r7WpqfPyHOWLK-FZeb7TSjQ7MXHcPWabh47X3geGsFsXnkKHV5-wvOaj1y2ZuLHAsUVy4hSyD_zLn5vG4U4uBwNVG-X-faNpZRsEYdSxQDo_g',
      bannerUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuC-EZhClocgHJZSKt-p2qxVEoaEkYwbpHXGj9nDZNoia8KfalctAexN2Nelsh5fpvVI3sy-z9dWBL3pE_Q-WFi_IWAuPsvXvyK1bpEEPeSkQyWPrXRmEwe78IaJPhdT4rEphEA5P9YuK8cxc4XL5gve623BsB3SQCiBYgAP4S9loiEqdV-8x-mkMP95AAjE0GG9d5dc9AJJRt_302ATzmYUkyJb0Eu5ldBS6ukIF26nTmeatmhK-0jZnrDMSPheLW_Og4blCWQy6A',
      lastUpdated: 'Today, 09:42 AM',
    );
  }
}
