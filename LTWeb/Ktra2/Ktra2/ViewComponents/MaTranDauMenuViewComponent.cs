using Ktra2.Models;
using Ktra2.Repository;
using Microsoft.AspNetCore.Mvc;
namespace Ktra2.ViewComponents
{
    public class MaTranDauMenuViewComponent : ViewComponent
    {
        private readonly IMaTranDauRepository _menuViewComponent;

        public MaTranDauMenuViewComponent(IMaTranDauRepository menuViewComponent)
        {
            _menuViewComponent = menuViewComponent;
        }

        public IViewComponentResult Invoke()
        {
            var trandau = _menuViewComponent.GetAllMaTranDau().OrderBy(x => x.TranDauId);
            return View(trandau);
        }
    }
}
