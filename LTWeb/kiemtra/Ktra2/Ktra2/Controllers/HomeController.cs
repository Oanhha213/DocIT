using Ktra2.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace Ktra2.Controllers
{
	public class HomeController : Controller
	{
		private readonly ILogger<HomeController> _logger;

		QlbongDaContext db = new QlbongDaContext();

		public HomeController(ILogger<HomeController> logger)
		{
			_logger = logger;
		}

		public IActionResult Index()
		{
			var ds101 = db.Cauthus.Where(x => x.CauLacBoId == "101").ToList();
			return View(ds101);
		}

		public IActionResult Privacy()
		{
			return View();
		}

        [Route("SuaCauThu")]
        [HttpGet]
        public IActionResult SuaCauThu(string cauthuid)
        {
            Cauthu ct = db.Cauthus.Find(cauthuid);
			ViewBag.CauLacBoId = new SelectList(db.Caulacbos, "CauLacBoId", "TenClb");
            return View(ct);
        }

        [Route("SuaCauThu")]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public IActionResult SuaCauThu(Cauthu ct)
        {
            if (ModelState.IsValid)
            {
                db.Entry(ct).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("DanhSachSanPham", "HomeAdmin");
            }
            return View(ct);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
	}
}