using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

// -- builder -- //
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddReverseProxy()
    .LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"));
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

// -- app -- //
var app = builder.Build();

app.UseCors("AllowAll");
app.MapReverseProxy();
app.Run();
