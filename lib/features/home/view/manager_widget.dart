import 'package:financial_manager/core/constants/assets.dart';
import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/widgets/icon_svg_widget.dart';
import 'package:financial_manager/features/financial/view/financial_view.dart';
import 'package:financial_manager/features/home/view/home_view.dart';
import 'package:financial_manager/features/profile/profile_view.dart';
import 'package:financial_manager/features/transaction/view/transaction_view.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class ManagerWidget extends StatefulWidget {
  const ManagerWidget({super.key});

  @override
  State<ManagerWidget> createState() => _ManagerWidgetState();
}

class _ManagerWidgetState extends State<ManagerWidget> {
  int _currentIndex = 0;
  int _previousIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: const Alignment(0, -1.5),
              end: Alignment.center,
              colors: context.isDarkMode
                  ? [
                      context.colors.primaryDark.withOpacity(0.5),
                      context.colors.neutralShade600
                    ]
                  : [
                      context.colors.primary.withOpacity(0.7),
                      context.colors.neutralWhite
                    ],
            )),
          ),
          PageView(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Desabilita o swipe entre páginas
            children: const [
              HomeView(),
              FinancialView(),
              TransactionView(),
              ProfileView(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color:
            context.isDarkMode ? context.colors.neutralShade600 : Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8.appHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              label: 'Home',
              iconPath: Assets.home,
            ),
            _buildNavItem(
              index: 1,
              label: 'Finanças',
              iconPath: Assets.graph,
            ),
            _buildNavItem(
              index: 2,
              label: 'Transações',
              iconPath: Assets.coin,
            ),
            _buildNavItem(
              index: 3,
              label: 'Perfil',
              iconPath: Assets.profile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconPath,
  }) {
    final bool isSelected = index == _currentIndex;

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(
            milliseconds: isSelected && _previousIndex != index ? 350 : 0),
        curve: Curves.easeInOutQuint,
        padding: isSelected
            ? EdgeInsets.symmetric(
                horizontal: 8.appWidth, vertical: 4.appHeight)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected
              ? context.isDarkMode
                  ? context.colors.primaryDark
                  : context.colors.secondary
              : null,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: isSelected ? Axis.horizontal : Axis.vertical,
          children: [
            IconSvgWidget(
              asset: iconPath,
              color: isSelected ? Colors.white : Colors.grey,
              size: 24.appIcon,
              onTap: () => _onItemTapped(index),
            ),
            SizedBox(
              height: 4.appHeight,
              width: isSelected ? 4.appWidth : 0,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.appFont,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
