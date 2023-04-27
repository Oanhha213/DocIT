using demo.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

namespace demo.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    [Route("admin/homeadmin")]
    public class HomeAdminController: Controller
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            return View();
            
        }
        [Route("danhsachsanpham")]
        public IActionResult DanhSachSanPham(int ? page)
        {
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            int pageSize = 12;
            var lstsanpham = db.TDanhMucSps.AsNoTracking().OrderBy(x => x.TenSp);
            PagedList<TDanhMucSp> lst = new PagedList<TDanhMucSp>(lstsanpham, pageNumber, pageSize);
            return View(lst);
        }

        [Route("ThemSanPhamMoi")]
        [HttpGet]
        public IActionResult ThemSanPhamMoi(String maSanPham)
        {
            ViewBag.MaChatLieu = new SelectList(db.TChatLieus.ToList(), "MaChatLieu", "ChatLieu");
            ViewBag.MaHangSx = new SelectList(db.THangSxes.ToList(), "MaHangSx", "HangSx");
            ViewBag.MaNuocSx = new SelectList(db.TQuocGia.ToList(), "MaNuoc", "TenNuoc");
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            ViewBag.MaDt = new SelectList(db.TLoaiDts.ToList(), "MaDt", "TenLoai");
            var sanpham = db.TDanhMucSps.Find(maSanPham);
            return View(sanpham);
        }

        [Route("ThemSanPhamMoi")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemSanPhamMoi(TDanhMucSp sanPham)
        {
            if (ModelState.IsValid)
            {
                db.TDanhMucSps.Add(sanPham);
                db.SaveChanges();
            }
            return View(sanPham);
        }

        [Route("EditSanPham")]
        [HttpGet]
        public IActionResult EditSanPham(String maSanPham)
        {
            ViewBag.MaChatLieu = new SelectList(db.TChatLieus.ToList(), "MaChatLieu", "ChatLieu");
            ViewBag.MaHangSx = new SelectList(db.THangSxes.ToList(), "MaHangSx", "HangSx");
            ViewBag.MaNuocSx = new SelectList(db.TQuocGia.ToList(), "MaNuoc", "TenNuoc");
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            ViewBag.MaDt = new SelectList(db.TLoaiDts.ToList(), "MaDt", "TenLoai");
            var sanpham = db.TDanhMucSps.Find(maSanPham);
            return View(sanpham);
        }
        [Route("EditSanPham")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditSanPham(TDanhMucSp sanpham)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sanpham).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("DanhSachSanPham");
            }
            return View(sanpham);
        }

        [Route("DeleteSanPham")]
        [HttpGet]
        public IActionResult DeleteSanPham(string maSp)
        {
            TempData["Message"] = "";
            var listChiTiet = db.TChiTietSanPhams.Where(x => x.MaSp == maSp);
            foreach (var item in listChiTiet)
            {
                if (db.TChiTietHdbs.Where(x => x.MaChiTietSp == item.MaChiTietSp) != null)
                {
                    TempData["Message"] = "Không xóa được sản phẩm";
                    return RedirectToAction("DanhSachSanPham");
                }
            }
            var listAnh = db.TAnhSps.Where(x => x.MaSp == maSp);
            if (listAnh != null) db.RemoveRange(listAnh);
            if (listChiTiet != null) db.RemoveRange(listChiTiet);
            db.Remove(db.TDanhMucSps.Find(maSp));
            db.SaveChanges();
            return RedirectToAction("DanhSachSanPham");
        }

        [Route("danhsachloaisanpham")]
        public IActionResult DanhSachLoaiSanPham(int? page)
        {
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            int pageSize = 12;
            var lstloaisanpham = db.TLoaiSps.AsNoTracking().OrderBy(x => x.MaLoai);
            PagedList<TLoaiSp> lst = new PagedList<TLoaiSp>(lstloaisanpham, pageNumber, pageSize);
            return View(lst);
        }

        [Route("ThemLoaiSanPhamMoi")]
        [HttpGet]
        public IActionResult ThemLoaiSanPhamMoi(String maLoaiSanPham)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            var sanpham = db.TLoaiSps.Find(maLoaiSanPham);
            return View(sanpham);
        }

        [Route("ThemLoaiSanPhamMoi")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemLoaiSanPhamMoi(TLoaiSp loaiSanPham)
        {
            if (ModelState.IsValid)
            {
                db.TLoaiSps.Add(loaiSanPham);
                db.SaveChanges();
            }
            return View(loaiSanPham);
        }

        [Route("EditLoaiSanPham")]
        [HttpGet]
        public IActionResult EditLoaiSanPham(String maLoaiSanPham)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            var sanpham = db.TLoaiSps.Find(maLoaiSanPham);
            return View(sanpham);
        }
        [Route("EditLoaiSanPham")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditLoaiSanPham(TLoaiSp sanpham)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sanpham).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("DanhSachLoaiSanPham");
            }
            return View(sanpham);
        }

    }
}
