import '../api_model/project_packages.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'project.dart';

class ProjectPackageCollection
    extends EntityCollection<ProjectPackage, api_mod.ProjectPackageCollection> {
  ProjectPackageCollection({
    NucleusOneApp? app,
    List<ProjectPackage>? items,
  }) : super(app: app, items: items);

  factory ProjectPackageCollection.fromApiModel(
    api_mod.ProjectPackageCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return ProjectPackageCollection(
        items: apiModel.items.map((x) => ProjectPackage.fromApiModel(x)).toList());
  }

  @override
  api_mod.ProjectPackageCollection toApiModel() {
    return api_mod.ProjectPackageCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class ProjectPackage extends Entity with NucleusOneAppDependent {
  ProjectPackage._({
    NucleusOneApp? app,
    required this.tenant,
    required this.tenantMember,
    required this.isAdmin,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory ProjectPackage.fromApiModel(
    api_mod.ProjectPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return ProjectPackage._(
      app: app,
      tenant: Project.fromApiModel(apiModel.tenant!, app: app),
      tenantMember: ProjectMember.fromApiModel(apiModel.tenantMember!, app: app),
      isAdmin: apiModel.isAdmin!,
    );
  }

  Project tenant;

  ProjectMember tenantMember;

  bool isAdmin;

  @override
  api_mod.ProjectPackage toApiModel() {
    return api_mod.ProjectPackage()
      ..tenant = tenant.toApiModel()
      ..tenantMember = tenantMember.toApiModel()
      ..isAdmin = isAdmin;
  }
}
