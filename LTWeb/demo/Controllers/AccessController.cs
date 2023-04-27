using demo.Models;
using Microsoft.AspNetCore.Mvc;

namespace demo.Controllers
{
    public class AccessController : Controller
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        [HttpGet]
        public IActionResult Login()
        {
            if (HttpContext.Session.GetString("UserName") == null)
            {
                return View();
            }
            else
                return RedirectToAction("Index","Home");
        }
        [HttpPost]
        public IActionResult Login(TUser user)
        {
            if (HttpContext.Session.GetString("UserName") == null)
            {
                var obj = db.TUsers.Where(x => x.Username == user.Username &&
                x.Password == user.Password).FirstOrDefault();
                if(obj != null)
                {
                    HttpContext.Session.SetString("UserName",obj.Username.ToString());
                    return RedirectToAction("Index", "Home");
                }
            }
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            HttpContext.Session.Remove("UserName");
            return RedirectToAction("Login", "Access");
        }
    }
}
