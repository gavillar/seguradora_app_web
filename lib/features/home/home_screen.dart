import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/enums/home_product_enum.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/features/home/models/menu_entry.dart';
import 'package:seguro_app/features/home/widgets/home_product_webview_screen.dart';
import 'package:seguro_app/features/home/widgets/home_dashboard_content.dart';
import 'package:seguro_app/features/home/widgets/home_menu_components.dart';
import 'package:seguro_app/features/home/widgets/home_top_bar.dart';
import 'package:seguro_app/features/home/widgets/home_welcome_banner.dart';
import 'package:seguro_app/features/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.userName = 'Caio Mariano', super.key});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: TKSColors.panel,
        title: const Text('Sair da conta?'),
        content: const Text('Tem certeza de que deseja sair do aplicativo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: TKSColors.mint,
              foregroundColor: TKSColors.background,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !mounted) return;

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  static const _menuItems = <HomeMenuEntry>[
    HomeMenuEntry('Home / Seguros', Icons.home_outlined),
    HomeMenuEntry('Minhas Contratações', Icons.description_outlined),
    HomeMenuEntry('Meus Sinistros', Icons.car_crash_outlined),
    HomeMenuEntry('Minha Família', Icons.people_outline),
    HomeMenuEntry('Meus Bens', Icons.inventory_2_outlined),
    HomeMenuEntry('Pagamentos', Icons.credit_card_outlined),
    HomeMenuEntry('Coberturas', Icons.shield_outlined),
    HomeMenuEntry('Validar Boleto', Icons.qr_code_scanner),
    HomeMenuEntry('Telefones Importantes', Icons.phone_in_talk_outlined),
    HomeMenuEntry('Configurações', Icons.settings_outlined),
  ];

  String _selectedMenu = 'Home / Seguros';
  final List<String> _familyMembers = [];

  bool get _isWide => MediaQuery.sizeOf(context).width >= 1000;

  void _selectMenu(String title) {
    setState(() => _selectedMenu = title);
    if (!_isWide && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _addFamilyMember() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: TKSColors.panel,
        title: const Text('Adicionar membro da família'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZÀ-ÿ\s'-]")),
          ],
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Nome',
            hintText: 'Ex.: Ana Mariano',
          ),
          onSubmitted: (value) => Navigator.pop(dialogContext, value.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, nameController.text.trim()),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
    // nameController.dispose();

    if (name == null || name.isEmpty || !mounted) return;
    setState(() => _familyMembers.add(name));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name foi adicionado à sua família.')),
    );
  }

  void _openProduct(HomeProduct product) async {
    if (kIsWeb) {
      await launchUrl(Uri.parse(product.url), webOnlyWindowName: '_blank');
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => HomeProductWebViewScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = _isWide;
    return Scaffold(
      backgroundColor: TKSColors.background,
      drawer: wide
          ? null
          : Drawer(
              backgroundColor: TKSColors.navigationBackground,
              child: _buildSideMenu(),
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (wide) SizedBox(width: 252, child: _buildSideMenu()),
            Expanded(
              child: Column(
                children: [
                  HomeTopBar(isWide: wide),
                  HomeWelcomeBanner(userName: widget.userName),
                  Expanded(
                    child: _selectedMenu == 'Home / Seguros'
                        ? HomeDashboardContent(
                            familyMembers: _familyMembers,
                            onAddFamilyMember: _addFamilyMember,
                            onOpenProduct: _openProduct,
                          )
                        : HomeMenuPlaceholder(
                            title: _selectedMenu,
                            onBack: () => _selectMenu('Home / Seguros'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideMenu() {
    return Material(
      color: TKSColors.navigationBackground,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 14, 18),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/customer.png'),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Minha conta',
                          style: TextStyle(
                            fontSize: 11,
                            color: TKSColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Colors.white12, height: 1),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final selected = item.title == _selectedMenu;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 2,
                    ),
                    child: ListTile(
                      dense: true,
                      selected: selected,
                      selectedTileColor: TKSColors.mint.withValues(alpha: 0.13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Icon(
                        item.icon,
                        size: 20,
                        color: selected ? TKSColors.mint : TKSColors.muted,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 12,
                          color: selected ? Colors.white : Colors.white70,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                      onTap: () => _selectMenu(item.title),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Color.fromRGBO(255, 255, 255, 0.122),
                height: 1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(9, 8, 9, 12),
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: const Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: TKSColors.logout,
                  ),
                  title: const Text(
                    'Sair da conta',
                    style: TextStyle(
                      fontSize: 12,
                      color: TKSColors.logout,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: _logout,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
