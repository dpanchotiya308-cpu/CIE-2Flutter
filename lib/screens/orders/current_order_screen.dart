import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_header.dart';

class OrderItemModel {
  final String id;
  final String companyName;
  final String materialInfo;
  final String lengthInfo;
  final String date;
  final String time;

  OrderItemModel({
    required this.id,
    required this.companyName,
    required this.materialInfo,
    required this.lengthInfo,
    required this.date,
    required this.time,
  });
}

class CurrentOrderScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const CurrentOrderScreen({
    super.key,
    this.onBackTap,
  });

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  final List<OrderItemModel> _orders = [
    OrderItemModel(
      id: '1',
      companyName: 'logo Text Here Technology Pty.Ltd',
      materialInfo: 'Material : - En-D-20 , Round',
      lengthInfo: 'Length :-45.32mm , Pish:-20',
      date: '11/08/2015',
      time: '11:45 AM',
    ),
    OrderItemModel(
      id: '2',
      companyName: 'logo Text Here Technology Pty.Ltd',
      materialInfo: 'Material : - En-D-20 , Round',
      lengthInfo: 'Length :-45.32mm ,Pish:-20',
      date: '11/08/2015',
      time: '11:45 AM',
    ),
    OrderItemModel(
      id: '3',
      companyName: 'logo Text Here Technology Pty.Ltd',
      materialInfo: 'Material : - En-D-20 , Round',
      lengthInfo: 'Length :-45.32mm ,Pish:-20',
      date: '11/08/2015',
      time: '11:45 AM',
    ),
    OrderItemModel(
      id: '4',
      companyName: 'logo Text Here Technology Pty.Ltd',
      materialInfo: 'Material : - En-D-20 , Round',
      lengthInfo: 'Length :-45.32mm ,Pish:-20',
      date: '11/08/2015',
      time: '11:45 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Current Order',
        onBack: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 402),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _orders.isEmpty
                ? const Center(
                    child: Text(
                      'No current orders',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _orders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return _buildOrderCard(order, index);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderItemModel order, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9), // Figma: #D9D9D9
        borderRadius: BorderRadius.circular(17),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Company Name (Underlined) & Clear 'X' Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  order.companyName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _orders.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order dismissed'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Specs: Material Info & Length Info
          Text(
            order.materialInfo,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            order.lengthInfo,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 14),

          // Bottom Row: Date (Left) & Time (Right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.date,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                order.time,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
