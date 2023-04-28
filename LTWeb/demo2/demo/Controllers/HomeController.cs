using demo.Models;
using demo.Models.Authentication;
using demo.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using X.PagedList;

namespace demo.Controllers
{
    public class HomeController : Controller
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }
        //[Authentication]
        public IActionResult Index(int page=1)
        {
            int pageNumber = page;
            int pageSize = 12;
            var lstsanpham = db.TDanhMucSps.AsNoTracking().OrderBy(x => x.TenSp);
            PagedList<TDanhMucSp> lst= new PagedList<TDanhMucSp>(lstsanpham, pageNumber, pageSize);
            
            return View(lst);
        }

        public IActionResult SanPhamTheoLoai(string maloai, int? page)
        {
            int pageNumber = page == null || page < 1 ? 1 : page.Value;
            int pageSize = 12;
            var lstsanpham = db.TDanhMucSps.Where(x => x.MaLoai == maloai).AsNoTracking();
            if (lstsanpham.Count() == 0)
            {
                lstsanpham = db.TDanhMucSps.AsNoTracking();
            }
            PagedList<TDanhMucSp> lst = new PagedList<TDanhMucSp>(lstsanpham, pageNumber, pageSize);
            ViewBag.maloai = maloai;
            return View(lst);
        }

        public IActionResult ChiTietSanPham(string MaSp)
        {
            TDanhMucSp sanpham = db.TDanhMucSps.SingleOrDefault(x=> x.MaSp == MaSp);
            var lstAnhSanPham = db.TAnhSps.Where(x => x.MaSp == MaSp).ToList();
            ViewBag.lstAnhSanPham = lstAnhSanPham;
            return View(sanpham);
        }

        public IActionResult ProductDetail(string maSp)
        {
            var sanpham = db.TDanhMucSps.SingleOrDefault(x=>x.MaSp==maSp);
            var anh = db.TAnhSps.Where(x=>x.MaSp==maSp).AsNoTracking().ToList();
            var sp = new HomeProductDetailViewModel(sanpham, anh);
            if (sanpham == null)
            {
                return RedirectToAction("Index");
            } else
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