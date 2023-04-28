using cauthu2.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace cauthu2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class APIController : ControllerBase
    {
        QlbongDaContext db = new QlbongDaContext();
        public IEnumerable<Cauthu> GetAll()
        {
            IList<Cauthu> people = new List<Cauthu>();
            var cauthu = db.Cauthus.ToList();
            foreach (var s in cauthu)
            {
                people.Add(new API
                {
                    TranDauId = s.TranDauId,
                    CauThuId = s.CauThuId,
                    ThoiGianBatDau = s.ThoiGianBatDau,
                    ThoiGianKetThuc = s.ThoiGianKetThuc,
                    PhamLoi = s.PhamLoi
                });
            }
            return people;
        }
        [HttpGet("{matrandau}")]
        public IEnumerable<API> GetAllCauThu(string matrandau)
        {
            var sanPham = (from p in db.TrandauCauthus
                           where p.TranDauId == matrandau
                           select new API
                           {
                               TranDauId = p.TranDauId,
                               CauThuId = p.CauThuId,
                               ThoiGianBatDau = p.ThoiGianBatDau,
                               ThoiGianKetThuc = p.ThoiGianKetThuc,
                               PhamLoi = p.PhamLoi
                           }).ToList();
            return sanPham;
        }
    }
}
