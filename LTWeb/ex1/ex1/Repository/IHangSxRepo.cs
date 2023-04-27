using ex1.Models;
namespace ex1.Repository
{
	public interface IHangSxRepo
	{
		THangSx Add(THangSx hangSx);

		THangSx Update(THangSx hangSx);

		THangSx Delete(THangSx MaHangSx);

		THangSx GetHangSx(String MaHangSx);

		IEnumerable<THangSx> GetAllHangSx();
	}
}
