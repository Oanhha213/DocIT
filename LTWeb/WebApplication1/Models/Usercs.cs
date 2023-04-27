using System.ComponentModel;

namespace WebApplication1.Models
{
    public class Usercs
    {
        public long Id { get; set; }
        [DisplayName("Họ và tên")]
        public string? name { get; set; }
        [DisplayName("Địa chỉ")]
        public string? address { get; set; }
        [DisplayName("Email")]
        public string? email { get; set; }

    }
}
