using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Login
    {
        [DisplayName("Tên tài khoản: ")]
        public string? userName { get; set; }
        [DataType(DataType.Password)]
        [DisplayName("Mật khẩu")]
        public string? password { get; set; }
    }
}
