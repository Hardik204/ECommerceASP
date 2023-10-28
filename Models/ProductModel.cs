using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

namespace ECommerce2.Models
{
    public class ProductModel
    {
        private int? _id = null; 

        private int _productid;

        private string _name;

        private string _category;

        private string _model;

        private string _brand;

        private string _manufacturer;


        public int? Id 
        { 
            get
            {
                return _id;
                //if (_id != null)
                //    return (int)_id;
                //else
                //    return null;
            } 
            set
            {
               _id = value;
            } 
        }

        public int ProductId 
        { 
            get
            {
                return _productid;
            } 
            set
            {
                _productid = value;
            }
        }

        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }

        public string Category
        {
            get
            {
                return _category;
            }
            set
            {
                _category = value;
            }
        }

        public string Model
        {
            get
            {
                return _model;
            }
            set
            {
                _model = value;
            }
        }

        public string Brand
        {
            get
            {
                return _brand;
            }
            set
            {
                _brand = value;
            }
        }

        public string Manufacturer
        {
            get
            {
                return _manufacturer;
            }
            set
            {
                _manufacturer = value;
            }
        }

        
    }

    public class ProductDetailModel : ProductModel
    {
        private string _size;

        private string _variant;

        private string _color;

        private string _description;

        private System.Nullable<decimal> _costPrice;

        private System.Nullable<decimal> _salePrice;

        private string _images;

        
        public HttpPostedFileBase File { get; set; }


        public string Size
        {
            get
            {
                return _size;
            }
            set
            {
                _size = value;
            }
        }

        public string Variant
        {
            get
            {
                return _variant;
            }
            set
            {
                _variant = value;
            }
        }

        public string Color
        {
            get
            {
                return _color;
            }
            set
            {
                _color = value;
            }
        }

        public string Description
        {
            get
            {
                return _description;
            }
            set
            {
                _description = value;
            }
        }
        public decimal? CostPrice
        {
            get
            {
                return _costPrice;
            }
            set
            {
                _costPrice = value;
            }
        }

        public decimal? SalePrice
        {
            get
            {
                return _salePrice;
            }
            set
            {
                _salePrice = value;
            }
        }

        public string Images
        {
            get
            {
                return _images;
            }
            set
            {
                _images = value;
            }
        }

    }
}