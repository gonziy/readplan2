using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.API.Payment.wxpay;
using DTcms.Common;

namespace DTcms.Web.api.payment.wxapipay
{
    public partial class notify_url : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WxPayData notifyData = JsApiPay.GetNotifyData();
            LogHelper.WriteDebugLog("[wxapppay]" + notifyData.ToJson());

            //检查支付结果中transaction_id是否存在
            if (!notifyData.IsSet("transaction_id"))
            {
                //若transaction_id不存在，则立即返回结果给微信支付后台
                WxPayData res = new WxPayData();
                res.SetValue("return_code", "FAIL");
                res.SetValue("return_msg", "支付结果中微信订单号不存在");
                Response.Write(res.ToXml());
                return;
            }

            string transaction_id = notifyData.GetValue("transaction_id").ToString(); //微信支付订单号

            //查询订单，判断订单真实性
            if (!QueryOrder(transaction_id))
            {
                //若订单查询失败，则立即返回结果给微信支付后台
                WxPayData res = new WxPayData();
                res.SetValue("return_code", "FAIL");
                res.SetValue("return_msg", "订单查询失败");
                Response.Write(res.ToXml());
                return;
            }

            //获取订单信息
            string order_no = notifyData.GetValue("out_trade_no").ToString(); //商户订单号
            string total_fee = notifyData.GetValue("total_fee").ToString(); //获取总金额

            BLL.users bll = new BLL.users();
            List<Model.users> list = bll.GetModelByWx(order_no);
            foreach (Model.users u in list)
            {
                bll.UpdateField(u.id, "[is_pay]='1'");
            }

            //返回成功通知
            WxPayData res1 = new WxPayData();
            res1.SetValue("return_code", "SUCCESS");
            res1.SetValue("return_msg", "OK");
            Response.Write(res1.ToXml());
            return;
        }

        //查询订单
        private bool QueryOrder(string transaction_id)
        {
            WxPayData req = new WxPayData();
            req.SetValue("transaction_id", transaction_id);
            WxPayData res = JsApiPay.OrderQuery(req);
            if (res.GetValue("return_code").ToString() == "SUCCESS" &&
                res.GetValue("result_code").ToString() == "SUCCESS")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

    }
}