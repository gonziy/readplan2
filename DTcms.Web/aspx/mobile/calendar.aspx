<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.calendar" ValidateRequest="false" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Text" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="DTcms.Common" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by DTcms Template Engine at 2018-07-26 20:58:35.
		本页面代码由DTcms模板引擎生成于 2018-07-26 20:58:35. 
	*/

	base.OnInit(e);
	StringBuilder templateBuilder = new StringBuilder(220000);

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n<title>计划日历 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css?v=2\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n<script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/plugins/layer/layer.js?v=1\"></");
	templateBuilder.Append("script>\r\n<script type=\"text/javascript\" charset=\"utf-8\">\r\n	$(function(){\r\n		$(\"#calendar .thisMonth a\").height($(\"#calendar .thisMonth a\").width());\r\n	})\r\n</");
	templateBuilder.Append("script>\r\n<script type=\"text/javascript\">\r\n	function readbook(category_id,article_id,read_count,date_str) {\r\n        var user_id = \"");
	templateBuilder.Append(GetUserInfo().id.ToString().ToString());

	templateBuilder.Append("\";\r\n	    $.post(\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=plan_read\",{user_id:user_id,category_id:category_id,article_id:article_id,read_count:read_count,date_str:date_str},function (data) {\r\n            var jsonObject = eval(\"(\"+data+\")\");\r\n            if(jsonObject.status==1) {\r\n				layer.open({\r\n				  content: jsonObject.msg\r\n				  ,time: 5\r\n				  ,skin: 'msg'\r\n				});\r\n				setTimeout(\"location.reload()\",5000);\r\n            }else if(jsonObject.status==99) {\r\n				layer.open({\r\n				  content: '<img style=\"width:90%; margin:0 auto;\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/images/group_'+jsonObject.group_id+'.png\" />'\r\n				  ,style: 'text-align:center; background:none; border:none;' //自定风格\r\n				  ,time: 10\r\n				});\r\n				setTimeout(\"location.reload()\",10000);\r\n            }else{\r\n				layer.open({\r\n				  content: jsonObject.msg\r\n				  ,time: 5\r\n				  ,skin: 'msg'\r\n				});\r\n				setTimeout(\"location.reload()\",5000);\r\n			}\r\n        })\r\n    }\r\n</");
	templateBuilder.Append("script>\r\n\r\n\r\n</head>\r\n\r\n<body>\r\n<div class=\"page-group\">\r\n	<div id=\"\" class=\"page page-current\">\r\n		<header class=\"bar bar-nav\">\r\n			<a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n				<span class=\"icon icon-left\"></span>\r\n			</a>\r\n			<h1 class=\"title\">读经计划</h1>\r\n		</header>\r\n        <nav class=\"bar bar-tab\">\r\n            <a class=\"tab-item external\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-home\"></span>\r\n                <span class=\"tab-label\">读经教育理念</span>\r\n            </a>\r\n            <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-me\"></span>\r\n                <span class=\"tab-label\">我</span>\r\n            </a>\r\n        </nav>\r\n		<div class=\"content\">\r\n            <div class=\"content-padded\">\r\n                <div id=\"calendar\">\r\n					<div class=\"months\">\r\n						<div class=\"row\">\r\n							<div class=\"col-25\">");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append("&nbsp;/&nbsp;<span class=\"thisM\">");
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append("</span></div>\r\n							<div class=\"col-15\"><a href=\"?day=");
	templateBuilder.Append(Utils.ObjectToStr(pre2_year_month));
	templateBuilder.Append("01\">");
	templateBuilder.Append(pre2_year_month.Substring(4,2).ToString());

	templateBuilder.Append("月</a></div>\r\n							<div class=\"col-15\"><a href=\"?day=");
	templateBuilder.Append(Utils.ObjectToStr(pre1_year_month));
	templateBuilder.Append("01\">");
	templateBuilder.Append(pre1_year_month.Substring(4,2).ToString());

	templateBuilder.Append("月</a></div>\r\n							<div class=\"col-15 thisM\"><a href=\"?day=");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append("01\">");
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append("月</a></div>\r\n							<div class=\"col-15\"><a href=\"?day=");
	templateBuilder.Append(Utils.ObjectToStr(aft1_year_month));
	templateBuilder.Append("01\">");
	templateBuilder.Append(aft1_year_month.Substring(4,2).ToString());

	templateBuilder.Append("月</a></div>\r\n							<div class=\"col-15\"><a href=\"?day=");
	templateBuilder.Append(Utils.ObjectToStr(aft2_year_month));
	templateBuilder.Append("01\">");
	templateBuilder.Append(aft2_year_month.Substring(4,2).ToString());

	templateBuilder.Append("月</a></div>\r\n						</div>\r\n					</div>\r\n					<div class=\"thisMonth\">\r\n						");
							foreach(string d in daysInMonth)
							{
								if(d==date)
								{
								

	templateBuilder.Append("\r\n							<a class=\"today\" href=\"calendar.aspx?day=");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(d));
	templateBuilder.Append("\">\r\n								");
	templateBuilder.Append(Utils.ObjectToStr(d));
	templateBuilder.Append("\r\n								");
									if(!CompletePlan(GetUserInfo().id.ToString(),year+month+d))
									{
									

	templateBuilder.Append("\r\n								<span class=\"failed\"></span>\r\n								");
									}
									

	templateBuilder.Append("\r\n							</a>\r\n							");
								}
								else
								{
								

	templateBuilder.Append("\r\n                            <a href=\"calendar.aspx?day=");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(d));
	templateBuilder.Append("\">\r\n                                ");
	templateBuilder.Append(Utils.ObjectToStr(d));
	templateBuilder.Append("\r\n                                ");
	                                if(!CompletePlan(GetUserInfo().id.ToString(),year+month+d))
	                                {
	                                

	templateBuilder.Append("\r\n                                <span class=\"failed\"></span>\r\n                                ");
	                                }
	                                

	templateBuilder.Append("\r\n                            </a>\r\n							");
								}
							}
							

	templateBuilder.Append("\r\n						<div class=\"clear\"></div>\r\n					</div>\r\n                </div>\r\n				<div class=\"read-title\">今日应读内容</div>\r\n				<div class=\"read-plan\">\r\n					<ul>\r\n						<li class=\"row\">\r\n							<div class=\"col-50\" style=\"text-align:left\"><b>书名/章节</b></div>\r\n							<div class=\"col-20 textcenter\" style=\"width: 16%; margin-left: 4%\"><b>遍数</b></div>\r\n							<div class=\"col-30 textcenter\">&nbsp;</div>\r\n						</li>\r\n					");
						if(list!=null)
						{
							if(list.Count>0)
							{
								foreach(DTcms.Model.UserReadLog model in list)
								{
									if(DTcms.Common.TypeConverter.ObjectToInt(model.read_type)==1)
									{
									

	templateBuilder.Append("\r\n								<li class=\"row\">\r\n									<div class=\"col-50\">");
	templateBuilder.Append(GetArticleTitle(model.article_id).ToString());

	templateBuilder.Append("</div>\r\n									<div class=\"col-20 textcenter\" style=\"width: 16%; margin-left: 4%\">");
	templateBuilder.Append((DTcms.Common.TypeConverter.ObjectToInt(model.plan_read_count) - DTcms.Common.TypeConverter.ObjectToInt(model.read_count)).ToString());

	templateBuilder.Append("</div>\r\n									");
										if(DTcms.Common.TypeConverter.ObjectToDateTime(year+"/"+month+"/"+date)>DateTime.Now)
										{
										

	templateBuilder.Append("\r\n									<div class=\"col-30 textcenter complete\" style=\"width: 26%; margin-left: 4%\"><a href=\"javascript:;\" onclick=\"readbook('");
	templateBuilder.Append(Utils.ObjectToStr(model.category_id));
	templateBuilder.Append("','");
	templateBuilder.Append(Utils.ObjectToStr(model.article_id));
	templateBuilder.Append("','1','");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(date));
	templateBuilder.Append("')\">完成一遍</a></div>\r\n									");
										}
										else
										{
										

	templateBuilder.Append("\r\n									<div class=\"col-30 textcenter complete\" style=\"width: 26%; margin-left: 4%\"><a href=\"javascript:;\" onclick=\"readbook('");
	templateBuilder.Append(Utils.ObjectToStr(model.category_id));
	templateBuilder.Append("','");
	templateBuilder.Append(Utils.ObjectToStr(model.article_id));
	templateBuilder.Append("','1','");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(date));
	templateBuilder.Append("')\">完成一遍</a></div>\r\n									");
										}
										

	templateBuilder.Append("\r\n								</li>\r\n								");
									}
									else if(DTcms.Common.TypeConverter.ObjectToInt(model.read_type)==0)
									{
									

	templateBuilder.Append("\r\n								<li class=\"row\">\r\n									<div class=\"col-50\">");
	templateBuilder.Append(GetCategoryTitle(model.category_id).ToString());

	templateBuilder.Append("</div>\r\n									<div class=\"col-20 textcenter\" style=\"width: 16%; margin-left: 4%\">");
	templateBuilder.Append((DTcms.Common.TypeConverter.ObjectToInt(model.plan_read_count) - DTcms.Common.TypeConverter.ObjectToInt(model.read_count)).ToString());

	templateBuilder.Append("</div>\r\n									");
										if(DTcms.Common.TypeConverter.ObjectToDateTime(year+"/"+month+"/"+date)>DateTime.Now)
										{
										

	templateBuilder.Append("\r\n									<div class=\"col-30 textcenter complete\" style=\"width: 26%; margin-left: 4%\"><a href=\"javascript:;\" onclick=\"readbook('");
	templateBuilder.Append(Utils.ObjectToStr(model.category_id));
	templateBuilder.Append("','','1','");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(date));
	templateBuilder.Append("')\">完成一遍</a></div>\r\n									");
										}
										else
										{
										

	templateBuilder.Append("\r\n									<div class=\"col-30 textcenter complete\" style=\"width: 26%; margin-left: 4%\"><a href=\"javascript:;\" onclick=\"readbook('");
	templateBuilder.Append(Utils.ObjectToStr(model.category_id));
	templateBuilder.Append("','','1','");
	templateBuilder.Append(Utils.ObjectToStr(year));
	templateBuilder.Append(Utils.ObjectToStr(month));
	templateBuilder.Append(Utils.ObjectToStr(date));
	templateBuilder.Append("')\">完成一遍</a></div>\r\n									");
										}
										

	templateBuilder.Append("\r\n\r\n								</li>\r\n								");
									}
								}
							}
							else
							{
							

	templateBuilder.Append("\r\n						<li class=\"row\">\r\n							<div class=\"col-100 textcenter\">暂无任务</div>\r\n						</li>\r\n						");
							}
						}
						else
						{
						

	templateBuilder.Append("\r\n					<li class=\"row\">\r\n						<div class=\"col-100 textcenter\">暂无任务</div>\r\n					</li>\r\n					");
						}
						

	templateBuilder.Append("\r\n					</ul>\r\n				</div>\r\n			</div>\r\n	    </div>\r\n    </div>\r\n</div>\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
