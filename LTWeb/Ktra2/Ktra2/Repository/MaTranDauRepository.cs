using Ktra2.Models;

namespace Ktra2.Repository
{
    public class MaTranDauRepository : IMaTranDauRepository
    {
        private readonly QlbongDaContext _context;

        public MaTranDauRepository(QlbongDaContext context)
        {
            _context = context;
        }

        public Trandau Add(Trandau trandau)
        {
            _context.Trandaus.Add(trandau);
            _context.SaveChanges();
            return trandau;
        }

        public Trandau Delete(string matrandau)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Trandau> GetAllMaTranDau()
        {
            return _context.Trandaus;
        }

        public Trandau GetCLB(string matrandau)
        {
            return _context.Trandaus.Find(matrandau);
        }

        public Trandau Update(Trandau trandau)
        {
            _context.Update(trandau);
            _context.SaveChanges();
            return trandau;
        }
    }
}
