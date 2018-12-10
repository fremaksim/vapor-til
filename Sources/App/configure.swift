import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // 2
    try services.register(FluentPostgreSQLProvider())
    
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)
    
    var databases = DatabasesConfig()
    
    let hostname = Environment.get("DATABASE_HOSTNAME") ?? "localhost"
    let username = Environment.get("DATABASE_USER") ?? "vapor"
    let databasename = Environment.get("DATABASE_DB") ?? "vapor"
    let password = Environment.get("DATABASE_PASSWORD") ?? "password"
    
    // 3
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: hostname,
        port: 5432,
        username: username,
        database: databasename,
        password: password)
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)
    var migrations = MigrationConfig()
    // 4
    migrations.add(model: Acronym.self, database: .psql)
    services.register(migrations)
}
