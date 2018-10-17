using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.API.Payment.wxpay;
using DTcms.Common;

namespace DTcms.Web.api.payment.wxapipay
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //获得订单信息
            string order_no = DTRequest.GetQueryString("pay_order_no");
            decimal order_amount = DTRequest.GetQueryDecimal("pay_order_amount", 0);

            //检查参数是否正确
            if (string.IsNullOrEmpty(order_no) || order_amount == 0)
            {
                
                Response.Redirect(new Web.UI.BasePage().linkurl("error", "?msg=" + Utils.UrlEncode("对不起，您提交的参数有误！")));
                return;
            }

            //调用【网页授权获取用户信息】接口获取用户的openid和access_token
            JsApiConfig jsApiConfig = new JsApiConfig();
            WxPayData data = new WxPayData();
            data.SetValue("appid", jsApiConfig.AppId);
            data.SetValue("redirect_uri", HttpUtility.UrlEncode(jsApiConfig.Redirect_url));
            data.SetValue("response_type", "code");
            data.SetValue("scope", "snsapi_base");
            data.SetValue("state", order_no + "#wechat_redirect"); //传入订单号
            string url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + data.ToUrl();
            try
            {
                //触发微信返回code码         
                Response.Redirect(url);//Redirect函数会抛出ThreadAbortException异常，不用处理这个异常
            }
            catch (System.Threading.ThreadAbortException ex)
            {

            }
        }
    }
}