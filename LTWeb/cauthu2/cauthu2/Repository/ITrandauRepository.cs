using cauthu2.Models;

namespace cauthu2.Repository
{
    public interface ITrandauRepository
    {
        TrandauCauthu Add(TrandauCauthu trandau);
        TrandauCauthu Update(TrandauCauthu trandau);

        TrandauCauthu Delete(string matrandau);

        TrandauCauthu GetAll(string matrandau);
        IEnumerable<TrandauCauthu> GetAllTrandau();
    }
}
