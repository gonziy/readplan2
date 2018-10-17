<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.article_list" ValidateRequest="false" %>
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
	const string channel = "news";
	const int pagesize = 10;

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n<title>查看书籍 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n");
	DataTable newsList = get_article_list(channel, category_id, pagesize, page, "status=0", out totalcount, out pagelist, "news_list", category_id, "__id__");

	int countEveryday = totalcount % 28 > 0 ?  totalcount / 28 + 1 : totalcount / 28;
	

	templateBuilder.Append("\r\n<script type=\"text/javascript\" charset=\"utf-8\">\r\n$(function(){\r\n\r\n})\r\nvar everydayCount = parseInt(");
	templateBuilder.Append(Utils.ObjectToStr(countEveryday));
	templateBuilder.Append(");\r\nfunction updateQuantity(count,id){\r\n	var inputCount = $(\".\"+id);\r\n	if(count<0){\r\n		if((parseInt(inputCount.val()) + parseInt(count))>0){\r\n			inputCount.val(parseInt(inputCount.val()) + parseInt(count));\r\n		}else{\r\n			alert(\"不能再少了\")\r\n		}\r\n	}else{\r\n		if((parseInt(inputCount.val()) + parseInt(count))>0){\r\n			inputCount.val(parseInt(inputCount.val()) + parseInt(count));\r\n		}\r\n	}\r\n	if(id==\"booksAllQuantity\"){\r\n		var bookCount = parseInt(inputCount.val()) / 28;\r\n		$(\"#booksAllQuantityplan\").html(\"每日整本读\"+bookCount+\"遍\");\r\n	}else if(id==\"booksQuantity\"){\r\n		var bookCount = parseInt(inputCount.val());\r\n		$(\"#booksQuantityplan\").html(\"每日分章读\"+bookCount+\"遍\");\r\n	}\r\n}\r\nfunction createPlan(id) {\r\n	$(\"#book\").attr(\"readonly\",\"readonly\");\r\n	$(\"#allbook\").attr(\"readonly\",\"readonly\");\r\n    var count = 0;\r\n    var type =\"\";\r\n    var user_id = \"1\";\r\n	if(id==\"book\"){\r\n	    count = $(\".booksQuantity\").val();\r\n        type = \"chapter\";\r\n	}else if(id==\"allbook\"){\r\n        count = $(\".booksAllQuantity\").val();\r\n	    type = \"book\"\r\n	}\r\n	$.post(\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=create_plan\",{count:count,type:type,user_id:user_id,category_id:\"");
	templateBuilder.Append(Utils.ObjectToStr(model.id));
	templateBuilder.Append("\"},function (data) {\r\n		var jsonObject = eval(\"(\"+data+\")\");\r\n		alert(jsonObject.msg);\r\n		location='calendar.aspx';\r\n    })\r\n}\r\n</");
	templateBuilder.Append("script>\r\n\r\n\r\n</head>\r\n\r\n<body>\r\n<div class=\"page-group\">\r\n	<div id=\"\" class=\"page page-current\">\r\n		<header class=\"bar bar-nav\">\r\n			<a class=\"button button-link button-nav pull-left back\" href=\"news.aspx\">\r\n				<span class=\"icon icon-left\"></span>\r\n			</a>\r\n			<h1 class=\"title\">读经计划</h1>\r\n		</header>\r\n        <nav class=\"bar bar-tab\">\r\n            <a class=\"tab-item external\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-home\"></span>\r\n                <span class=\"tab-label\">读经教育理念</span>\r\n            </a>\r\n            <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-me\"></span>\r\n                <span class=\"tab-label\">我</span>\r\n            </a>\r\n        </nav>\r\n		<div class=\"content\"><div class=\"content-padded\">\r\n			<div class=\"row no-gutter\" style=\"margin-bottom:1rem;\">\r\n				<div class=\"col-100\" style=\"text-align:center; font-size:.8rem;\">\r\n				<img src=\"");
	templateBuilder.Append(Utils.ObjectToStr(model.img_url));
	templateBuilder.Append("\" class=\"book_img\" style=\"width:40%; height:auto; margin:0 auto;\" />\r\n				<br />\r\n				<b>");
	templateBuilder.Append(Utils.ObjectToStr(model.title));
	templateBuilder.Append("</b>\r\n				</div>\r\n			</div>\r\n			\r\n			<div class=\"row no-gutter\">\r\n				<div class=\"col-60\" style=\"font-weight:bold; color:#f60;\">分章读计划</div>\r\n				<div class=\"col-40\" style=\"text-align:right\">\r\n					<span class=\"addQuantity\" onclick=\"updateQuantity('-1','booksQuantity');\" style=\"text-align:center;background:#eee;color:#000; padding:0 .5rem;float:left;height:1.2rem;border:1px solid #ccc;border-right:none;\">-</span>\r\n					<input style=\"width:2rem;text-align:center;float:left;height:1.2rem;border:1px solid #ccc;\" class=\"booksQuantity\" name=\"booksQuantity\" type=\"text\" value=\"1\" readonly=\"readonly\" />\r\n					<span class=\"removeQuantity\" onclick=\"updateQuantity('1','booksQuantity');\" style=\"text-align:center;background:#eee;color:#000; padding:0 .5rem;float:left;height:1.2rem;border:1px solid #ccc;border-left:none;\">+</span>\r\n				</div>\r\n			</div>\r\n			<div class=\"row\">\r\n				<div class=\"col-100\" id=\"booksQuantityplan\" style=\"font-size:.7rem;\">\r\n				每日分章读1遍\r\n				</div>\r\n			</div>\r\n			<div class=\"row\" style=\"font-size:.65rem;\">\r\n				<div class=\"col-100\">\r\n				说明：《");
	templateBuilder.Append(Utils.ObjectToStr(model.title));
	templateBuilder.Append("》每月28日读完一轮。剩余时间可以补读之前没有完成的计划。\r\n				</div>\r\n				<div class=\"col-100\">\r\n				规则：初始遍数为?遍（每天对应章数完成?遍），即为完成任务。\r\n				</div>\r\n				<div class=\"col-100\" style=\"margin-top:.5rem;\">\r\n					<a href=\"#\" class=\"button button-big button-fill button-warning\" id=\"book\" onclick=\"createPlan('book')\">生成分章读计划</a>\r\n				</div>\r\n			</div>\r\n			<br /><br />\r\n			<div class=\"row no-gutter\">\r\n				<div class=\"col-60\" style=\"font-weight:bold; color:#229073;\">整本读计划</div>\r\n				<div class=\"col-40\" style=\"text-align:right\">\r\n					<span class=\"addAllQuantity\" onclick=\"updateQuantity('-28','booksAllQuantity');\" style=\"text-align:center;background:#eee;color:#000; padding:0 .5rem;float:left;height:1.2rem;border:1px solid #ccc;border-right:none;\">-</span>\r\n					<input style=\"width:2rem;text-align:center;float:left;height:1.2rem;border:1px solid #ccc;\" class=\"booksAllQuantity\" name=\"booksAllQuantity\" type=\"text\" value=\"28\" everydayCount=\"");
	templateBuilder.Append(Utils.ObjectToStr(countEveryday));
	templateBuilder.Append("\" readonly />\r\n					<span class=\"removeAllQuantity\" onclick=\"updateQuantity('28','booksAllQuantity');\" style=\"text-align:center;background:#eee;color:#000; padding:0 .5rem;float:left;height:1.2rem;border:1px solid #ccc;border-left:none;\">+</span>\r\n				</div>\r\n			</div>\r\n			<div class=\"row\">\r\n				<div class=\"col-100\" id=\"booksAllQuantityplan\" style=\"font-size:.7rem;\">\r\n				每日整本读1遍\r\n				</div>\r\n			</div>\r\n			<div class=\"row\" style=\"font-size:.65rem;\">\r\n				<div class=\"col-100\">\r\n				说明：选择整本读计划，适用于每天有长时间诵读，喜欢正本诵读完成的朋友。\r\n				</div>\r\n				<div class=\"col-100\">\r\n				规则：初始遍数为28遍，即每天一遍。点“+”一次，为56遍，即为每天两遍。\r\n				</div>\r\n				<div class=\"col-100\" style=\"margin-top:.5rem;\">\r\n					<a href=\"#\" class=\"button button-big button-fill\" id=\"allbook\" onclick=\"createPlan('allbook')\">生成整本读计划</a>\r\n				</div>\r\n			</div>\r\n		</div></div>\r\n	</div>\r\n</div>\r\n\r\n</body>\r\n</html>\r\n");
	Response.Write(templateBuilder.ToString());
}
</script>
