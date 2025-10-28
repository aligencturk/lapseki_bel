import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../widgets/announcement_card.dart';
import '../../widgets/language_switcher.dart';
import '../../widgets/header_slider.dart';
import '../discover/discover_screen.dart';
import '../events/events_screen.dart';
import '../ferry/ferry_screen.dart';
import '../baskan/baskan_screen.dart';
import '../kurumsal/kurumsal_screen.dart';
import '../hizmetler/hizmetler_screen.dart';
import '../projeler/projeler_screen.dart';
import '../kentrehberi/kent_rehberi_screen.dart';
import '../basin/basin_screen.dart';
import '../iletisim/iletisim_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lapseki Belediye',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          // Header Bölümü - Slider with Logo
          HeaderSlider(
            images: [
              AppImages.logo,
              AppImages.sahilkusbakisi,
              AppImages.belediyeOnu,
            ],
            titles: [
              'Lapseki Belediyesi',
              'Çanakkale Boğazı',
              'Lapseki Belediyesi Binası',
            ],
          ),

          // Son Duyurular Bölümü
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Son Duyurular',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (viewModel.error != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: AppColors.error,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                viewModel.error!,
                                style: const TextStyle(color: AppColors.error),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => viewModel.loadAnnouncements(),
                                child: const Text('Tekrar Dene'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (viewModel.announcements.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Henüz duyuru yok',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.announcements.length,
                        itemBuilder: (context, index) {
                          final announcement = viewModel.announcements[index];
                          return SizedBox(
                            width: 280,
                            child: AnnouncementCard(
                              title: announcement.title,
                              date: announcement.date,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Navigasyon Butonları
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildNavButton(
                    context,
                    icon: Icons.explore,
                    title: 'Keşfet',
                    gradient: AppColors.greenGradient,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiscoverScreen(),
                        ),
                      );
                    },
                  ),
                  _buildNavButton(
                    context,
                    icon: Icons.event,
                    title: 'Etkinlikler',
                    gradient: AppColors.redGradient,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildNavButton(
                    context,
                    icon: Icons.directions_boat,
                    title: 'Feribot',
                    gradient: AppColors.primaryGradient,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FerryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildNavButton(
                    context,
                    icon: Icons.language,
                    title: 'E-Belediye',
                    gradient: AppColors.redGradient,
                    onTap: () {
                      _launchEBelediye(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.zero,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEBelediye(BuildContext context) async {
    const url = 'https://e-belediye.lapseki.bel.tr';

    try {
      final uri = Uri.parse(url);
      final canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Alternatif: Platform URL açar
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Link açılamadı: $e')));
      }
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(AppImages.logo),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lapseki Belediyesi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primaryBlue),
            title: const Text('Anasayfa'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: AppColors.accentRed),
            title: const Text('Başkan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BaskanScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.business, color: AppColors.primaryBlue),
            title: const Text('Kurumsal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KurumsalScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.accentGreen),
            title: const Text('Hizmetlerimiz'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HizmetlerScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.construction,
              color: AppColors.primaryBlue,
            ),
            title: const Text('Projeler'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjelerScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.location_city,
              color: AppColors.accentGreen,
            ),
            title: const Text('Kent Rehberi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KentRehberiScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper, color: AppColors.accentRed),
            title: const Text('Basın'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BasinScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.contact_mail,
              color: AppColors.primaryBlue,
            ),
            title: const Text('İletişim'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IletisimScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
