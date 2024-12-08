using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace futureweb
{
    public partial class homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Random();
            }
        }
        private void Random()
        {
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count > 0)
            {
                Label2.Text = dv[0]["text"].ToString(); // 將隨機文字更新到 Label2
            }
            else
            {
                Label2.Text = "未找到隨機資料！"; // 如果資料表為空
            }
        }
        protected void backBT_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.UrlReferrer.ToString(), true);

        }
    }
}