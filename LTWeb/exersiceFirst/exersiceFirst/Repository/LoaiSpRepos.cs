using exersiceFirst.Models;
namespace exersiceFirst.Repository
{
    public interface LoaiSpRepos
    {
        TLoaiSp Add(TLoaiSp loaiSp);

        TLoaiSp Update(TLoaiSp loaiSp);

        TLoaiSp Delete(TLoaiSp maloaiSp);

        TLoaiSp GetLoaiSp(String maloaiSp);

        IEnumerable<TLoaiSp> GetAllLoaiSp();
    }
}
