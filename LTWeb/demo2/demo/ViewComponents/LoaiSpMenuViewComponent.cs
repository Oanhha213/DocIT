using Microsoft.AspNetCore.Mvc;
using demo.Repository;

namespace demo.ViewComponents
{
    public class LoaiSpMenuViewComponent: ViewComponent
    {
        private ILoaiSpRepository _loaiSpRepository;
        public LoaiSpMenuViewComponent(ILoaiSpRepository loaiSpRepository)
        {
            _loaiSpRepository = loaiSpRepository;
        }
        public IViewComponentResult Invoke()
        {
            var loaisps = _loaiSpRepository.GetAllLoaiSp().OrderBy(x => x.Loai);
            return View(loaisps);
        }
    }
}
