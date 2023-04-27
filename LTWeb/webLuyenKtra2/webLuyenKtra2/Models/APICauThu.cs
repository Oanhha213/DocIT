using System.ComponentModel.DataAnnotations;

namespace webLuyenKtra2.Models
{
	public class APICauThu
	{
		public string CauThuId { get; set; } = null!;
		public string? HoVaTen { get; set; }
		public string? CauLacBoId { get; set; }

		public DateTime? Ngaysinh { get; set; }

		public string? ViTri { get; set; }

		public string? QuocTich { get; set; }

		[Range(1, 200)]
		public string? SoAo { get; set; }

		public string? Anh { get; set; }
	}
}
