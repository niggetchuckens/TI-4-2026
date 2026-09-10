using IdentityService.Infrastructure;
using IdentityService.Infrastructure.Persistence;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddInfrastructure(builder.Configuration);
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new
{
    service = "identity-service",
    status = "healthy"
}));

app.MapGet("/health/database", async (IdentityDbContext db, CancellationToken cancellationToken) =>
{
    try
    {
        var connected = await db.Database.CanConnectAsync(cancellationToken);

        return connected
            ? Results.Ok(new
            {
                database = "identity",
                status = "connected"
            })
            : Results.Json(new
            {
                database = "identity",
                status = "unavailable"
            }, statusCode: StatusCodes.Status503ServiceUnavailable);
    }
    catch (Exception)
    {
        return Results.Json(new
        {
            database = "identity",
            status = "unavailable"
        }, statusCode: StatusCodes.Status503ServiceUnavailable);
    }
});

app.Run();

public partial class Program
{
}