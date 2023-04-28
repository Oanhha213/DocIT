using exersiceFirst.Models;
using Microsoft.AspNetCore.Mvc;
using exersiceFirst.Repository;
namespace exersiceFirst.ViewComponents;
public class LoaiSpMenuViewComponent:ViewComponent 
{
    private readonly LoaiSpRepos _loaiSp;
    public LoaiSpMenuViewComponent(LoaiSpRepos loaiSpRepos)
    {
        _loaiSp = loaiSpRepos;
    }
    public IViewComponentResult Invoke()
    {
        var loaisp = _loaiSp.GetAllLoaiSp().OrderBy(x => x.Loai);
        return View(loaisp);
    }
}
