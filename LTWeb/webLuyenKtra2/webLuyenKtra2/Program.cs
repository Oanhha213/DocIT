using Microsoft.EntityFrameworkCore;
using webLuyenKtra2.Models;
using webLuyenKtra2.Repository;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
var ConnectString = builder.Configuration.GetConnectionString("QlbongDaContext");
builder.Services.AddDbContext<QlbongDaContext>(x => x.UseSqlServer(ConnectString));
builder.Services.AddScoped<ICaulacboRepository, CaulacboRepository>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
