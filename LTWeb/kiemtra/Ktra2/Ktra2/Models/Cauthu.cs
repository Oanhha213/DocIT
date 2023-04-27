using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Ktra2.Models;

public partial class Cauthu
{
    public string CauThuId { get; set; } = null!;

    public string? HoVaTen { get; set; }

    public string? CauLacBoId { get; set; }

    public DateTime? Ngaysinh { get; set; }

    public string? ViTri { get; set; }

    public string? QuocTich { get; set; }

    [RegularExpression(@"^[0-9]$", ErrorMessage = "So ao chi chua so")]
    public string? SoAo { get; set; }

    [FileExtensions(Extensions = "png", ErrorMessage = "Duoi phai la .png")]
    public string? Anh { get; set; }

    public virtual Caulacbo? CauLacBo { get; set; }

    public virtual ICollection<TrandauCauthu> TrandauCauthus { get; } = new List<TrandauCauthu>();

    public virtual ICollection<TrandauGhiban> TrandauGhibans { get; } = new List<TrandauGhiban>();
}
