using Azure;
using exersiceFirst.Models;
using exersiceFirst.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using X.PagedList;

namespace exersiceFirst.Controllers
{
    public class HomeController : Controller
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index(int page=1)
        {
            int pageNumber = page;
            int pageSize = 12;
            var lstsanpham = db.TDanhMucSps.AsNoTracking().OrderBy(x => x.TenSp);
            PagedList<TDanhMucSp> lst = new PagedList<TDanhMucSp>(lstsanpham, pageNumber, pageSize);
            return View(lst);
        }

        public IActionResult SanPhamTheoLoai(String maloai, int? page)
        {
            int pageSize = 12;
            int pageNumber = page == null || page < 0 ? 1: page.Value;
            var lstSanPham = db.TDanhMucSps.AsNoTracking().Where
                (x => x.MaLoai == maloai).OrderBy(x => x.TenSp).ToList();
            PagedList<TDanhMucSp> lst = new PagedList<TDanhMucSp>(lstSanPham,pageNumber, pageSize);
            ViewBag.maloai = maloai;
            return View(lst);
        }

        public IActionResult ProductDetail(string masp)
        {
            var sanpham = db.TDanhMucSps.SingleOrDefault(x => x.MaSp == masp);
            var anh = db.TAnhSps.Where(x => x.MaSp == masp).AsNoTracking().ToList();
            var sp = new HomeProductDetailViewModel(sanpham, anh);
            if (sanpham == null)
            {
                return RedirectToAction("Index");
            }
            else
            {
                return View(sp);
            }
        }
        
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}