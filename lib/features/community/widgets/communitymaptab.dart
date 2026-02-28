import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────

class GardenPlant {
  final String name;
  final Color color;
  final IconData icon;
  final bool isEmpty;

  const GardenPlant({
    required this.name,
    required this.color,
    required this.icon,
    this.isEmpty = false,
  });
}

class ActivityItem {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}

class CommunityMember {
  final String name;
  final String username;
  final String role;
  final String location;
  final double trustScore;
  final int sustainLevel;
  final Color avatarColor;
  final String avatarInitials;
  final String emoji;
  final List<String> currentlyGrowing;
  final List<GardenPlant> gardenPlants;
  final bool isVerified;

  const CommunityMember({
    required this.name,
    required this.username,
    required this.role,
    required this.location,
    required this.trustScore,
    required this.sustainLevel,
    required this.avatarColor,
    required this.avatarInitials,
    required this.emoji,
    required this.currentlyGrowing,
    required this.gardenPlants,
    this.isVerified = false,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────────────────────────────────────

final List<CommunityMember> communityMembers = [
  CommunityMember(
    name: 'Mike L.',
    username: 'Mike_Garden88',
    role: 'Community Member',
    location: 'Ampang, Selangor',
    trustScore: 4.7,
    sustainLevel: 3,
    avatarColor: const Color(0xFF4A9E7A),
    avatarInitials: 'ML',
    emoji: '🌿',
    isVerified: true,
    currentlyGrowing: ['Tomatoes', 'Basil', '+2 More'],
    gardenPlants: [
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.eco),
      GardenPlant(name: 'Chili', color: Color(0xFFE67E22), icon: Icons.local_fire_department),
      GardenPlant(name: 'Mint', color: Color(0xFF2ECC71), icon: Icons.spa),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.grass),
    ],
  ),
  CommunityMember(
    name: 'Sarah J.',
    username: 'Sarah_Garden23',
    role: 'Community Mentor',
    location: 'Seattle, WA',
    trustScore: 5.0,
    sustainLevel: 4,
    avatarColor: const Color(0xFF8B6914),
    avatarInitials: 'SJ',
    emoji: '🌳',
    isVerified: true,
    currentlyGrowing: ['Tomatoes', 'Herbs', '+3 More'],
    gardenPlants: [
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Lettuce', color: Color(0xFF27AE60), icon: Icons.energy_savings_leaf),
      GardenPlant(name: 'Carrots', color: Color(0xFFE67E22), icon: Icons.pets),
      GardenPlant(name: 'Chili', color: Color(0xFFE74C3C), icon: Icons.local_fire_department),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.touch_app, isEmpty: true),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.grass),
    ],
  ),
  CommunityMember(
    name: 'David K.',
    username: 'DavidKGarden',
    role: 'Urban Farmer',
    location: 'Subang Jaya, Selangor',
    trustScore: 4.5,
    sustainLevel: 3,
    avatarColor: const Color(0xFF2980B9),
    avatarInitials: 'DK',
    emoji: '🥬',
    currentlyGrowing: ['Spinach', 'Kale', '+1 More'],
    gardenPlants: [
      GardenPlant(name: 'Spinach', color: Color(0xFF27AE60), icon: Icons.eco),
      GardenPlant(name: 'Kale', color: Color(0xFF2ECC71), icon: Icons.grass),
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
      GardenPlant(name: 'Pepper', color: Color(0xFFE67E22), icon: Icons.local_fire_department),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.spa),
    ],
  ),
  CommunityMember(
    name: 'Elena R.',
    username: 'ElenaRoots',
    role: 'Herb Specialist',
    location: 'Cheras, KL',
    trustScore: 4.8,
    sustainLevel: 4,
    avatarColor: const Color(0xFF8E44AD),
    avatarInitials: 'ER',
    emoji: '🌺',
    isVerified: true,
    currentlyGrowing: ['Lavender', 'Rosemary', '+2 More'],
    gardenPlants: [
      GardenPlant(name: 'Lavender', color: Color(0xFF9B59B6), icon: Icons.spa),
      GardenPlant(name: 'Rosemary', color: Color(0xFF27AE60), icon: Icons.eco),
      GardenPlant(name: 'Mint', color: Color(0xFF2ECC71), icon: Icons.grass),
      GardenPlant(name: 'Thyme', color: Color(0xFF8E44AD), icon: Icons.local_florist),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.energy_savings_leaf),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
    ],
  ),
  CommunityMember(
    name: 'Chris M.',
    username: 'ChrisMGrower',
    role: 'Beginner Gardener',
    location: 'Petaling Jaya, Selangor',
    trustScore: 4.1,
    sustainLevel: 2,
    avatarColor: const Color(0xFF16A085),
    avatarInitials: 'CM',
    emoji: '🌱',
    currentlyGrowing: ['Tomatoes', 'Lettuce'],
    gardenPlants: [
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Lettuce', color: Color(0xFF27AE60), icon: Icons.eco),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
    ],
  ),
  CommunityMember(
    name: 'Lisa T.',
    username: 'LisaTerrarium',
    role: 'Intermediate',
    location: 'Kajang, Selangor',
    trustScore: 4.6,
    sustainLevel: 3,
    avatarColor: const Color(0xFFC0392B),
    avatarInitials: 'LT',
    emoji: '🍅',
    currentlyGrowing: ['Tomatoes', 'Peppers', '+1 More'],
    gardenPlants: [
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Pepper', color: Color(0xFFE67E22), icon: Icons.local_fire_department),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.spa),
      GardenPlant(name: 'Mint', color: Color(0xFF2ECC71), icon: Icons.grass),
      GardenPlant(name: 'Chili', color: Color(0xFFE74C3C), icon: Icons.local_fire_department),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
    ],
  ),
  CommunityMember(
    name: 'Tom B.',
    username: 'TomBotanist',
    role: 'Expert Grower',
    location: 'Shah Alam, Selangor',
    trustScore: 4.9,
    sustainLevel: 5,
    avatarColor: const Color(0xFF1ABC9C),
    avatarInitials: 'TB',
    emoji: '🌾',
    isVerified: true,
    currentlyGrowing: ['Wheat', 'Corn', '+4 More'],
    gardenPlants: [
      GardenPlant(name: 'Wheat', color: Color(0xFFF39C12), icon: Icons.grass),
      GardenPlant(name: 'Corn', color: Color(0xFFF1C40F), icon: Icons.eco),
      GardenPlant(name: 'Tomato', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Basil', color: Color(0xFF27AE60), icon: Icons.spa),
      GardenPlant(name: 'Pepper', color: Color(0xFFE67E22), icon: Icons.local_fire_department),
      GardenPlant(name: 'Mint', color: Color(0xFF2ECC71), icon: Icons.grass),
    ],
  ),
  CommunityMember(
    name: 'Anna W.',
    username: 'AnnaWildcraft',
    role: 'Wildcrafting Expert',
    location: 'Klang, Selangor',
    trustScore: 4.7,
    sustainLevel: 4,
    avatarColor: const Color(0xFFD35400),
    avatarInitials: 'AW',
    emoji: '🍃',
    isVerified: true,
    currentlyGrowing: ['Elderflower', 'Nettle', '+2 More'],
    gardenPlants: [
      GardenPlant(name: 'Elderflower', color: Color(0xFF9B59B6), icon: Icons.local_florist),
      GardenPlant(name: 'Nettle', color: Color(0xFF27AE60), icon: Icons.eco),
      GardenPlant(name: 'Rosehip', color: Color(0xFFE74C3C), icon: Icons.circle),
      GardenPlant(name: 'Hawthorn', color: Color(0xFFE67E22), icon: Icons.park),
      GardenPlant(name: 'Dandelion', color: Color(0xFFF1C40F), icon: Icons.spa),
      GardenPlant(name: 'Empty', color: Colors.grey, icon: Icons.add, isEmpty: true),
    ],
  ),
];

final List<ActivityItem> recentActivities = [
  ActivityItem(
    title: 'New plot started at North Sector',
    subtitle: '2 hours ago • Community Garden',
    description: 'Sarah Jenkins just broke ground on her heirloom tomato project.',
    icon: Icons.eco_rounded,
    iconColor: const Color(0xFF0D6E57),
    iconBg: const Color(0xFFE8F5F1),
  ),
  ActivityItem(
    title: 'Weekend Workshop: Soil Health',
    subtitle: 'Tomorrow at 10:00 AM • Main Pavilion',
    description: 'Join Mentor Dave for a hands-on session on organic composting.',
    icon: Icons.people_alt_rounded,
    iconColor: const Color(0xFF0D6E57),
    iconBg: const Color(0xFFE8F5F1),
  ),
  ActivityItem(
    title: 'Irrigation Update',
    subtitle: 'Yesterday • System Alert',
    description: 'Zone 4 irrigation schedule adjusted for the upcoming heatwave.',
    icon: Icons.water_drop_rounded,
    iconColor: const Color(0xFF0D6E57),
    iconBg: const Color(0xFFE8F5F1),
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
//  MAIN COMMUNITY TAB
// ─────────────────────────────────────────────────────────────────────────────

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: Column(
          children: [
            const _TopTabBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _SectionHeader(
                      title: 'Community Members',
                      action: 'See all',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),
                    _MembersGrid(),
                    const SizedBox(height: 28),
                    _SectionHeader(
                      title: 'Recent Activity',
                      action: 'View all',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),
                    _ActivityList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  TOP TAB BAR
// ─────────────────────────────────────────────────────────────────────────────

class _TopTabBar extends StatefulWidget {
  const _TopTabBar();

  @override
  State<_TopTabBar> createState() => _TopTabBarState();
}

class _TopTabBarState extends State<_TopTabBar> {
  int _selected = 0;
  final _tabs = ['Green Valley Community'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: List.generate(_tabs.length, (i) {
              final isActive = i == _selected;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selected = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.transparent,
                    child: Text(
                      _tabs[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                        color: isActive
                            ? const Color(0xFF0D6E57)
                            : const Color(0xFF8A9E97),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Stack(
            children: [
              Container(height: 2.5, color: const Color(0xFFEEEEEE)),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: MediaQuery.of(context).size.width /
                    _tabs.length *
                    _selected,
                child: Container(
                  width: MediaQuery.of(context).size.width / _tabs.length,
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D6E57),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SECTION HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback? onTap;

  const _SectionHeader(
      {required this.title, required this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.3,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D6E57),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MEMBERS GRID
// ─────────────────────────────────────────────────────────────────────────────

class _MembersGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MembersRow(members: communityMembers.sublist(0, 4)),
        const SizedBox(height: 18),
        _MembersRow(members: communityMembers.sublist(4, 8)),
      ],
    );
  }
}

class _MembersRow extends StatelessWidget {
  final List<CommunityMember> members;
  const _MembersRow({required this.members});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: members.map((m) => _MemberAvatar(member: m)).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MEMBER AVATAR
// ─────────────────────────────────────────────────────────────────────────────

class _MemberAvatar extends StatelessWidget {
  final CommunityMember member;
  const _MemberAvatar({required this.member});

  void _openProfile(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      builder: (_) => _MemberProfileSheet(member: member),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openProfile(context),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: member.avatarColor.withOpacity(0.15),
              border: Border.all(
                color: member.avatarColor.withOpacity(0.35),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: member.avatarColor.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    member.avatarInitials,
                    style: TextStyle(
                      color: member.avatarColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                // Emoji badge
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        member.emoji,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ),
                // Verified
                if (member.isVerified)
                  Positioned(
                    right: 0,
                    top: 2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2ECC71),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 11),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Text(
            member.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E2D),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MEMBER PROFILE BOTTOM SHEET  (draggable)
// ─────────────────────────────────────────────────────────────────────────────

class _MemberProfileSheet extends StatelessWidget {
  final CommunityMember member;
  const _MemberProfileSheet({required this.member});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.45, 0.72, 0.95],
      builder: (ctx, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollCtrl,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // ── Avatar ─────────────────────────────────────
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: member.avatarColor.withOpacity(0.18),
                              border: Border.all(
                                  color: member.avatarColor.withOpacity(0.4),
                                  width: 2.5),
                            ),
                            child: Center(
                              child: Text(
                                member.avatarInitials,
                                style: TextStyle(
                                  color: member.avatarColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          if (member.isVerified)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2ECC71),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_rounded,
                                    color: Colors.white, size: 16),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        '${member.username} ${member.emoji}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${member.role} • ${member.location}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // ── Action Buttons ─────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: _ActionButton(
                              label: 'Follow',
                              icon: Icons.person_add_rounded,
                              isPrimary: true,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _ActionButton(
                              label: 'Message',
                              icon: Icons.chat_bubble_outline_rounded,
                              isPrimary: false,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Stats ──────────────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: _StatBox(
                              icon: Icons.star_rounded,
                              iconColor: const Color(0xFFF39C12),
                              value: member.trustScore.toStringAsFixed(1),
                              label: 'TRUST SCORE',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatBox(
                              icon: Icons.eco_rounded,
                              iconColor: const Color(0xFF27AE60),
                              value: 'Lvl ${member.sustainLevel}',
                              label: 'SUSTAINABILITY',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // ── Virtual Garden View ────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Virtual Garden View',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0D6E57),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAF8),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: const Color(0xFFDFEDE6), width: 1),
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.88,
                          ),
                          itemCount: member.gardenPlants.length,
                          itemBuilder: (_, i) =>
                              _GardenCell(plant: member.gardenPlants[i]),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // ── Currently Growing ──────────────────────────
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Currently Growing',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: member.currentlyGrowing.map((label) {
                            final isMore = label.startsWith('+');
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isMore
                                    ? const Color(0xFFF0F0F0)
                                    : const Color(0xFFE6F5EE),
                                borderRadius: BorderRadius.circular(22),
                                border: isMore
                                    ? Border.all(color: Colors.grey[300]!)
                                    : Border.all(
                                        color: const Color(0xFF0D6E57)
                                            .withOpacity(0.25)),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isMore
                                      ? Colors.grey[600]
                                      : const Color(0xFF0D6E57),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  GARDEN CELL
// ─────────────────────────────────────────────────────────────────────────────

class _GardenCell extends StatelessWidget {
  final GardenPlant plant;
  const _GardenCell({required this.plant});

  @override
  Widget build(BuildContext context) {
    if (plant.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFDDDDDD),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.touch_app_rounded, color: Colors.grey[400], size: 26),
            const SizedBox(height: 4),
            Text(
              'Empty',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: plant.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: plant.color.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: plant.color.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(plant.icon, color: plant.color, size: 22),
          ),
          const SizedBox(height: 5),
          Text(
            plant.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: plant.color.withOpacity(0.85),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ACTION BUTTON
// ─────────────────────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF0D6E57) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary
              ? null
              : Border.all(color: const Color(0xFFDDDDDD), width: 1.5),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF0D6E57).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF555555),
              size: 17,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF555555),
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STAT BOX
// ─────────────────────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9.5,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ACTIVITY LIST
// ─────────────────────────────────────────────────────────────────────────────

class _ActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: recentActivities
            .map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ActivityCard(activity: a),
                ))
            .toList(),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityItem activity;
  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: activity.iconBg,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(activity.icon, color: activity.iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity.subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}