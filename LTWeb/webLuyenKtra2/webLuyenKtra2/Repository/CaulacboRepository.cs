using webLuyenKtra2.Models;

namespace webLuyenKtra2.Repository
{
    public class CaulacboRepository : ICaulacboRepository
    {
        private readonly QlbongDaContext _context;
        public CaulacboRepository(QlbongDaContext context)
        {
            _context = context;
        }
        public Caulacbo Add(Caulacbo caulacbo)
        {
            throw new NotImplementedException();
        }

        public Caulacbo Delete(string maclb)
        {
            throw new NotImplementedException();
        }

        public Caulacbo GetAll(string maclb)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Caulacbo> GetAllCaulacbo()
        {
            return _context.Caulacbos;
        }

        public Caulacbo Update(Caulacbo caulacbo)
        {
            throw new NotImplementedException();
        }
    }
}
