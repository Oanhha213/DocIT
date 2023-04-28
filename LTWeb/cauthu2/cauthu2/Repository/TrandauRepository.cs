using cauthu2.Models;

namespace cauthu2.Repository
{
    public class TrandauRepository : ITrandauRepository
    {
        private readonly QlbongDaContext _context;
        public TrandauRepository(QlbongDaContext context)
        {
            _context = context;
        }

        public TrandauCauthu Add(TrandauCauthu trandau)
        {
            throw new NotImplementedException();
        }

        public TrandauCauthu Delete(string matrandau)
        {
            throw new NotImplementedException();
        }

        public TrandauCauthu GetAll(string matrandau)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrandauCauthu> GetAllTrandau()
        {
            return _context.TrandauCauthus;
        }

        public TrandauCauthu Update(TrandauCauthu trandau)
        {
            throw new NotImplementedException();
        }
    }
}
