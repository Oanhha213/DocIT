using System.ComponentModel.DataAnnotations;

namespace webAPI1.Models.APIModels
{
    public class Product
    {
        public string MaSp { get; set; }
        public string? TenSp { get; set; }
        public string? MaLoai { get; set; }
        public string? AnhDaiDien { get; set; }
        public decimal? GiaNhoNhat { get; set; }
    }
}
