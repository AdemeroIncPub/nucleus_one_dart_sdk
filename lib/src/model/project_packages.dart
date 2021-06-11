import 'package:get_it/get_it.dart';

import '../api_model/project_packages.dart' as api_mod;
import '../nucleus_one.dart';
import 'project.dart';

class ProjectPackageCollection with NucleusOneAppDependent {
  ProjectPackageCollection._({NucleusOneAppInternal? app, required this.items}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory ProjectPackageCollection.fromApiModel(api_mod.ProjectPackageCollection apiModel) {
    return ProjectPackageCollection._(
        items: apiModel.items.map((x) => ProjectPackage.fromApiModel(x)).toList());
  }

  List<ProjectPackage> items;

  api_mod.ProjectPackageCollection toApiModel() {
    return api_mod.ProjectPackageCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class ProjectPackage with NucleusOneAppDependent {
  ProjectPackage._(
      {NucleusOneAppInternal? app,
      required this.tenant,
      required this.tenantMember,
      required this.isAdmin}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory ProjectPackage.fromApiModel(api_mod.ProjectPackage apiModel) {
    return ProjectPackage._(
        tenant: Project.fromApiModel(apiModel.tenant!),
        tenantMember: ProjectMember.fromApiModel(apiModel.tenantMember!),
        isAdmin: apiModel.isAdmin!);
  }

  Project tenant;

  ProjectMember tenantMember;

  bool isAdmin;

  api_mod.ProjectPackage toApiModel() {
    return api_mod.ProjectPackage()
      ..tenant = tenant.toApiModel()
      ..tenantMember = tenantMember.toApiModel()
      ..isAdmin = isAdmin;
  }
}
