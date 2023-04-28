using Ktra2.Models;

namespace Ktra2.Repository
{
    public interface IMaTranDauRepository
    {
        Trandau Add(Trandau trandau);
        Trandau Update(Trandau trandau);
        Trandau Delete(string matrandau);

        Trandau GetCLB(string matrandau);

        IEnumerable<Trandau> GetAllMaTranDau();
    }
}
