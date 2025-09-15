import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  DeepLinkService(this._navKey);

  final GlobalKey<NavigatorState> _navKey;
  StreamSubscription? _sub;

  Future<void> init() async {
    // Handle app launch via link
    try {
      final initial = await getInitialUri();
      if (initial != null) _handle(initial);
    } catch (_) {}

    // Handle links while app is running
    _sub = uriLinkStream.listen((uri) {
      if (uri != null) _handle(uri);
    }, onError: (_) {});
  }

  void dispose() {
    _sub?.cancel();
  }

  void _handle(Uri uri) {
    final route = _mapUriToRoute(uri);
    if (route != null) {
      _navKey.currentState?.pushNamed(route);
    }
  }

  String? _mapUriToRoute(Uri uri) {
    // Supports custom scheme: mediaguide://<path>
    final seg = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : uri.host;
    switch (seg) {
      case 'dashboard':
        return '/dashboard';
      case 'symptoms':
        return '/symptoms';
      case 'scan':
        return '/scan';
      case 'coach':
        return '/coach';
      case 'reports':
        return '/reports';
      default:
        return null;
    }
  }
}

class DeepLinkBootstrap extends StatefulWidget {
  const DeepLinkBootstrap({super.key, required this.child, required this.navKey});
  final Widget child;
  final GlobalKey<NavigatorState> navKey;

  @override
  State<DeepLinkBootstrap> createState() => _DeepLinkBootstrapState();
}

class _DeepLinkBootstrapState extends State<DeepLinkBootstrap> {
  DeepLinkService? _svc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_svc == null) {
      _svc = DeepLinkService(widget.navKey);
      _svc!.init();
    }
  }

  @override
  void dispose() {
    _svc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
