using ex1.Models;

namespace ex1.Repository
{
	public interface HangSx:IHangSxRepo
	{
		private readonly QlbanVaLiContext _context;
		public HangSx(QlbanVaLiContext context)
		{
			_context = context;
		}

		QlbanVaLiContext Context { get; }

		public THangSx Add(THangSx hangSx)
		{
			_context.THangSxes.Add(hangSx);
			_context.SaveChanges();
			return hangSx;
		}

		public THangSx Delete(THangSx MaHangSx)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<THangSx> GetAllHangSx()
		{
			return _context.THangSxes;
		}

		public THangSx GetHangSx(string MaHangSx)
		{
			return _context.THangSxes.Find(MaHangSx);
		}

		public THangSx Update(THangSx hangSx)
		{
			_context.Update(hangSx);
			_context.SaveChanges();
			return hangSx;
		}
	}
}
