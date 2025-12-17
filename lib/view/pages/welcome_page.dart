import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/welcome_viewmodel.dart';
import '../../model/landing_content_model.dart';
import '../../shared/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;

    final viewModel = Provider.of<WelcomeViewModel>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF8F1), Colors.white, Color(0xFFFFF3E0)],
          ),
        ),
        child: Stack(
          children: [
            if (isDesktop) ...[
              Positioned(
                top: -100,
                left: -100,
                child: _buildBackgroundBlob(
                  300,
                  AppColors.primaryOrange.withOpacity(0.05),
                ),
              ),
              Positioned(
                bottom: 200,
                right: -50,
                child: _buildBackgroundBlob(
                  400,
                  AppColors.primaryOrange.withOpacity(0.03),
                ),
              ),
            ],

            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  HeroSection(isDesktop: isDesktop, viewModel: viewModel),
                  const SizedBox(height: 80),
                  StatsSection(stats: viewModel.stats),
                  const SizedBox(height: 120),
                  const PartnerTicker(),
                  const SizedBox(height: 120),
                  FeaturesSection(features: viewModel.features),
                  const SizedBox(height: 120),
                  const FooterSection(),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(child: NavBar(viewModel: viewModel)),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBackgroundBlob(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      // Efek blur halus
      boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
    ),
  );
}

// ================== COMPONENTS ==================

// --- 1. Modern Navbar ---
class NavBar extends StatelessWidget {
  final WelcomeViewModel viewModel;
  const NavBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 14,
      ),
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Logo
          Image.asset(
            'assets/images/logo.png',
            height: 50,
            fit: BoxFit.contain,
          ),

          isMobile
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.primaryOrange,
                    size: 30,
                  ),
                )
              : ElevatedButton(
                  onPressed: () => viewModel.navigateToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Login Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
    );
  }
}

// --- 2. Hero Section (Re-designed Orange) ---
class HeroSection extends StatelessWidget {
  final bool isDesktop;
  final WelcomeViewModel viewModel;

  const HeroSection({
    super.key,
    required this.isDesktop,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // 🔹 Scaling rules
        final double imageScale =
            maxWidth < 600 ? 0.7 : maxWidth < 900 ? 0.85 : 1.0;

        final double circleSize =
            maxWidth < 600 ? 260 : maxWidth < 900 ? 320 : 380;

        final double outerCircleSize = circleSize + 40;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 80 : 24,
            vertical: 40,
          ),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ================= LEFT CONTENT =================
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: Column(
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    _buildBadge(),
                    const SizedBox(height: 24),

                    Text(
                      "Ignite Your Future\nwith Great Career\nOpportunities",
                      style: TextStyle(
                        fontSize: isDesktop ? 56 : 36,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        letterSpacing: -1.5,
                      ),
                      textAlign:
                          isDesktop ? TextAlign.left : TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "An integrated platform that connects top Universitas Ciputra talents with trusted industry partners.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.grey,
                        height: 1.6,
                      ),
                      textAlign:
                          isDesktop ? TextAlign.left : TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () =>
                          viewModel.navigateToFindJobs(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Find Jobs Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (!isDesktop) const SizedBox(height: 80),

              // ================= RIGHT VISUAL =================
              Expanded(
                flex: isDesktop ? 6 : 0,
                child: SizedBox(
                  height: isDesktop ? 520 : 420,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Outer Glow
                      Container(
                        width: outerCircleSize,
                        height: outerCircleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.primaryOrange.withOpacity(0.05),
                        ),
                      ),

                      // Main Circle
                      Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xFFFF6B00),
                              Color(0xFFFFB74D),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF6B00).withOpacity(0.3),
                              blurRadius: 60,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                      ),

                      // Decorative Dots
                      Positioned(
                        top: circleSize * 0.15,
                        right: circleSize * 0.1,
                        child: _buildDecorativeDot(
                          14,
                          AppColors.primaryOrange.withOpacity(0.6),
                        ),
                      ),

                      Positioned(
                        bottom: circleSize * 0.2,
                        left: circleSize * 0.1,
                        child: _buildDecorativeDot(
                          10,
                          AppColors.primaryOrange.withOpacity(0.4),
                        ),
                      ),

                      // Character Image
                      Transform.scale(
                        scale: imageScale,
                        child: Image.asset(
                          'assets/images/welcome.png',
                          width: circleSize * 1.6,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Floating Cards
                      Positioned(
                        left: 0,
                        top: 100,
                        child: _GlassCard(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primaryOrange,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Interview Scheduled",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: 30,
                        bottom: 100,
                        child: _GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Skill Match",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "98%",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primaryOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightOrange.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryOrange.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.local_fire_department_rounded,
              color: AppColors.primaryOrange, size: 18),
          SizedBox(width: 8),
          Text(
            "Official UC Career Platform",
            style: TextStyle(
              color: AppColors.darkOrange,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}


Widget _buildDecorativeDot(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: child,
    );
  }
}

// --- 3. Partner Ticker ---
class PartnerTicker extends StatefulWidget {
  const PartnerTicker({super.key});

  @override
  State<PartnerTicker> createState() => _PartnerTickerState();
}

class _PartnerTickerState extends State<PartnerTicker> {
  final ScrollController _scrollController = ScrollController();

  final partners = [
    'assets/images/partners/gojek.png',
    'assets/images/partners/tokopedia.png',
    'assets/images/partners/traveloka.png',
    'assets/images/partners/bca.png',
    'assets/images/partners/indofood.png',
    'assets/images/partners/microsoft.png',
    'assets/images/partners/google.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    await Future.delayed(const Duration(seconds: 1));

    while (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 20),
        curve: Curves.linear,
      );

      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Our Top Company Partners",
            style: TextStyle(
              color: AppColors.grey.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 30),

          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: partners.map((logo) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _PartnerLogo(imagePath: logo),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerLogo extends StatelessWidget {
  final String imagePath;
  const _PartnerLogo({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 60,
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

// --- 4. Feature Section (Orange Style) ---
class FeaturesSection extends StatelessWidget {
  final List<FeatureItemModel> features;
  const FeaturesSection({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Comprehensive Features",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryOrange,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Everything you need for\nyour career journey",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 50),
        Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: features
              .map((feature) => _FeatureItem(feature: feature))
              .toList(),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final FeatureItemModel feature;
  const _FeatureItem({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.background, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightOrange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(feature.icon, color: AppColors.darkOrange, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature.description,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    height: 1.5,
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

// --- 6. Stats Section ---
class StatsSection extends StatelessWidget {
  final List<StatItemModel> stats;
  const StatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 32 : 48,
          horizontal: isMobile ? 20 : 60,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B00),
              Color(0xFFFF8F1F),
              Color.fromARGB(255, 255, 182, 86),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFF6B00).withOpacity(0.4),
              blurRadius: 35,
              offset: const Offset(0, 18),
            ),
          ],
        ),

        child: isMobile
            ? Column(children: _buildStatItems(isMobile))
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildStatItems(isMobile),
              ),
      ),
    );
  }

  List<Widget> _buildStatItems(bool isMobile) {
    return stats.map((stat) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 0),
        child: Column(
          children: [
            Text(
              stat.number,
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              stat.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

// --- 7. Simple Footer ---
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "© 2025 UC HUB - Universitas Ciputra",
            style: TextStyle(color: AppColors.grey.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
