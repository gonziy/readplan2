<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.userreadlog" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n<title>读经记录 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n<meta name=\"keywords\" content=\"");
	templateBuilder.Append(Utils.ObjectToStr(site.seo_keyword));
	templateBuilder.Append("\" />\r\n<meta name=\"description\" content=\"");
	templateBuilder.Append(Utils.ObjectToStr(site.seo_description));
	templateBuilder.Append("\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/swiper.css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n</head>\r\n\r\n<body>\r\n\r\n\r\n\r\n    ");
	if (action=="zhengben")
	{

	List<DTcms.Model.UserReadLog> list = get_user_read_log_list(" read_type='0' and user_id='"+userModel.id +"' and read_count>= plan_read_count");

	int now_category_id = 0;

	int now_category_id_count = 0;

	string now_category_title = "";

	templateBuilder.Append("\r\n	<div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n			<header class=\"bar bar-nav\">\r\n				<a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n					<span class=\"icon icon-left\"></span>\r\n				</a>\r\n				<h1 class=\"title\">我的读经</h1>\r\n			</header>\r\n            <div class=\"content\">\r\n			\r\n\r\n                <div class=\"banner\" style=\" position:relative;\">\r\n                    <div class=\"my-info\" style=\" position:absolute; left:4.5rem; top:1.5rem; font-size:.75rem; z-index:9;\">\r\n						<img src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/images/face_icon.png\" style=\" position:absolute; left:-4rem; top:-.5rem; font-size:.75rem; z-index:9; width:3rem;height:3rem;\" />\r\n                        昵称：");
	templateBuilder.Append(Utils.ObjectToStr(userModel.nick_name));
	templateBuilder.Append("<br />\r\n                        等级：");
	templateBuilder.Append(Utils.ObjectToStr(groupModel.title));
	templateBuilder.Append("\r\n                    </div>\r\n                    <div id=\"banner\" class=\"swiper-container\">\r\n                        <div class=\"swiper-wrapper\">\r\n                            ");
	DataTable adList = get_article_list("article", 1053, 5,"status=0");

	templateBuilder.Append("<!--取得一个分页DataTable-->\r\n                            ");
	foreach(DataRow dr in adList.Rows)
	{

	templateBuilder.Append("\r\n                            <div style='width: 100%; height: 7rem' class=\"swiper-slide\"><img style=\"width:100%\" src=\"" + Utils.ObjectToStr(dr["img_url"]) + "\" /></div>\r\n                            ");
	}	//end for if

	templateBuilder.Append("\r\n\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n\r\n				<div class=\"buttons-tab\">\r\n				  <a href=\"#tab1\" class=\"tab-link active button\">已读完整经典</a>\r\n				  <a href=\"?action=lingsan\" class=\"tab-link button\">已读零散经典</a>\r\n				  <a href=\"?action=hecheng\" class=\"tab-link button\">合成</a>\r\n				</div>\r\n				<div class=\"tabs\">\r\n					<div id=\"tab1\" class=\"tab active\">\r\n							<div class=\"list-block\" style=\"margin:0\">\r\n								<ul>\r\n								");
	if (list.Count>0)
	{

	foreach(DTcms.Model.UserReadLog log in list)
	{

										if(now_category_id != DTcms.Common.TypeConverter.ObjectToInt(log.category_id))
										{
										
											now_category_id_count=0;
											now_category_id_count++;
											now_category_title = get_article_category(DTcms.Common.TypeConverter.ObjectToInt(log.category_id)).title;
											now_category_id = DTcms.Common.TypeConverter.ObjectToInt(log.category_id);
										}else{
											now_category_id_count++;
										}
										

	}	//end for if

	templateBuilder.Append("\r\n								\r\n									<li class=\"item-content\">\r\n										<div class=\"item-media\"><i class=\"icon icon-f7\"></i></div>\r\n										<div class=\"item-inner\">\r\n											<div class=\"item-title\">《");
	templateBuilder.Append(Utils.ObjectToStr(now_category_title));
	templateBuilder.Append("》</div>\r\n											<div class=\"item-after\"><span class=\"badge\">");
	templateBuilder.Append(Utils.ObjectToStr(now_category_id_count));
	templateBuilder.Append("</span></div>\r\n										</div>\r\n									</li>\r\n								");
	}
	else
	{

	templateBuilder.Append("\r\n										<li class=\"item-content\">\r\n											<div class=\"item-inner\" style=\"text-align:center;\">\r\n												<div class=\"item-title\">暂无记录</div>\r\n											</div>\r\n										</li>\r\n								");
	}	//end for if

	templateBuilder.Append("\r\n								</ul>\r\n							</div>\r\n					</div>\r\n				</div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n   \r\n\r\n    ");
	}
	else if (action=="lingsan")
	{

	List<DTcms.Model.UserReadLog> list = get_user_read_log_list(" read_type='1' and user_id='"+userModel.id +"' and read_count>'0'");

	List<DTcms.Model.UserReadLog> newlist = new List<DTcms.Model.UserReadLog>();

	int now_category_id = 0;

	int now_category_id_count = 0;

	string now_category_title = "";

	int now_article_id = 0;

	int now_article_id_count = 0;

	string now_article_title = "";

	templateBuilder.Append("\r\n	<div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n		\r\n			<header class=\"bar bar-nav\">\r\n				<a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n					<span class=\"icon icon-left\"></span>\r\n				</a>\r\n				<h1 class=\"title\">我的读经</h1>\r\n			</header>\r\n            <div class=\"content\">\r\n				<div style=\"position:fixed;z-index:9999;\">\r\n                <div class=\"banner\" style=\" position:relative;\">\r\n                    <div class=\"my-info\" style=\" position:absolute; left:4.5rem; top:1.5rem; font-size:.75rem; z-index:9;\">\r\n						<img src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/images/face_icon.png\" style=\" position:absolute; left:-4rem; top:-.5rem; font-size:.75rem; z-index:9; width:3rem;height:3rem;\" />\r\n                        昵称：");
	templateBuilder.Append(Utils.ObjectToStr(userModel.nick_name));
	templateBuilder.Append("<br />\r\n                        等级：");
	templateBuilder.Append(Utils.ObjectToStr(groupModel.title));
	templateBuilder.Append("\r\n                    </div>\r\n                    <div id=\"banner\" class=\"swiper-container\">\r\n                        <div class=\"swiper-wrapper\">\r\n                            ");
	DataTable adList = get_article_list("article", 1053, 5,"status=0");

	templateBuilder.Append("<!--取得一个分页DataTable-->\r\n                            ");
	foreach(DataRow dr in adList.Rows)
	{

	templateBuilder.Append("\r\n                            <div style='width: 100%; height: 7rem' class=\"swiper-slide\"><img style=\"width:100%\" src=\"" + Utils.ObjectToStr(dr["img_url"]) + "\" /></div>\r\n                            ");
	}	//end for if

	templateBuilder.Append("\r\n\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n				</div>\r\n\r\n\r\n				<div class=\"buttons-tab\" style=\"margin-top:7rem\">\r\n				  <a href=\"?action=zhengben\" class=\"tab-link button\">已读完整经典</a>\r\n				  <a href=\"#tab2\" class=\"tab-link active button\">已读零散经典</a>\r\n				  <a href=\"?action=hecheng\" class=\"tab-link button\">合成</a>\r\n				</div>\r\n				<div class=\"tabs\">\r\n					<div id=\"tab1\" class=\"tab active\">\r\n							<div class=\"list-block\" style=\"margin:0\">\r\n								<ul>\r\n								");
	if (list.Count>0)
	{

	foreach(DTcms.Model.UserReadLog log in list)
	{

										if(now_article_id != DTcms.Common.TypeConverter.ObjectToInt(log.article_id))
										{
											now_article_id_count=0;
											now_article_id_count+= DTcms.Common.TypeConverter.ObjectToInt(log.read_count);
											now_article_title = get_article(DTcms.Common.TypeConverter.ObjectToInt(log.article_id)).title;
											now_category_title = get_article_category(DTcms.Common.TypeConverter.ObjectToInt(log.category_id)).title;
											now_article_id = DTcms.Common.TypeConverter.ObjectToInt(log.article_id);
											
											newlist.Add(log);
										}else{
											now_article_id_count+= DTcms.Common.TypeConverter.ObjectToInt(log.read_count);
											newlist.Find(x => x.article_id.ToString() == DTcms.Common.TypeConverter.ObjectToInt(log.article_id).ToString()).read_count += DTcms.Common.TypeConverter.ObjectToInt(log.read_count);
										}
										

	}	//end for if

	foreach(DTcms.Model.UserReadLog log in newlist)
	{

	templateBuilder.Append("\r\n								<li class=\"item-content\">\r\n										<div class=\"item-media\"><i class=\"icon icon-f7\"></i></div>\r\n										<div class=\"item-inner\">\r\n											<div class=\"item-title\">《");
	templateBuilder.Append(Utils.ObjectToStr(get_article_category(DTcms.Common.TypeConverter.ObjectToInt(log.category_id)).title));
	templateBuilder.Append("》");
	templateBuilder.Append(Utils.ObjectToStr(get_article(DTcms.Common.TypeConverter.ObjectToInt(log.article_id)).title));
	templateBuilder.Append("</div>\r\n											<div class=\"item-after\">已读");
	templateBuilder.Append(Utils.ObjectToStr(log.read_count));
	templateBuilder.Append("遍</div>\r\n										</div>\r\n									</li>\r\n								");
	}	//end for if

	}
	else
	{

	templateBuilder.Append("\r\n										<li class=\"item-content\">\r\n											<div class=\"item-inner\" style=\"text-align:center;\">\r\n												<div class=\"item-title\">暂无记录</div>\r\n											</div>\r\n										</li>\r\n								");
	}	//end for if

	templateBuilder.Append("\r\n								</ul>\r\n							</div>\r\n					</div>\r\n				</div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    ");
	}
	else if (action=="hecheng")
	{

	templateBuilder.Append("\r\n	<script type=\"text/javascript\">\r\n        function compose(category_id){\r\n			var user_id = \"");
	templateBuilder.Append(GetUserInfo().id.ToString().ToString());

	templateBuilder.Append("\";\r\n			$.post(\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=compose\",{user_id:user_id,category_id:category_id},function (data) {\r\n				var jsonObject = eval(\"(\"+data+\")\");\r\n				if(jsonObject.status==1) {\r\n					alert(jsonObject.msg);\r\n					location.reload();\r\n				}else{\r\n					alert(jsonObject.msg);\r\n				}\r\n			})\r\n		}\r\n    </");
	templateBuilder.Append("script>\r\n    ");
	List<DTcms.Model.ComposeList> list = get_user_compose_list(userModel.id);

	templateBuilder.Append("\r\n\r\n	<div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n		\r\n			<header class=\"bar bar-nav\">\r\n				<a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter2","index"));

	templateBuilder.Append("\">\r\n					<span class=\"icon icon-left\"></span>\r\n				</a>\r\n                <h1 class=\"title\">零散读经合成</h1>\r\n			</header>\r\n            <div class=\"content\">\r\n				<div class=\"tabs\">\r\n					<div id=\"tab1\" class=\"tab active\">\r\n							<div class=\"list-block\" style=\"margin:0\">\r\n								<ul>\r\n								");
	if (list.Count>0)
	{

	foreach(DTcms.Model.ComposeList compose in list)
	{

	templateBuilder.Append("\r\n								<li class=\"item-content\">\r\n										<div class=\"item-media\"><i class=\"icon icon-f7\"></i></div>\r\n										<div class=\"item-inner\">\r\n											<div class=\"item-title\">《");
	templateBuilder.Append(Utils.ObjectToStr(compose.category_title));
	templateBuilder.Append("》可合成");
	templateBuilder.Append(Utils.ObjectToStr(compose.count));
	templateBuilder.Append("本</div>\r\n											<div class=\"item-after\"><a href=\"javascript:;\" onclick=\"compose('");
	templateBuilder.Append(Utils.ObjectToStr(compose.category_id));
	templateBuilder.Append("')\">合成</a></div>\r\n										</div>\r\n									</li>\r\n								");
	}	//end for if

	}
	else
	{

	templateBuilder.Append("\r\n										<li class=\"item-content\">\r\n											<div class=\"item-inner\" style=\"text-align:center;\">\r\n												<div class=\"item-title\">暂无可合成经书</div>\r\n											</div>\r\n										</li>\r\n								");
	}	//end for if

	templateBuilder.Append("\r\n								</ul>\r\n							</div>\r\n					</div>\r\n				</div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    ");
	}	//end for if

	templateBuilder.Append("\r\n\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/swiper.jquery.min.js\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\">\r\n        $(function () {\r\n            var swiper = new Swiper('.swiper-container', {\r\n                loop: true,\r\n                autoplay: 5000\r\n            });\r\n        })\r\n    </");
	templateBuilder.Append("script>\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
