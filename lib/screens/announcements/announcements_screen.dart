import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class AnnouncementItem {
  final String id;
  final String title;
  final String category;
  final String message;
  final String time;

  AnnouncementItem({
    required this.id,
    required this.title,
    required this.category,
    required this.message,
    required this.time,
  });
}

class AnnouncementsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final ValueChanged<int>? onNavTap;

  const AnnouncementsScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onNavTap,
  });

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  int _currentNavIndex = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedCategory = 'Machine Capacity Available';
  String _selectedFilter = 'All';

  final List<String> _categories = [
    'Machine Capacity Available',
    'Material Stock Update',
    'Job Schedule & Delivery Notice',
    'Special Workshop Pricing',
    'General Maintenance Notice',
  ];

  final List<String> _filterChips = [
    'All',
    'Machine Capacity',
    'Material Stock',
    'Delivery Notice',
  ];

  final List<AnnouncementItem> _announcements = [
    AnnouncementItem(
      id: '1',
      title: 'CNC Lathe Slot Open for Next Week',
      category: 'Machine Capacity Available',
      message:
          'We have open capacity for 5-axis CNC lathe jobs starting this Monday. Quick turnaround guaranteed for batch orders.',
      time: 'Today, 10:30 AM',
    ),
    AnnouncementItem(
      id: '2',
      title: 'Fresh Mild Steel EN8 Stock Received',
      category: 'Material Stock Update',
      message:
          '500 kg of EN-D-20 round bars in stock. Immediate processing available for verified business work orders.',
      time: 'Yesterday, 4:15 PM',
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleBroadcast() {
    final title = _titleController.text.trim();
    final message = _messageController.text.trim();

    if (title.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter announcement title and message'),
          backgroundColor: Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _announcements.insert(
        0,
        AnnouncementItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          category: _selectedCategory,
          message: message,
          time: 'Just now',
        ),
      );
      _titleController.clear();
      _messageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcement broadcasted to all businesses!'),
        backgroundColor: Color(0xFFFAB115),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleDelete(String id) {
    setState(() {
      _announcements.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcement removed'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  List<AnnouncementItem> get _filteredAnnouncements {
    if (_selectedFilter == 'All') return _announcements;
    return _announcements.where((item) {
      if (_selectedFilter == 'Machine Capacity') {
        return item.category.contains('Machine Capacity');
      } else if (_selectedFilter == 'Material Stock') {
        return item.category.contains('Material Stock');
      } else if (_selectedFilter == 'Delivery Notice') {
        return item.category.contains('Delivery Notice') ||
            item.category.contains('Schedule');
      }
      return true;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    if (category.contains('Machine Capacity')) {
      return const Color(0xFF1D9BF0);
    } else if (category.contains('Material Stock')) {
      return const Color(0xFF10B981);
    } else if (category.contains('Pricing')) {
      return const Color(0xFFFAB115);
    } else {
      return const Color(0xFFA855F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredAnnouncements;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Announcements',
        onBack: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFFF5B800),
              size: 34,
            ),
            onPressed: widget.onMenuTap ??
                () {
                  Navigator.pushNamed(context, '/menu');
                },
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          widget.onNavTap?.call(index);
        },
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Subtitle
                      const Center(
                        child: Text(
                          'Broadcast updates & capacity to business clients',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Post Form Card (Figma dark surface: #222B3F, border: 1.5px #334155)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.add_alert_rounded,
                                  color: AppColors.primaryYellow,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Post New Announcement',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Title Input
                            const Text(
                              'Announcement Title',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2638),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF334155),
                                  width: 1.5,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _titleController,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: 'e.g., CNC Milling Slot Open Next Week',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Category Dropdown
                            const Text(
                              'Category',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2638),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF334155),
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedCategory,
                                  isExpanded: true,
                                  dropdownColor: const Color(0xFF222B3F),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF94A3B8),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  items: _categories.map((cat) {
                                    return DropdownMenuItem<String>(
                                      value: cat,
                                      child: Text(cat),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        _selectedCategory = val;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Message Input
                            const Text(
                              'Announcement Message',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 96,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2638),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF334155),
                                  width: 1.5,
                                ),
                              ),
                              child: TextField(
                                controller: _messageController,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText:
                                      'Enter announcement details for business clients...',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Broadcast Button (Figma yellow pill button: #FAB115)
                            Center(
                              child: GestureDetector(
                                onTap: _handleBroadcast,
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryYellow,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryYellow
                                            .withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.campaign_rounded,
                                            color: Colors.black,
                                            size: 22,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Broadcast to Businesses',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Header with Filter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Recent Broadcasts',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${filteredList.length} total',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Horizontal Filter Chips (Figma style)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _filterChips.map((chip) {
                            final isSelected = _selectedFilter == chip;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedFilter = chip;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryYellow
                                        : const Color(0xFF222B3F),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryYellow
                                          : const Color(0xFF334155),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    chip,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: isSelected ? Colors.black : Colors.white,
                                      fontSize: 12,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Announcements Feed Cards
                      if (filteredList.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222B3F),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF334155),
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'No broadcasts found in this category.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      else
                        ...filteredList.map((item) => _buildAnnouncementCard(item)),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(AnnouncementItem item) {
    final catColor = _getCategoryColor(item.category);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Category Tag
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: catColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    item.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: catColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Delete button
              GestureDetector(
                onTap: () => _handleDelete(item.id),
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFF94A3B8),
                  size: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            item.title,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          // Message
          Text(
            item.message,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFFCBD5E1),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          // Divider
          const Divider(color: Color(0xFF334155), height: 1),

          const SizedBox(height: 8),

          // Time with icon
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: Color(0xFF64748B),
                size: 13,
              ),
              const SizedBox(width: 4),
              Text(
                item.time,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
