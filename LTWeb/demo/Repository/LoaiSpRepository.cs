using demo.Models;
using Microsoft.Identity.Client;

namespace demo.Repository
{
    public class LoaiSpRepository : ILoaiSpRepository
    {
        private readonly QlbanVaLiContext _context;

        public LoaiSpRepository(QlbanVaLiContext context)
        {
            _context = context;
        }
        public TLoaiSp Add(TLoaiSp loaiSp)
        {
            throw new NotImplementedException();
        }

        public TLoaiSp Delete(string maloai)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TLoaiSp> GetAllLoaiSp()
        {
            return _context.TLoaiSps;
        }

        public TLoaiSp GetLoai(string maloai)
        {
            throw new NotImplementedException();
        }

        public TLoaiSp Update(TLoaiSp loaiSp)
        {
            throw new NotImplementedException();
        }
    }
}
