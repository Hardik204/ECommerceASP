using ECommerce2.DAL;
using ECommerce2.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Linq;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.DynamicData;
using System.Web.Mvc;
using System.Data.SqlClient;

namespace ECommerce2.Controllers
{
    public class HomeController : Controller
    {
        string conn = ConfigurationManager.ConnectionStrings["ECommerceConnectionString"].ConnectionString;

        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Privacy()
        {
            return View();
        }

        public ActionResult GetProducts(string price = "all" , string category = "all")
        {
            ECommerceDataContext db = new ECommerceDataContext(conn);
            //ISingleResult<PR_Product_SelectAllResult> allProducts = db.PR_Product_SelectAll();
            var allProducts = db.PR_Product_SelectAll().ToList();
            if(price != "all")
            {
                if (price == "lth")
                {
                    allProducts = (from i in allProducts orderby i.SalePrice select i).ToList<PR_Product_SelectAllResult>();
                }
                if(price == "htl")
                {
                    allProducts = allProducts.OrderByDescending(i => i.SalePrice).ToList<PR_Product_SelectAllResult>();
                }
            }
            else if(category != "all")
            {
                allProducts = (from i in allProducts where i.Category == category select i).ToList<PR_Product_SelectAllResult>();
            }
            return View(allProducts);
        }

        public ActionResult ProductDetails(int id)
        {

            ECommerceDataContext db = new ECommerceDataContext(conn);
            var products = db.PR_Product_SelectByPK(id);
            //ISingleResult<PR_ProductDetails_SelectByPkResult>  products = db.PR_ProductDetails_SelectByPk(id);
            PR_Product_SelectByPKResult product = null;
            foreach(var item in products)
            {
                product = item;
            }
            return View(product);
        }

        public ActionResult ProductInsert(int? id)
        {
            if(id == null)
            {
                return View();
            }
            else
            {
                Product_DALBase product_DAL = new Product_DALBase();
                ProductDetailModel modelProductDetail = product_DAL.PR_Product_SelectByPK((int)id);
                return View(modelProductDetail);
            }
        }

        [HttpPost]
        public ActionResult ProductInsert(ProductDetailModel product)
        {
            Product_DALBase product_DAL = new Product_DALBase();

            if (product.File != null)
            {
                try
                {
                    string path = Server.MapPath(@"~/App_Data/Uploads");
                    string fileName = Path.GetFileName(product.File.FileName);
                    string location = Path.Combine(path, fileName);
                    product.File.SaveAs(location);
                    product.Images = product.File.FileName ;    
                }
                catch (Exception e)
                {

                }
            }

            if (product.Id == null)
            {
                var status = product_DAL.PR_Prodcut_Insert(product);
                return RedirectToAction("GetProducts");
            }
            else
            {
                var status = product_DAL.PR_Prodcut_Update(product);
                return RedirectToAction("ProductDetails",new { id = product.Id});
            }
            
            //ECommerceDataContext db = new ECommerceDataContext(conn);
            //var status = db.PR_Product_Insert(product.Name,product.Model,product.Category,product.Brand,product.Manufacturer,product.Size,product.Variant,product.Color,product.Description,product.CostPrice,product.SalePrice,product.Images);
            ////db.Products.InsertOnSubmit(product);
            //if(status == 0)
            //{
            //    Response.Write("<script>alert('Data not inserted.')</script>");
            //    return RedirectToAction("ProductInsert");
            //}
            //else
            //    return View();
        }

        public ActionResult ProductDelete(int id)
        {
            Product_DALBase product_DAL = new Product_DALBase();
            var status = product_DAL.PR_Product_Delete(id);
            if(status == -1)
            {
                return RedirectToAction("ProductDetails",new { id = id });
            }
            else
            {
                return RedirectToAction("GetProducts");
            }
        }
    }
}