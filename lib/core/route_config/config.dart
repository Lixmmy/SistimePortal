import 'package:flutter_dotenv/flutter_dotenv.dart';

final scheme = dotenv.env['BASE_SCHEME'] ?? 'https';
final host = dotenv.env['BASE_HOST'] ?? 'portal.stmik-time.ac.id';
