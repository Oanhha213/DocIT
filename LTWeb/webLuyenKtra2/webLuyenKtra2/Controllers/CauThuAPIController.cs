using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using webLuyenKtra2.Models;

namespace webLuyenKtra2.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class CauThuAPIController : ControllerBase
	{
		QlbongDaContext db = new QlbongDaContext();
		public IEnumerable<APICauThu> GetAllCauThu()
		{
			IList<APICauThu> people = new List<APICauThu>();
			var cauthu = db.Cauthus.ToList();
			foreach (var s in cauthu)
			{
				people.Add(new APICauThu
				{
					CauThuId = s.CauThuId,
					HoVaTen = s.HoVaTen,
					CauLacBoId = s.CauLacBoId,
					Ngaysinh = s.Ngaysinh,
					ViTri = s.ViTri,
					QuocTich = s.QuocTich,
					SoAo = s.SoAo,
					Anh = s.Anh
				});
			}
			return people;

		}
		[HttpGet("{maclb}")]
		public IEnumerable<APICauThu> GetAllCauThu(string maclb)
		{
			var sanPham = (from p in db.Cauthus
						   where p.CauLacBoId == maclb
						   select new APICauThu
						   {
							   CauThuId = p.CauThuId,
							   HoVaTen = p.HoVaTen,
							   CauLacBoId = p.CauLacBoId,
							   Ngaysinh = p.Ngaysinh,
							   ViTri = p.ViTri,
							   QuocTich = p.QuocTich,
							   SoAo = p.SoAo,
							   Anh = p.Anh
						   }).ToList();
			return sanPham;
		}
	}
}
