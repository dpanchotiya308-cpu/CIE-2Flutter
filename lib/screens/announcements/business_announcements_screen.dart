import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class BusinessAnnouncementItem {
  final String id;
  final String title;
  final String category;
  final String specs;
  final String message;
  final String time;

  BusinessAnnouncementItem({
    required this.id,
    required this.title,
    required this.category,
    required this.specs,
    required this.message,
    required this.time,
  });
}

class BusinessAnnouncementsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final ValueChanged<int>? onNavTap;

  const BusinessAnnouncementsScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onNavTap,
  });

  @override
  State<BusinessAnnouncementsScreen> createState() =>
      _BusinessAnnouncementsScreenState();
}

class _BusinessAnnouncementsScreenState
    extends State<BusinessAnnouncementsScreen> {
  int _currentNavIndex = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _specsController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedCategory = 'CNC Machining & Milling';
  String _selectedFilter = 'All';

  final List<String> _categories = [
    'CNC Machining & Milling',
    'Fiber Laser & Sheet Cutting',
    'Lathe & Turning Job Work',
    'Fabrication & Welding',
    'Quality Assembly & Finishing',
  ];

  final List<String> _filterChips = [
    'All',
    'CNC Machining',
    'Laser Cutting',
    'Lathe & Turning',
  ];

  final List<BusinessAnnouncementItem> _announcements = [
    BusinessAnnouncementItem(
      id: '1',
      title: 'Urgent: Lathe Turning for 500 Units',
      category: 'Lathe & Turning Job Work',
      specs: 'Mild Steel EN8 • ±0.05 mm • 500 pcs',
      message:
          'Looking for verified suppliers with open lathe capacity this week. Immediate material issue available upon confirmation.',
      time: 'Today, 11:20 AM',
    ),
    BusinessAnnouncementItem(
      id: '2',
      title: 'High-Precision 6kW Laser Cutting',
      category: 'Fiber Laser & Sheet Cutting',
      specs: 'SS 304 • 12mm plate • 250 units',
      message:
          'Need clean dross-free laser cutting for stainless steel sheets. Material issued to supplier unit directly.',
      time: 'Yesterday, 3:45 PM',
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _specsController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleBroadcast() {
    final title = _titleController.text.trim();
    final specs = _specsController.text.trim();
    final message = _messageController.text.trim();

    if (title.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a requirement title and details'),
          backgroundColor: Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _announcements.insert(
        0,
        BusinessAnnouncementItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          category: _selectedCategory,
          specs: specs.isNotEmpty ? specs : 'Standard Industrial Grade',
          message: message,
          time: 'Just now',
        ),
      );
      _titleController.clear();
      _specsController.clear();
      _messageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Requirement broadcasted to all verified suppliers!'),
        backgroundColor: Color(0xFF10B981),
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

  List<BusinessAnnouncementItem> get _filteredAnnouncements {
    if (_selectedFilter == 'All') return _announcements;
    return _announcements.where((item) {
      if (_selectedFilter == 'CNC Machining') {
        return item.category.contains('CNC');
      } else if (_selectedFilter == 'Laser Cutting') {
        return item.category.contains('Laser') || item.category.contains('Cutting');
      } else if (_selectedFilter == 'Lathe & Turning') {
        return item.category.contains('Lathe') || item.category.contains('Turning');
      }
      return true;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    if (category.contains('CNC')) {
      return const Color(0xFF1D9BF0);
    } else if (category.contains('Laser')) {
      return const Color(0xFF10B981);
    } else if (category.contains('Lathe')) {
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
                  Navigator.pushNamed(context, '/business-menu');
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
                          'Broadcast job requirements & RFQs to suppliers',
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

                      // Post Requirement Form Card (Figma dark surface #222B3F, border 1.5px #334155)
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
                                  Icons.post_add_rounded,
                                  color: AppColors.primaryYellow,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Post Requirement to Suppliers',
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

                            // Job Title
                            const Text(
                              'Requirement Title',
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
                                  hintText: 'e.g., Lathe Turning for 500 Units',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Work Category Dropdown
                            const Text(
                              'Operation / Process Category',
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

                            // Material & Specs
                            const Text(
                              'Material & Technical Specs',
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
                                controller: _specsController,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: 'e.g., Mild Steel EN8 • ±0.05 mm • 500 pcs',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Details / Notes
                            const Text(
                              'Work Order Details',
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
                                      'Describe job delivery timeline, batch requirements, tolerances...',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Broadcast Button (Figma yellow pill button #FAB115)
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
                                            Icons.send_rounded,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Broadcast to Suppliers',
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
                              'Recent Supplier Broadcasts',
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

                      // Horizontal Filter Chips
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

                      // Feed Cards
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
                              'No active RFQs in this category.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      else
                        ...filteredList.map((item) => _buildBusinessCard(item)),

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

  Widget _buildBusinessCard(BusinessAnnouncementItem item) {
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

          // Specs Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2638),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: Text(
              item.specs,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFFFAB115),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 8),

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
