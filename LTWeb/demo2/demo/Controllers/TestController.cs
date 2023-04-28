using Microsoft.AspNetCore.Mvc;

namespace demo.Controllers
{
    public class TestController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
