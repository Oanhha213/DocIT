using Microsoft.AspNetCore.Mvc;
using webLuyenKtra2.Repository;

namespace webLuyenKtra2.ViewComponents
{
    public class CaulacboViewComponent : ViewComponent
    {
        private ICaulacboRepository _clb;
        public CaulacboViewComponent(ICaulacboRepository clb)
        {
            _clb = clb;
        }
        public IViewComponentResult Invoke()
        {
            var clb = _clb.GetAllCaulacbo();
            return View(clb);
        }
    }
}
