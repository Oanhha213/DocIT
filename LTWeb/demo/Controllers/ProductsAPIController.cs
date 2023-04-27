using demo.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsAPIController : ControllerBase
    {
        QlbanVaLiContext db = new QlbanVaLiContext();
        public IEnumerable<TDanhMucSp> GetAllProducts()
        {
            return db.TDanhMucSps.ToList();
        }
    }
}
