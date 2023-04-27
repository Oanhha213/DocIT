using demo.Models;

namespace demo.ViewModels
{
    public class HomeProductDetailViewModel
    {
        private TDanhMucSp sanpham;
        private List<TAnhSp> anhSanPham;

        public TDanhMucSp Sanpham { get => sanpham; set => sanpham = value; }
        public List<TAnhSp> AnhSanPham { get => anhSanPham; set => anhSanPham = value; }
        public HomeProductDetailViewModel(TDanhMucSp sanpham, List<TAnhSp> anhSanPham)
        {
            this.sanpham = sanpham;
            this.anhSanPham = anhSanPham;
        }

    }
}
