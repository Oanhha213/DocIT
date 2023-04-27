using Microsoft.EntityFrameworkCore;
using webAPI1.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<QlbanVaLiContext>(option => option.UseSqlServer
    (builder.Configuration.GetConnectionString("QlibanValiContext")));
builder.Services.AddCors(p => p.AddPolicy("QlibanValiContext",
    build => { build.WithOrigins("https://localhost:7113", "https://localhost:7074"); }));
//build.WithOrigins(*)
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();
app.UseCors("QlibanValiContext");

app.MapControllers();

app.Run();
