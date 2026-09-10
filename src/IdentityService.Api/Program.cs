using IdentityService.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddInfrastructure();
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new
{
    service = "identity-service",
    status = "healthy"
}));

app.Run();

public partial class Program
{
}