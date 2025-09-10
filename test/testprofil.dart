import 'package:newsistime/features/transkrip/data/repositories/transkrip_repositories_implementation.dart';
import 'package:newsistime/injection.dart';

void main()async {
 final TranskripRepositoriesImplementation transkripRepositoriesImplementation = TranskripRepositoriesImplementation(remoteTranskripDataSource: myInjection());

 final response = await transkripRepositoriesImplementation.getTranskrip(nim:'2244068'); 

 print(response);
}