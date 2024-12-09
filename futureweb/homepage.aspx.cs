using System;
using System.Data;
using System.Web.UI;

namespace futureweb
{
    public partial class homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayRandomText();
            }
        }

        private void DisplayRandomText()
        {
            try
            {
                DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                if (dv != null && dv.Count > 0)
                {
                    Label2.Text = dv[0]["text"].ToString();
                }
                else
                {
                    Label2.Text = "未找到文字！";
                }
            }
            catch (Exception ex)
            {
                Label2.Text = $"發生錯誤：{ex.Message}";
            }
        }

        protected void backBT_Click(object sender, EventArgs e)
        {
            // 返回上一页
            if (Request.UrlReferrer != null)
            {
                Response.Redirect(Request.UrlReferrer.ToString(), true);
            }
            else
            {
                Label2.Text = "無法返回上一頁！";
            }
        }
    }
}
