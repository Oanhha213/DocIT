using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using webLuyenKtra2.Models;

namespace webLuyenKtra2.Controllers
{
    public class HomeController : Controller
    {

        private readonly ILogger<HomeController> _logger;
		QlbongDaContext db = new QlbongDaContext();
		public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
			var lst = db.Cauthus.ToList();
			return View(lst);
        }
		[Route("ThemCT")]
		[HttpGet]
		public IActionResult ThemCT(String mact)
		{
            ViewBag.CauLacBo = new SelectList(db.Caulacbos.ToList(), "CauLacBoId", "TenClb", 0);
            var cauthu = db.Caulacbos.Find(mact);
			return View(cauthu);
		}

		[Route("ThemCT")]
        [HttpPost]
        public IActionResult ThemCT(Cauthu cauThu)
        {
            if (ModelState.IsValid)
            {
                var selectedCauLacBoId = cauThu.CauLacBoId;

                // Lấy danh sách giá trị của CauLacBoId
                var cauLacBoIds = db.Caulacbos.Select(clb => clb.CauLacBoId).ToList();

                // Kiểm tra xem giá trị được chọn có nằm trong danh sách giá trị của CauLacBoId hay không
                if (!cauLacBoIds.Contains(selectedCauLacBoId))
                {
                    // Nếu giá trị không nằm trong danh sách, xử lý tương ứng (ví dụ như hiển thị lỗi)
                    ModelState.AddModelError("CauLacBoId", "Giá trị không hợp lệ");
                    return View(cauThu);
                }

                db.Cauthus.Add(cauThu);
                db.SaveChanges();
            }
            return View(cauThu);
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