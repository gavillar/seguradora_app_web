import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/enums/home_product_enum.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeProductWebViewScreen extends StatefulWidget {
  const HomeProductWebViewScreen({super.key, required this.product});

  final HomeProduct product;

  @override
  State<HomeProductWebViewScreen> createState() =>
      HomeProductWebViewScreenState();
}

class HomeProductWebViewScreenState extends State<HomeProductWebViewScreen> {
  late final WebViewController _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await launchUrl(
          Uri.parse(widget.product.url),
          webOnlyWindowName: '_blank',
        );
      });
      return;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _loading = true;
              _error = null;
            });
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            setState(() {
              _loading = false;
              _error = error.description;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.product.url));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: TKSColors.navigationBackground,
      appBar: AppBar(
        backgroundColor: TKSColors.navigationBackground,
        title: Text(
          widget.product.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: kIsWeb
          ? const SizedBox.shrink()
          : Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_loading)
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      color: TKSColors.selectedMenu,
                    ),
                  ),
                if (_error != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language_outlined,
                            color: TKSColors.selectedMenu,
                            size: 42,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.textWebViewLoadError,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: TKSColors.muted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            onPressed: () => _controller.loadRequest(
                              Uri.parse(widget.product.url),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
