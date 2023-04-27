using exersiceFirst.Models;

namespace exersiceFirst.ViewModels
{
    public class HomeProductDetailViewModel
    {
        private TDanhMucSp sanpham;
        private List<TAnhSp> anhsanpham;

        public HomeProductDetailViewModel(TDanhMucSp sanpham, List<TAnhSp> anhsanpham)
        {
            this.sanpham = sanpham;
            this.anhsanpham = anhsanpham;
        }

        public TDanhMucSp Sanpham { get => sanpham; set => sanpham = value; }
        public List<TAnhSp> Anhsanpham { get => anhsanpham; set => anhsanpham = value; }
    }
}
