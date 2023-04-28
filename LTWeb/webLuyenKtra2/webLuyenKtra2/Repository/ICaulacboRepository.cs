using webLuyenKtra2.Models;

namespace webLuyenKtra2.Repository
{
    public interface ICaulacboRepository
    {
        Caulacbo Add(Caulacbo caulacbo);
        Caulacbo Update(Caulacbo caulacbo);

        Caulacbo Delete(string maclb);

        Caulacbo GetAll(string maclb);
        IEnumerable<Caulacbo> GetAllCaulacbo();
    }
}
