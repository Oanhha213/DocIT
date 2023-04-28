using demo.Models;
using demo.Models.APIModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsAPIController : ControllerBase
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        public IEnumerable<Product> GetAllProducts()
        {
            IList<Product> products = new List<Product>();
            var sanPhams = db.TDanhMucSps.ToList();
            foreach (var s in sanPhams)
            {
                products.Add(new Product
                {
                    MaSp = s.MaSp,
                    TenSp = s.TenSp,
                    MaLoai = s.MaLoai,
                    AnhDaiDien = s.AnhDaiDien,
                    GiaNhoNhat = s.GiaNhoNhat
                });
            }
            return products;

        }
        [HttpGet("{maLoai}")]
        public IEnumerable<Product> GetAllProducts(string maLoai)
        {
            var sanPham = (from p in  db.TDanhMucSps where p.MaLoai == maLoai 
                           select new Product
                           {
                               MaSp = p.MaSp,
                               TenSp = p.TenSp,
                               MaLoai= p.MaLoai,
                               AnhDaiDien = p.AnhDaiDien,
                               GiaNhoNhat = p.GiaNhoNhat
                           }).ToList();
            return sanPham;
        }
    }
}
