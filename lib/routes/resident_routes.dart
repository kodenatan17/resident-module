import 'package:go_router/go_router.dart';
import '../presentation/pages/resident_list_page.dart';
import '../presentation/pages/resident_detail_page.dart';
import '../presentation/pages/resident_create_page.dart';

/// Routes owned by the resident module.
class ResidentRoutes {
  static const String list = '/resident';
  static const String detail = '/resident/:id';
  static const String create = '/resident/create';

  /// All route configurations for this module.
  static List<RouteBase> get all => [
        GoRoute(
          path: list,
          name: 'resident.list',
          builder: (context, state) => const ResidentListPage(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'resident.detail',
              builder: (context, state) => ResidentDetailPage(
                id: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: 'create',
              name: 'resident.create',
              builder: (context, state) => const ResidentCreatePage(),
            ),
          ],
        ),
      ];
}
