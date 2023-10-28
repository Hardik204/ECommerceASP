using ECommerce2.Models;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.EnterpriseServices;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;

namespace ECommerce2.DAL
{
    public class Product_DALBase
    {
        string conn = ConfigurationManager.ConnectionStrings["ECommerceConnectionString"].ConnectionString;

        #region PR_Product_SelectByPK
        public ProductDetailModel PR_Product_SelectByPK(int id)
        {
            try
            {
                SqlDatabase sqlDB = new SqlDatabase(conn);
                DbCommand dbCMD = sqlDB.GetStoredProcCommand("PR_Product_SelectByPK");
                sqlDB.AddInParameter(dbCMD, "id", SqlDbType.Int, id);

                DataTable dt = new DataTable();
                using (IDataReader dr = sqlDB.ExecuteReader(dbCMD))
                {
                    dt.Load(dr);
                }
                ProductDetailModel modelProductDetail = new ProductDetailModel();
                foreach (DataRow drow in dt.Rows)
                {
                    modelProductDetail.Name = drow["Name"].ToString();
                    modelProductDetail.Category = drow["Category"].ToString();
                    modelProductDetail.Model = drow["Model"].ToString();
                    modelProductDetail.Brand = drow["Brand"].ToString();
                    modelProductDetail.Manufacturer = drow["Manufacturer"].ToString();
                    modelProductDetail.Size = drow["Size"].ToString();
                    modelProductDetail.Variant = drow["Variant"].ToString();
                    modelProductDetail.Color = drow["Color"].ToString();
                    modelProductDetail.Description = drow["Description"].ToString();
                    modelProductDetail.CostPrice = Convert.ToDecimal(drow["CostPrice"].ToString());
                    modelProductDetail.SalePrice = Convert.ToDecimal(drow["SalePrice"].ToString());
                    modelProductDetail.Images = drow["Images"].ToString();
                }
                return modelProductDetail;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

        #region Product_Insert
        public int PR_Prodcut_Insert(ProductDetailModel product)
        {
            try
            {
                SqlDatabase sqlDB = new SqlDatabase(conn);
                DbCommand dbCMD = sqlDB.GetStoredProcCommand("PR_Product_Insert");
                sqlDB.AddInParameter(dbCMD,"name",SqlDbType.NVarChar,product.Name);
                sqlDB.AddInParameter(dbCMD, "model", SqlDbType.NVarChar, product.Model);
                sqlDB.AddInParameter(dbCMD, "category", SqlDbType.NVarChar, product.Category);
                sqlDB.AddInParameter(dbCMD, "brand", SqlDbType.NVarChar, product.Brand);
                sqlDB.AddInParameter(dbCMD, "manufacturer", SqlDbType.NVarChar, product.Manufacturer);
                sqlDB.AddInParameter(dbCMD, "size", SqlDbType.NVarChar, product.Size);
                sqlDB.AddInParameter(dbCMD, "variant", SqlDbType.NVarChar, product.Variant);
                sqlDB.AddInParameter(dbCMD, "color", SqlDbType.NVarChar, product.Color);
                sqlDB.AddInParameter(dbCMD, "description", SqlDbType.NVarChar, product.Description);
                sqlDB.AddInParameter(dbCMD, "costprice", SqlDbType.Decimal, product.CostPrice);
                sqlDB.AddInParameter(dbCMD, "saleprice", SqlDbType.Decimal, product.SalePrice);
                sqlDB.AddInParameter(dbCMD, "Images", SqlDbType.NVarChar, product.Images);

                int status = sqlDB.ExecuteNonQuery(dbCMD);
                return status;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }
        #endregion

        #region Product_Delete
        public int PR_Product_Delete(int id)
        {
            try
            {
                SqlDatabase sqlDB = new SqlDatabase(conn);
                DbCommand dbCMD = sqlDB.GetStoredProcCommand("PR_Product_Delete");
                sqlDB.AddInParameter(dbCMD,"id",SqlDbType.Int,id);
                int status = sqlDB.ExecuteNonQuery(dbCMD);
                return status;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }
        #endregion

        #region Product_Update
        public int PR_Prodcut_Update(ProductDetailModel product)
        {
            try
            {
                SqlDatabase sqlDB = new SqlDatabase(conn);
                DbCommand dbCMD = sqlDB.GetStoredProcCommand("PR_Product_Update");
                sqlDB.AddInParameter(dbCMD, "id", SqlDbType.Int, product.Id);
                sqlDB.AddInParameter(dbCMD, "name", SqlDbType.NVarChar, product.Name);
                sqlDB.AddInParameter(dbCMD, "model", SqlDbType.NVarChar, product.Model);
                sqlDB.AddInParameter(dbCMD, "category", SqlDbType.NVarChar, product.Category);
                sqlDB.AddInParameter(dbCMD, "brand", SqlDbType.NVarChar, product.Brand);
                sqlDB.AddInParameter(dbCMD, "manufacturer", SqlDbType.NVarChar, product.Manufacturer);
                sqlDB.AddInParameter(dbCMD, "size", SqlDbType.NVarChar, product.Size);
                sqlDB.AddInParameter(dbCMD, "variant", SqlDbType.NVarChar, product.Variant);
                sqlDB.AddInParameter(dbCMD, "color", SqlDbType.NVarChar, product.Color);
                sqlDB.AddInParameter(dbCMD, "description", SqlDbType.NVarChar, product.Description);
                sqlDB.AddInParameter(dbCMD, "costprice", SqlDbType.Decimal, product.CostPrice);
                sqlDB.AddInParameter(dbCMD, "saleprice", SqlDbType.Decimal, product.SalePrice);
                sqlDB.AddInParameter(dbCMD, "images", SqlDbType.NVarChar, product.Images);

                int status = sqlDB.ExecuteNonQuery(dbCMD);
                return status;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
        #endregion
    }
}