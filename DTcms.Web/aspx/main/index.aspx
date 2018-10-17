<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.index" ValidateRequest="false" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Text" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="DTcms.Common" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by DTcms Template Engine at 2018-10-17 17:52:22.
		本页面代码由DTcms模板引擎生成于 2018-10-17 17:52:22. 
	*/

	base.OnInit(e);
	StringBuilder templateBuilder = new StringBuilder(220000);

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n    <title>我的 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n\r\n</head>\r\n\r\n<body>\r\n    ");
	    List<DTcms.Model.users> userlist = new List<DTcms.Model.users>();
	    bool is_pay = false;
	    string openid = "";
		string pay_id = DateTime.Now.ToString("yyyyMMddHHmmssfff");
	    openid = DTcms.Common.DTRequest.GetString("openid");
	            if (string.IsNullOrEmpty(openid))
	            {
	                openid = DTcms.Common.Utils.GetCookie("openid");
	            }
	            DTcms.BLL.users bll = new DTcms.BLL.users();
				if(!string.IsNullOrEmpty(openid))
				{
					if (bll.ExistsWxOpenID(openid))
					{
						userlist.AddRange(bll.GetModelByWx(openid));
						if (userlist != null)
						{
							if (userlist.Count > 0)
							{
								is_pay = true;
							}
						}
					}else{
					
						DTcms.Model.UserPay userPay = new DTcms.Model.UserPay();
						userPay.add_time = DateTime.Now;
						userPay.amount = 9.28M;
						userPay.id = pay_id;
						userPay.openid = openid;
						userPay.status = 0;
						new DTcms.BLL.UserPay().Add(userPay);
					}
	
				 

	templateBuilder.Append("\r\n			 <div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n            <header class=\"bar bar-nav\">\r\n                <h1 class=\"title\">选择账户</h1>\r\n            </header>\r\n            <div class=\"content\">\r\n				<p style=\" width:100%; font-size:1.4rem; text-align:center; color:#229073; margin:1.2rem auto;\">\r\n				读，见真知\r\n				</p>\r\n                \r\n                        ");
	if (is_pay)
	{

	if (userlist!=null)
	{

	templateBuilder.Append("\r\n								<div style=\"margin:0\">\r\n								<ul style=\" background:url('");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/images/account_bg.png') no-repeat; background-size:100%;\">\r\n								");
	int num = 1;

	foreach(DTcms.Model.users model in userlist)
	{

	if (model.is_show==1)
	{

	if (num==1)
	{

	templateBuilder.Append("\r\n								<li onclick=\"location='autologin.aspx?username=");
	templateBuilder.Append(Utils.ObjectToStr(model.user_name));
	templateBuilder.Append("'\">\r\n									<div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#fff;\">\r\n										");
	templateBuilder.Append(Utils.ObjectToStr(model.nick_name));
	templateBuilder.Append("\r\n									</div>\r\n								</li>\r\n								");
	}
	else
	{

	templateBuilder.Append("\r\n								<li onclick=\"location='autologin.aspx?username=");
	templateBuilder.Append(Utils.ObjectToStr(model.user_name));
	templateBuilder.Append("'\">\r\n									<div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#229073;\">\r\n										");
	templateBuilder.Append(Utils.ObjectToStr(model.nick_name));
	templateBuilder.Append("\r\n									</div>\r\n								</li>\r\n								");
	}	//end for if

	}	//end for if

									num++;
									

	}	//end for if

	templateBuilder.Append("\r\n								</ul>\r\n								</div>\r\n							");
	}	//end for if

	}
	else
	{

	templateBuilder.Append("\r\n						<div class=\"list-block\" style=\"margin:0\">\r\n							<ul>\r\n								<li class=\"item-content item-link\" onclick=\"location='");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("api/payment/wxapipay/index.aspx?pay_order_no=");
	templateBuilder.Append(Utils.ObjectToStr(pay_id));
	templateBuilder.Append("&pay_order_amount=9.28'\">\r\n									<div class=\"item-media\"><i class=\"icon icon-f7\"></i></div>\r\n									<div class=\"item-inner\">\r\n										<div class=\"item-title\" style=\" color:#229073;\">开通帐户</div>\r\n									</div>\r\n								</li>\r\n							</ul>\r\n						</div>\r\n                        ");
	}	//end for if

	templateBuilder.Append("\r\n				<div class=\"content-padded\">\r\n					<p style=\"font-size:.65rem; color:#229073; line-height:2\">\r\n					\r\n					</p>\r\n				</div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n			  ");
				}else{
				

	templateBuilder.Append("\r\n			 <div class=\"page-group\">\r\n				<div id=\"\" class=\"page page-current\">\r\n					<header class=\"bar bar-nav\">\r\n						<h1 class=\"title\">选择账户</h1>\r\n					</header>\r\n					<div class=\"content\">\r\n						<div class=\"list-block\" style=\"margin:0\">\r\n							<ul>\r\n								<li class=\"item-content item-link\" onclick=\"location='wx_login.aspx'\">\r\n									<div class=\"item-media\"><i class=\"icon icon-f7\"></i></div>\r\n									<div class=\"item-inner\">\r\n										<div class=\"item-title\" style=\" color:#229073;\">获取账户信息失败,点此刷新</div>\r\n									</div>\r\n								</li>\r\n							</ul>\r\n						</div>\r\n						<div class=\"content-padded\">\r\n							<p style=\"font-size:.65rem; color:#229073; line-height:2\">\r\n							*本读经打卡软件旨在于培养在全日制读经学堂外读经习惯的养成，帮助营造经典书香家庭氛围，辅助家长养成读经习惯。</p>\r\n							<p style=\"font-size:.65rem; color:#229073; line-height:2\">\r\n								* 长期坚持使用打卡软件，读经量实现积累之后，孩子将来入读学堂，部分学堂将对坚持在家读经孩子学费优惠。\r\n							</p>\r\n						</div>\r\n					</div>\r\n				</div>\r\n			</div>\r\n			  ");
				}
	    

	templateBuilder.Append("\r\n    \r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
