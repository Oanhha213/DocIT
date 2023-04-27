using demo.Models;
namespace demo.Repository
{
    public interface ILoaiSpRepository
    {
        TLoaiSp Add(TLoaiSp loaiSp);

        TLoaiSp Update(TLoaiSp loaiSp);

        TLoaiSp Delete(string maloai);

        TLoaiSp GetLoai(string maloai);

        IEnumerable<TLoaiSp> GetAllLoaiSp();
    }
}
