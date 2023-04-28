using demo.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
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
        public IActionResult DeleteSanPham(string maSanPham)
        {
            var listChiTiet = db.TChiTietSanPhams.Where(x => x.MaSp == maSanPham);
            foreach (var item in listChiTiet)
            {
                if (db.TChiTietHdbs.Where(x => x.MaChiTietSp == item.MaChiTietSp) != null)
                {
                    TempData["Mesage"] = "Không xóa được sản phẩm";
                    return RedirectToAction("DanhSachSanPham");
                }
            }
            var listAnh = db.TAnhSps.Where(x => x.MaSp == maSanPham);
            if (listAnh != null) db.RemoveRange(listAnh);
            if (listChiTiet != null) db.RemoveRange(listChiTiet);
            db.Remove(db.TDanhMucSps.Find(maSanPham));
            db.SaveChanges();
            return RedirectToAction("DanhSachSanPham");
        }
        [Route("danhmucloaisanpham")]
        public IActionResult DanhMucLoaiSanPham(int? page)
        {
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            int pageSize = 12;
            var lstloaisp = db.TLoaiSps.AsNoTracking().OrderBy(x => x.Loai);
            PagedList<TLoaiSp> lst = new PagedList<TLoaiSp>(lstloaisp, pageNumber, pageSize);
            return View(lst);
        }

        [Route("ThemLoaiSanPham")]
        [HttpGet]
        public IActionResult ThemLoaiSanPham(String maLoai)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            var loaiSp = db.TDanhMucSps.Find(maLoai);
            return View(loaiSp);
        }

        [Route("ThemLoaiSanPham")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemLoaiSanPham(TLoaiSp loaiSp)
        {
            if (ModelState.IsValid)
            {
                db.TLoaiSps.Add(loaiSp);
                db.SaveChanges();
            }
            return View(loaiSp);
        }

        [Route("EditLoaiSp")]
        [HttpGet]
        public IActionResult EditLoaiSp(String maLoai)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiSps.ToList(), "MaLoai", "Loai");
            var loaiSp = db.TLoaiSps.Find(maLoai);
            return View(loaiSp);
        }
        [Route("EditLoaiSp")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditLoaiSp(TLoaiSp loaiSp)
        {
            if (ModelState.IsValid)
            {
                db.Entry(loaiSp).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("DanhMucLoaiSanPham");
            }
            return View(loaiSp);
        }

        [Route("danhmucloaidoituong")]
        public IActionResult DanhMucLoaiDoiTuong(int? page)
        {
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            int pageSize = 12;
            var lstloaidt = db.TLoaiDts.AsNoTracking().OrderBy(x => x.TenLoai);
            PagedList<TLoaiDt> lst = new PagedList<TLoaiDt>(lstloaidt, pageNumber, pageSize);
            return View(lst);
        }

        [Route("ThemLoaiDoiTuong")]
        [HttpGet]
        public IActionResult ThemLoaiDoiTuong(String maLoai)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiDts.ToList(), "MaLoai", "TenLoai");
            var loaiDt = db.TLoaiDts.Find(maLoai);
            return View(loaiDt);
        }

        [Route("ThemLoaiDoiTuong")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemLoaiDoiTuong(TLoaiDt loaiDt)
        {
            if (ModelState.IsValid)
            {
                db.TLoaiDts.Add(loaiDt);
                db.SaveChanges();
            }
            return View(loaiDt);
        }

        [Route("EditLoaiDoiTuong")]
        [HttpGet]
        public IActionResult EditLoaiDoiTuong(String maLoai)
        {
            ViewBag.MaLoai = new SelectList(db.TLoaiDts.ToList(), "MaLoai", "Loai");
            var loaiDt = db.TLoaiDts.Find(maLoai);
            return View(loaiDt);
        }
        [Route("EditLoaiDoiTuong")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditLoaiDoiTuong(TLoaiDt loaiDt)
        {
            if (ModelState.IsValid)
            {
                db.Entry(loaiDt).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("DanhMucLoaiSanPham");
            }
            return View(loaiDt);
        }
    }
}
