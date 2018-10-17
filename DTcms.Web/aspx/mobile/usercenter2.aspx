<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.usercenter" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\" />\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n    <title>我的 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/swiper.css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n\r\n\r\n    <script type=\"text/javascript\">\r\n	function addAccount(){\r\n		var user_id = \"");
	templateBuilder.Append(GetUserInfo().id.ToString().ToString());

	templateBuilder.Append("\";\r\n		$.post(\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=show_next_account\",{user_id:user_id},function (data) {\r\n			var jsonObject = eval(\"(\"+data+\")\");\r\n			alert(jsonObject.msg);			\r\n		})\r\n	}\r\n	</");
	templateBuilder.Append("script>\r\n</head>\r\n\r\n<body>\r\n\r\n    ");
	if (action=="index")
	{

	templateBuilder.Append("\r\n    <div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n            <header class=\"bar bar-nav\">\r\n                <h1 class=\"title\">读经计划</h1>\r\n            </header>\r\n            <nav class=\"bar bar-tab\">\r\n                <a class=\"tab-item external\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                    <span class=\"icon icon-home\"></span>\r\n                    <span class=\"tab-label\">读经教育理念</span>\r\n                </a>\r\n                <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n                    <span class=\"icon icon-me\"></span>\r\n                    <span class=\"tab-label\">我</span>\r\n                </a>\r\n            </nav>\r\n            <div class=\"content\">\r\n\r\n                <div class=\"banner\" style=\" position:relative;\">\r\n                    <div class=\"my-info\" style=\" position:absolute; left:4.5rem; top:1.5rem; font-size:.75rem; z-index:9;\">\r\n						<img src=\"");
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

	templateBuilder.Append("\r\n\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n                <div class=\"list-block\" style=\"margin:0;\">\r\n                    <ul>\r\n                        <li class=\"item-content\" onclick=\"location='userreadlog.aspx?action=hecheng'\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-f7\"><img src=\"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNTMyNTY4MTIzNjgxIiBjbGFzcz0iaWNvbiIgc3R5bGU9IiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9Ijk1NyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2Ij48ZGVmcz48c3R5bGUgdHlwZT0idGV4dC9jc3MiPjwvc3R5bGU+PC9kZWZzPjxwYXRoIGQ9Ik00ODYuMTA1MDU4IDUxLjk4OTg0NkMyMTcuNjU3NDg5IDUxLjk4OTg0NiAwLjA5OTk4IDI2OS41NDczNTQgMC4wOTk5OCA1MzcuOTk0OTIzYzAgMjY4LjM0NzU4OCAyMTcuNTU3NTA4IDQ4Ni4wMDUwNzcgNDg2LjAwNTA3OCA0ODYuMDA1MDc3IDI2OC4zNDc1ODggMCA0ODYuMDA1MDc3LTIxNy41NTc1MDggNDg2LjAwNTA3Ny00ODYuMDA1MDc3SDQ4Ni4xMDUwNThWNTEuOTg5ODQ2eiIgZmlsbD0iIzI4NjhGMCIgcC1pZD0iOTU4Ij48L3BhdGg+PHBhdGggZD0iTTUzNy44OTQ5NDIgMC4wOTk5OHY0ODYuMDA1MDc4aDQ4Ni4wMDUwNzhDMTAyMy45MDAwMiAyMTcuNjU3NDg5IDgwNi4zNDI1MTEgMC4wOTk5OCA1MzcuODk0OTQyIDAuMDk5OTh6IiBmaWxsPSIjOEZCM0ZGIiBwLWlkPSI5NTkiPjwvcGF0aD48L3N2Zz4=\" width=\"18\" /></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title\">零散合成</div>\r\n\r\n                            </div>\r\n                        </li>\r\n                        <li class=\"item-content\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-f7\"><img src=\"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNTMwMTk1NDMwNTkyIiBjbGFzcz0iaWNvbiIgc3R5bGU9IiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjY5NDUiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMjU2IiBoZWlnaHQ9IjI1NiI+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj48L3N0eWxlPjwvZGVmcz48cGF0aCBkPSJNNTExLjMgNDk2LjNtLTQ0OCAwYTQ0OCA0NDggMCAxIDAgODk2IDAgNDQ4IDQ0OCAwIDEgMC04OTYgMFoiIGZpbGw9IiNGRkQ5NkIiIHAtaWQ9IjY5NDYiPjwvcGF0aD48cGF0aCBkPSJNODI4LjIgMTc5LjdMMTk0LjcgODEzLjNjMTc1IDE3NC44IDQ1OC41IDE3NC44IDYzMy40LTAuMSAxNzQuOS0xNzUgMTc1LTQ1OC41IDAuMS02MzMuNXoiIGZpbGw9IiNGREMyMjMiIHAtaWQ9IjY5NDciPjwvcGF0aD48cGF0aCBkPSJNNTExLjMgNDk2LjNtLTMyNS43IDBhMzI1LjcgMzI1LjcgMCAxIDAgNjUxLjQgMCAzMjUuNyAzMjUuNyAwIDEgMC02NTEuNCAwWiIgZmlsbD0iI0Y5QUIxMCIgcC1pZD0iNjk0OCI+PC9wYXRoPjxwYXRoIGQ9Ik03MzQuNiAyNTkuN0M2MDcgMTM5LjIgNDA2IDE0MS4xIDI4MSAyNjZjLTEyNC45IDEyNS0xMjYuOCAzMjYtNi4zIDQ1My42bDQ1OS45LTQ1OS45eiIgZmlsbD0iI0Y5QjcyMSIgcC1pZD0iNjk0OSI+PC9wYXRoPjxwYXRoIGQ9Ik00ODMuMyA1ODguNGgtODAuMnYtNDcuOGg4MC4ydi0yNS45aC04MC4ydi00Ny44aDU2LjRsLTY3LjItMTM2LjRoNjYuNmw0My4yIDkyLjFjNS41IDExLjUgOS40IDIxLjcgMTEuNyAzMC41IDIuNy05LjUgNi42LTE5LjcgMTEuNy0zMC41bDQ0LjEtOTIuMWg2Ni42bC02OC4xIDEzNi40aDU3LjN2NDcuOGgtODEuM3YyNS45aDgxLjN2NDcuOGgtODEuM3YxMDEuMmgtNjAuN1Y1ODguNHoiIGZpbGw9IiNEMzgzMEQiIHAtaWQ9IjY5NTAiPjwvcGF0aD48cGF0aCBkPSJNNTcyIDQ1OUw0NDIuNiA1ODguNGg0MC43djEwMS4yaDYwLjhWNTg4LjRoODEuM3YtNDcuOGgtODEuM3YtMjUuOWg4MS4zdi00Ny44aC01Ny4zeiIgZmlsbD0iI0JGNzkwQSIgcC1pZD0iNjk1MSI+PC9wYXRoPjwvc3ZnPg==\" width=\"18\" /></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title\">我的积分</div>\r\n                                <div class=\"item-after\"><span class=\"badge\">");
	templateBuilder.Append(Utils.ObjectToStr(userModel.point));
	templateBuilder.Append("</span></div>\r\n\r\n                            </div>\r\n                        </li>\r\n                        <li class=\"item-content item-link\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-f7\"><img src=\"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNTMwMTk1NDYwMDQ5IiBjbGFzcz0iaWNvbiIgc3R5bGU9IiIgdmlld0JveD0iMCAwIDEwMjUgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9Ijg5OSIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHdpZHRoPSIyNTYuMjUiIGhlaWdodD0iMjU2Ij48ZGVmcz48c3R5bGUgdHlwZT0idGV4dC9jc3MiPjwvc3R5bGU+PC9kZWZzPjxwYXRoIGQ9Ik03MDAuOTYgNDgwLjA2NGwwLTk0LjYyNGMtMS40MDgtMTkuNDU2LTExLjEwNC0zMC4xNDQtMjkuMTItMzJsLTMxNC43NTIgMGMtMTcuNTY4IDEuMzc2LTI3LjA0IDEyLjI4OC0yOC40NDggMzIuNzA0bDAgOTIuNTQ0YzAuNDQ4IDIyLjcyIDEyLjAzMiAzNC4zMzYgMzQuNjU2IDM0Ljc4NGwzMDYuNDMyIDBjMjAuMzUyLTAuOTI4IDMwLjcyLTEyLjA2NCAzMS4yLTMzLjQwOHoiIHAtaWQ9IjkwMCIgZmlsbD0iI2ZkNTk1ZSI+PC9wYXRoPjxwYXRoIGQ9Ik0xMDIzLjUyIDQ0OS43OTJjLTAuODMyLTE5LjA0LTEuNjY0LTM4LjExMi0yLjQ5Ni01Ny4xMi0zLjg0LTI0LjE5Mi0yLjQzMi00OC44NjQtNi43Mi03Mi4xMjgtMi4wMTYtMTIuODY0LTQtMjUuNzkyLTUuOTg0LTM4LjY1Ni03LjA0LTMyLjIyNC0xMy44NTYtNjIuNzUyLTI0Ljk2LTkwLjUyOC0yMC41NzYtNTEuNTItNTIuMzItOTQuODgtOTYuNTQ0LTEyMi43NTItOTQuNzUyLTU5LjY4LTIzNS42OC02OC45OTItMzkwLjcyLTY4LjU3Ni0xNS40NTYgMC4yNTYtMzAuOTQ0IDAuNDgtNDYuNCAwLjczNi05LjQ3MiAwLjM1Mi0xOC45NDQgMC42NzItMjguNDQ4IDEuMDI0LTYuNzIgMC4zMi0xMy40NzIgMC42NC0yMC4yMjQgMC45OTItMTguMjA4IDEuNDA4LTM2LjQ0OCAyLjgxNi01NC42MjQgNC4yNTYtOS44ODggMS4xODQtMTkuODA4IDIuMzA0LTI5LjY5NiAzLjQ4OC0yMi4xNzYgNC4xMjgtNDQuMTI4IDYuNDY0LTY0Ljg2NCAxMS43MTItOTUuNjQ4IDI0LjMyLTE1MS42NDggNjAuMTkyLTE5NS44NzIgMTM2LjE2LTIxLjk4NCAzNy43MjgtMzEuMjMyIDg0LjE2LTQxLjkyIDEzMy40NzItMi4yNCAxNi42NC00LjQ4IDMzLjI0OC02LjcyIDQ5Ljg4OC0xLjU2OCAxOS43NzYtMy4xNjggMzkuNTg0LTQuNzM2IDU5LjM2LTAuMjU2IDYuNzItMC40OCAxMy40NzItMC43NjggMjAuMjI0LTAuNTc2IDE4LjIwOC0xLjE1MiAzNi40NDgtMS43MjggNTQuNjI0bDAgNTUuNjE2YzAuMzIgMTcuMTIgMC42NzIgMzQuMjcyIDEuMDI0IDUxLjM2IDAuMzg0IDExLjkwNCAwLjgzMiAyMy44MDggMS4yNDggMzUuNjggMC40OCA4LjA2NCAxLjAyNCAxNi4xMjggMS41MDQgMjQuMTkyIDMuNDU2IDIxLjY2NCAyLjYyNCA0My43NDQgNi40NjQgNjQuNjQgNS45MiAzMS45MzYgOS44MjQgNjIuODE2IDE4LjcyIDkxLjI5NiAyNC4wOTYgNzcuMzQ0IDYwLjM4NCAxMjkuMDg4IDEyNC4yNTYgMTY2LjYyNCAyOC41MTIgMTYuNzY4IDYyLjYyNCAyNy41MiA5OC41NiAzNi42NzIgMTMuMzEyIDIuNjU2IDI2LjU5MiA1LjMxMiAzOS45MDQgOCAxNi42NCAyLjI0IDMzLjI4IDQuNDggNDkuODg4IDYuNzIgMjEuMjggMS42NjQgNDIuNTkyIDMuMzI4IDYzLjg3MiA0Ljk5MiA3LjIzMiAwLjI1NiAxNC40OTYgMC40OCAyMS42OTYgMC43MzYgMTUuMzI4IDAuNDE2IDMwLjYyNCAwLjgzMiA0NS45MiAxLjI0OCA3LjY0OCAwLjA5NiAxNS4yOTYgMC4xOTIgMjIuOTQ0IDAuMjU2bDMxLjkwNCAwYzIwLjgtMC4zMiA0MS42LTAuNjQgNjIuNC0xLjAyNCA1Ljk4NC0wLjI1NiAxMi0wLjQ4IDE3Ljk1Mi0wLjczNiAxNy43OTItMS4xNTIgMzUuNjE2LTIuMzM2IDUzLjQwOC0zLjUyIDE1LjIzMi0xLjY2NCAzMC40MzItMy4zMjggNDUuNjY0LTQuOTkyIDM0LjIwOC02LjMzNiA2Ni44NDgtMTAuOTEyIDk3LjA1Ni0yMC40NDggNjUuNTM2LTIwLjY3MiAxMTQuMjA4LTUzLjcyOCAxNDkuNjk2LTEwNC4yODggMjcuMzI4LTM4Ljg4IDQxLjM3Ni04OC4yODggNTMuNDA4LTE0Mi42ODggMi41OTItMTYuODY0IDUuMTg0LTMzLjc2IDcuNzEyLTUwLjYyNCAxLjg1Ni0yMC4wOTYgMy42NDgtNDAuMjU2IDUuNTA0LTYwLjM4NCAwLjMyLTcuMjMyIDAuNjcyLTE0LjQ2NCAxLjAyNC0yMS42OTYgMC42NC0xNi40NDggMS4zMTItMzIuOTI4IDIuMDE2LTQ5LjQwOGwwLTEzLjI0OGMwLjA5Ni03LjY0OCAwLjE2LTE1LjI5NiAwLjI1Ni0yMi45NzZsMC01NC44OGMtMC4xOTItNy44MDgtMC4zNTItMTUuNjE2LTAuNTEyLTIzLjQyNHpNODE4LjE0NCA4MTEuMjMybC0xNzguODggMGMtNDAuMTkyLTMuMjY0LTYxLjY5Ni0yNS41MDQtNjQuNDgtNjYuNzg0bDAtMTc4Ljc4NC0xMTkuMjMyIDBjLTMuMjMyIDk5LjcxMi03MC4wMTYgMTg1Ljc5Mi0yMDAuMzUyIDI1OC4xMTJsLTQ3LjEzNi00My44NGMxMTcuNDA4LTY3LjcxMiAxNzcuNDcyLTEzOS4xMzYgMTgwLjI1Ni0yMTQuMzA0bC02MS42OTYgMGMtNDEuMTUyLTMuMjY0LTYzLjEwNC0yNi40MzItNjUuODg4LTY5LjZsMC0xMjUuOTJjNC4xNi00MS43NiAyNS42NjQtNjQuNzA0IDY0LjQ4LTY4Ljg2NGw1Mi43MDQgMGMtMTIuNDgtMzAuNjI0LTIzLjMyOC02MS42OTYtMzIuNTc2LTkzLjIxNmw2OC42NCAwYzkuMjQ4IDI5LjY5NiAyMC4zNTIgNjAuNzY4IDMzLjI4IDkzLjIxNmwxMzMuNzkyIDBjMTYuMTkyLTM4Ljk0NCAyNy40ODgtNzAuMDE2IDMzLjk1Mi05My4yMTZsNzAuMDQ4IDBjLTEwLjE3NiAzMi45MjgtMjEuNTA0IDY0LTMzLjk1MiA5My4yMTZsNDguNTQ0IDBjNDMuNDI0IDIuNzg0IDY2LjMzNiAyNS45ODQgNjguNjQgNjkuNmwwIDEzMS40ODhjLTMuNzEyIDM3LjU2OC0yNS42NjQgNTguNjg4LTY1Ljg1NiA2My4zMjhsLTYwLjMyIDAgMCAxNjIuMTEyYy0wLjQ4IDIxLjM0NCAxMS4wNzIgMzEuNzQ0IDM0LjY4OCAzMS4zMjhsMTU1LjMyOCAwLTEzLjg1NiA1Mi4xOTJ6IiBwLWlkPSI5MDEiIGZpbGw9IiNmZDU5NWUiPjwvcGF0aD48L3N2Zz4=\" width=\"18\" /></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title\">积分换礼</div>\r\n                                <div class=\"item-after\">敬请期待</div>\r\n                            </div>\r\n                        </li>\r\n                        <li class=\"item-content item-link\" onclick=\"location='usercenter2.aspx?action=proinfo'\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-f7\"><img src=\"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNTMwMTk1NDkwMDY5IiBjbGFzcz0iaWNvbiIgc3R5bGU9IiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjI2OTkiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMjU2IiBoZWlnaHQ9IjI1NiI+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj48L3N0eWxlPjwvZGVmcz48cGF0aCBkPSJNNzE0Ljc1MiA5NTIuMzJMNjIwLjU0NCA4ODAuNjRIMTEwLjU5MmMtNjEuNDQgMC0xMTAuNTkyLTQ5LjE1Mi0xMTAuNTkyLTExMC41OTJWMjc0LjQzMkMwIDIxMi45OTIgNDkuMTUyIDE2My44NCAxMTAuNTkyIDE2My44NGg4MDIuODE2YzYxLjQ0IDAgMTEwLjU5MiA0OS4xNTIgMTEwLjU5MiAxMTAuNTkydjQ5NS42MTZjMCA2MS40NC00OS4xNTIgMTEwLjU5Mi0xMTAuNTkyIDExMC41OTJoLTEwOC41NDR2LTYxLjQ0aDEwOC41NDRjMjYuNjI0IDAgNDkuMTUyLTIyLjUyOCA0OS4xNTItNDkuMTUyVjI3NC40MzJjMC0yNi42MjQtMjIuNTI4LTQ5LjE1Mi00OS4xNTItNDkuMTUySDExMC41OTJDODMuOTY4IDIyNS4yOCA2MS40NCAyNDcuODA4IDYxLjQ0IDI3NC40MzJ2NDk1LjYxNkM2MS40NCA3OTYuNjcyIDgzLjk2OCA4MTkuMiAxMTAuNTkyIDgxOS4yaDUzMC40MzJsMTEwLjU5MiA4My45NjgtMzYuODY0IDQ5LjE1MnoiIGZpbGw9IiMzOTg4RkYiIHAtaWQ9IjI3MDAiPjwvcGF0aD48cGF0aCBkPSJNMTYzLjg0IDI2Ni4yNGgyNjYuMjRjMzQuODE2IDAgNjEuNDQgMjYuNjI0IDYxLjQ0IDYxLjQ0djM4OS4xMmMwIDM0LjgxNi0yNi42MjQgNjEuNDQtNjEuNDQgNjEuNDRIMTYzLjg0Yy0zNC44MTYgMC02MS40NC0yNi42MjQtNjEuNDQtNjEuNDRWMzI3LjY4YzAtMzQuODE2IDI2LjYyNC02MS40NCA2MS40NC02MS40NHoiIGZpbGw9IiNEQUU5RkYiIHAtaWQ9IjI3MDEiPjwvcGF0aD48cGF0aCBkPSJNNzI3LjA0IDQ1MC41NmgtMTY1Ljg4OGMtMTYuMzg0IDAtMzAuNzItMTQuMzM2LTMwLjcyLTMwLjcyczE0LjMzNi0zMC43MiAzMC43Mi0zMC43MmgxNjUuODg4YzE2LjM4NCAwIDMwLjcyIDE0LjMzNiAzMC43MiAzMC43MnMtMTIuMjg4IDMwLjcyLTMwLjcyIDMwLjcyeiIgZmlsbD0iIzM4ODlGRiIgcC1pZD0iMjcwMiI+PC9wYXRoPjxwYXRoIGQ9Ik04NTEuOTY4IDU1Mi45Nkg1NDAuNjcyYy0xMi4yODggMC0yMC40OC04LjE5Mi0yMC40OC0yMC40OHM4LjE5Mi0yMC40OCAyMC40OC0yMC40OGgzMDkuMjQ4YzEyLjI4OCAwIDIwLjQ4IDguMTkyIDIwLjQ4IDIwLjQ4IDIuMDQ4IDEyLjI4OC04LjE5MiAyMC40OC0xOC40MzIgMjAuNDh6TTg1MS45NjggNjU1LjM2SDU0MC42NzJjLTEyLjI4OCAwLTIwLjQ4LTguMTkyLTIwLjQ4LTIwLjQ4czguMTkyLTIwLjQ4IDIwLjQ4LTIwLjQ4aDMwOS4yNDhjMTIuMjg4IDAgMjAuNDggOC4xOTIgMjAuNDggMjAuNDhzLTguMTkyIDIwLjQ4LTE4LjQzMiAyMC40OHpNMjM1LjUyIDQ3MS4wNGMtMTYuMzg0IDAtMzAuNzItMTQuMzM2LTMwLjcyLTMwLjcyczE0LjMzNi0zMC43MiAzMC43Mi0zMC43MiAzMC43MiAxNC4zMzYgMzAuNzIgMzAuNzItMTQuMzM2IDMwLjcyLTMwLjcyIDMwLjcyeiBtMTQzLjM2IDBjLTE2LjM4NCAwLTMwLjcyLTE0LjMzNi0zMC43Mi0zMC43MnMxNC4zMzYtMzAuNzIgMzAuNzItMzAuNzIgMzAuNzIgMTQuMzM2IDMwLjcyIDMwLjcyLTE0LjMzNiAzMC43Mi0zMC43MiAzMC43MnpNMjQ1Ljc2IDU1Mi45NmMwLTEyLjI4OCA4LjE5Mi0yMC40OCAyMC40OC0yMC40OHMyMC40OCA4LjE5MiAyMC40OCAyMC40OCA4LjE5MiAyMC40OCAyMC40OCAyMC40OCAyMC40OC04LjE5MiAyMC40OC0yMC40OCA4LjE5Mi0yMC40OCAyMC40OC0yMC40OCAyMC40OCA4LjE5MiAyMC40OCAyMC40OGMwIDM0LjgxNi0yNi42MjQgNjEuNDQtNjEuNDQgNjEuNDRzLTYxLjQ0LTI2LjYyNC02MS40NC02MS40NHoiIGZpbGw9IiMzOTg4RkYiIHAtaWQ9IjI3MDMiPjwvcGF0aD48L3N2Zz4=\" width=\"18\" /></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title\">修改资料</div>\r\n                            </div>\r\n                        </li>\r\n						\r\n                        <li class=\"item-content item-link\" onclick=\"addAccount()\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-f7\"><img src=\"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNTMyNTc2MzY3NjY5IiBjbGFzcz0iaWNvbiIgc3R5bGU9IiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjMxODAiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMjU2IiBoZWlnaHQ9IjI1NiI+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj48L3N0eWxlPjwvZGVmcz48cGF0aCBkPSJNNTEyIDEwMjRDMjI5LjcgMTAyNCAwIDc5NC4zIDAgNTEyUzIyOS43IDAgNTEyIDBzNTEyIDIyOS43IDUxMiA1MTItMjI5LjcgNTEyLTUxMiA1MTJ6IG0wLTkzOC43QzI3Ni43IDg1LjMgODUuMyAyNzYuNyA4NS4zIDUxMlMyNzYuNyA5MzguNyA1MTIgOTM4LjcgOTM4LjcgNzQ3LjMgOTM4LjcgNTEyIDc0Ny4zIDg1LjMgNTEyIDg1LjN6IiBmaWxsPSIjMzY4OEZGIiBwLWlkPSIzMTgxIj48L3BhdGg+PHBhdGggZD0iTTY4Mi43IDU1NC43SDM0MS4zYy0yMy42IDAtNDIuNy0xOS4xLTQyLjctNDIuN3MxOS4xLTQyLjcgNDIuNy00Mi43aDM0MS4zYzIzLjYgMCA0Mi43IDE5LjEgNDIuNyA0Mi43cy0xOS4xIDQyLjctNDIuNiA0Mi43eiIgZmlsbD0iIzVGNjM3OSIgcC1pZD0iMzE4MiI+PC9wYXRoPjxwYXRoIGQ9Ik01MTIgNzI1LjNjLTIzLjYgMC00Mi43LTE5LjEtNDIuNy00Mi43VjM0MS4zYzAtMjMuNiAxOS4xLTQyLjcgNDIuNy00Mi43czQyLjcgMTkuMSA0Mi43IDQyLjd2MzQxLjNjMCAyMy42LTE5LjEgNDIuNy00Mi43IDQyLjd6IiBmaWxsPSIjNUY2Mzc5IiBwLWlkPSIzMTgzIj48L3BhdGg+PC9zdmc+\" width=\"18\" /></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title\">添加帐户</div>\r\n                            </div>\r\n                        </li>\r\n                    </ul>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/swiper.jquery.min.js\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\">\r\n        $(function () {\r\n\r\n            var swiper = new Swiper('.swiper-container', {\r\n                loop: true,\r\n                autoplay: 5000\r\n            });\r\n        })\r\n    </");
	templateBuilder.Append("script>\r\n    ");
	}
	else if (action=="proinfo")
	{

	templateBuilder.Append("\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/common.js\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/base.js\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/Validform_v5.3.2_min.js\"></");
	templateBuilder.Append("script>\r\n    <header class=\"bar bar-nav\">\r\n        <a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n            <span class=\"icon icon-left\"></span>\r\n        </a>\r\n        <h1 class=\"title\">修改资料</h1>\r\n    </header>\r\n    <script type=\"text/javascript\">\r\n        $(document).ready(function () {\r\n            //初始化表单\r\n            AjaxInitForm('#info_form', '#btnSubmit', 1);\r\n        });\r\n    </");
	templateBuilder.Append("script>\r\n    <div class=\"content\">\r\n        <form id=\"info_form\" name=\"info_form\" url=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=user_info_edit\">\r\n            <div class=\"list-block\">\r\n                <ul>\r\n                    <!-- Text inputs -->\r\n                    <li>\r\n                        <div class=\"item-content\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-form-name\"></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title label color_black\">昵称</div>\r\n                                <div class=\"item-input\">\r\n                                    <input name=\"txtNickName\" id=\"txtNickName\" type=\"text\" value=\"");
	templateBuilder.Append(Utils.ObjectToStr(userModel.nick_name));
	templateBuilder.Append("\" maxlength=\"10\" />\r\n                                </div>\r\n                            </div>\r\n                        </div>\r\n                    </li>\r\n                    <li>\r\n                        <div class=\"item-content\">\r\n                            <div class=\"item-media\"><i class=\"icon icon-form-name\"></i></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title label color_black\">性别</div>\r\n                                <div class=\"item-input\">\r\n                                    <select name=\"rblSex\">\r\n                                        ");
	if (userModel.sex=="保密")
	{

	templateBuilder.Append("\r\n                                        <option value=\"保密\" selected=selected>保密</option>\r\n                                        ");
	}
	else
	{

	templateBuilder.Append("\r\n                                        <option value=\"保密\">保密</option>\r\n                                        ");
	}	//end for if

	if (userModel.sex=="男")
	{

	templateBuilder.Append("\r\n                                        <option value=\"男\" selected=selected>男</option>\r\n                                        ");
	}
	else
	{

	templateBuilder.Append("\r\n                                        <option value=\"男\">男</option>\r\n                                        ");
	}	//end for if

	if (userModel.sex=="女")
	{

	templateBuilder.Append("\r\n                                        <option value=\"女\" selected=selected>女</option>\r\n                                        ");
	}
	else
	{

	templateBuilder.Append("\r\n                                        <option value=\"女\">女</option>\r\n                                        ");
	}	//end for if

	templateBuilder.Append("\r\n                                    </select>\r\n                                </div>\r\n                            </div>\r\n                        </div>\r\n                    </li>\r\n                </ul>\r\n\r\n                <div class=\"content-block\">\r\n                    <input id=\"btnSubmit\" name=\"btnSubmit\" type=\"submit\" value=\"确认修改\" class=\"button button-big button-fill\" />\r\n                </div>\r\n            </div>\r\n        </form>\r\n    </div>\r\n    ");
	}	//end for if

	templateBuilder.Append("\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
