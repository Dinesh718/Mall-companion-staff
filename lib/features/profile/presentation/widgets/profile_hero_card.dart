import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';


class ProfileHeroCard extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileHeroCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C3AED), // Primary Violet
            Color(0xFF316BF3), // Secondary Blue
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(124, 58, 237, 0.15),
            blurRadius: 20.0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Elements
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 96.0,
                      height: 96.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withAlpha(51),
                          width: 4.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(profile.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (profile.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E), // green-500
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.01,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'ID: ${profile.employeeId}',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14.0,
                    color: Colors.white.withAlpha(204),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.white.withAlpha(76)),
                  ),
                  child: Text(
                    profile.role.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.05,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withAlpha(51),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryItem(Icons.location_on, profile.assignment.zone),
                      _buildSummaryItem(Icons.schedule, profile.assignment.shift),
                      _buildSummaryItem(Icons.history, 'Exp: ${profile.assignment.experience}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withAlpha(178), size: 24.0),
        const SizedBox(height: 4.0),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
