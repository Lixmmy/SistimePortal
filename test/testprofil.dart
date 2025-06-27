import 'package:newsistime/features/profil/data/datasources/remote_datasource.dart';

void main()async {
 final ProfilRemoteDataSourceImplementation profilRemoteDataSourceImplementation = ProfilRemoteDataSourceImplementation();

 final response = await profilRemoteDataSourceImplementation.getMahasiswa(2244068); 

 print(response);
}