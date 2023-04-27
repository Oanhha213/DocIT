namespace cauthu2.Models
{
    public class API
    {
        public string TranDauId { get; set; } = null!;

        public string CauThuId { get; set; } = null!;

        public int? ThoiGianBatDau { get; set; }

        public int? ThoiGianKetThuc { get; set; }

        public string? PhamLoi { get; set; }

        public virtual Cauthu CauThu { get; set; } = null!;

        public virtual Trandau TranDau { get; set; } = null!;
    }
}
