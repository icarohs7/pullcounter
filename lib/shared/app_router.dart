import 'package:core_resources/core_resources.dart';
import 'package:go_router/go_router.dart';
import 'package:pullcounter/app/presentation/pages/banners_page.dart';

// ignore: non_constant_identifier_names
final AppRouter = _AppRouter();

class _AppRouter with BaseRouter {
  final rBanners = '/banners';

  late final routes = GoRouter(
    initialLocation: rBanners,
    routes: [
      GoRoute(
        path: rBanners,
        builder: (context, state) => BannersPage(),
      ),
    ],
  );
}
