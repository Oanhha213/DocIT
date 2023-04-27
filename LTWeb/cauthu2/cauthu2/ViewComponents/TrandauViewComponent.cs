using Microsoft.AspNetCore.Mvc;
using cauthu2.Repository;

namespace cauthu2.ViewComponents
{
    public class TrandauViewComponent : ViewComponent
    {
        private ITrandauRepository _trandau;
        public TrandauViewComponent(ITrandauRepository trandau)
        {
            _trandau = trandau;
        }
        public IViewComponentResult Invoke()
        {
            var trandau = _trandau.GetAllTrandau();
            return View(trandau);
        }
    }
}
