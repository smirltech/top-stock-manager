Map<String, dynamic> permissions = {
//Roles
  'roles_all': const Permission(value: "roles.*", label: "View all roles"),
  'roles_view': const Permission(value: "roles.view", label: "View a role"),
  'roles_create':
      const Permission(value: "roles.create", label: "Create a role"),
  'roles_update':
      const Permission(value: "roles.update", label: "Update a role"),
  'roles_delete':
      const Permission(value: "roles.delete", label: "Delete a role"),

//Users
  'users_all': const Permission(value: "users.*", label: "View all users"),
  'users_view': const Permission(value: "users.view", label: "View a user"),
  'users_create':
      const Permission(value: "users.create", label: "Create a user"),
  'users_update':
      const Permission(value: "users.update", label: "Update a user"),
  'users_delete':
      const Permission(value: "users.delete", label: "Delete a user"),

  //Products
  'products_all':
      const Permission(value: "products.*", label: "View all products"),
  'products_view':
      const Permission(value: "products.view", label: "View a product"),
  'products_create':
      const Permission(value: "products.create", label: "Create a product"),
  'products_update':
      const Permission(value: "products.update", label: "Update a product"),
  'products_delete':
      const Permission(value: "products.delete", label: "Delete a product"),

  //Suppliers
  'suppliers_all':
      const Permission(value: "suppliers.*", label: "View all suppliers"),
  'suppliers_view':
      const Permission(value: "suppliers.view", label: "View a supplier"),
  'suppliers_create':
      const Permission(value: "suppliers.create", label: "Create a supplier"),
  'suppliers_update':
      const Permission(value: "suppliers.update", label: "Update a supplier"),
  'suppliers_delete':
      const Permission(value: "suppliers.delete", label: "Delete a supplier"),

  //Clients
  'clients_all':
      const Permission(value: "clients.*", label: "View all clients"),
  'clients_view':
      const Permission(value: "clients.view", label: "View a client"),
  'clients_create':
      const Permission(value: "clients.create", label: "Create a client"),
  'clients_update':
      const Permission(value: "clients.update", label: "Update a client"),
  'clients_delete':
      const Permission(value: "clients.delete", label: "Delete a client"),

  //Purchases
  'purchases_all':
      const Permission(value: "purchases.*", label: "View all purchases"),
  'purchases_view':
      const Permission(value: "purchases.view", label: "View a purchase"),
  'purchases_create':
      const Permission(value: "purchases.create", label: "Create a purchase"),
  'purchases_update':
      const Permission(value: "purchases.update", label: "Update a purchase"),
  'purchases_delete':
      const Permission(value: "purchases.delete", label: "Delete a purchase"),

  //Sales
  'sales_all': const Permission(value: "sales.*", label: "View all sales"),
  'sales_view': const Permission(value: "sales.view", label: "View a sale"),
  'sales_create':
      const Permission(value: "sales.create", label: "Create a sale"),
  'sales_update':
      const Permission(value: "sales.update", label: "Update a sale"),
  'sales_delete':
      const Permission(value: "sales.delete", label: "Delete a sale"),
};

class Permission {
  const Permission({
    required this.value,
    this.label,
  });

  final String value;
  final String? label;
}
