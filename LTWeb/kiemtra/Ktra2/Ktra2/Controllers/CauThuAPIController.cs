using Ktra2.Models;
using Ktra2.Models.APIModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Ktra2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CauThuAPIController : ControllerBase
    {
        QlbongDaContext db = new QlbongDaContext();

        [HttpGet]
        public IEnumerable<Cauthu> GetAllCauthu()
        {
            return db.Cauthus.ToList();
        }

        [HttpGet("{matrandau}")]
        public IEnumerable<CauThuAPI> GetAllCauthu(string matrandau)
        {
            var ct = (from c in db.Cauthus join td in db.TrandauCauthus on c.CauThuId equals td.CauThuId
                      where td.TranDauId == matrandau
                      select new CauThuAPI
                      {
                          CauThuId = c.CauThuId,
                          HoVaTen = c.HoVaTen,
                          QuocTich = c.QuocTich,
                          Anh = c.Anh,
                          ViTri = c.ViTri,
                          SoAo = c.SoAo,
                          MaTranDau = td.TranDauId,
                      }).ToList();
            return ct;
        }
    }
}
