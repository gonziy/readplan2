using DTcms.Common;
using DTcms.Model;
using Senparc.Weixin.MP.AdvancedAPIs;
using Senparc.Weixin.MP.AdvancedAPIs.TemplateMessage;
using Senparc.Weixin.MP.Containers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.BLL
{
    public class weixin_template_msg
    {

        string appId = "wx8d4e7949440b3187";
        string appSecret = "ff40ff5ebf56bd815c5842ec43fc1d06";

        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //获得站点配置信息
        private BLL.users userBLL = new BLL.users();



        //OPENTM207622205

        /// <summary>
        /// 推送提醒
        /// </summary>
        /// <param name="openid"></param>
        /// <param name="title">系统检测到您昨日未读经</param>
        /// <param name="content">您昨日未读书，请您及时补读</param>
        /// <param name="time">昨日</param>
        /// <param name="msg">点击打开账户，补读未读经</param>
        /// <param name="link">http://www.yuedujing.com/wx_login.aspx</param>
        /// <returns></returns>
        public bool SendRemind(string openid, string title, string content, string time, string msg, string link)
        {
            try
            {
                string templateId = "R-Ply-04h1bSfrtOcGZtetWcblblPAlgW9JmpBaFfeM";

                if (!AccessTokenContainer.CheckRegistered(appId))    //检查是否已经注册    
                {
                    AccessTokenContainer.Register(appId, appSecret);    //如果没有注册则进行注册    
                }
                string access_token = AccessTokenContainer.GetAccessTokenResult(appId).access_token; //AccessToken  
                string link_url = link;
                var data = new TemplateMsg()
                {
                    first = new TemplateDataItem(title, "#000000"),
                    keyword1 = new TemplateDataItem(content, "#000000"),
                    keyword2 = new TemplateDataItem(time, "#000000"),
                    remark = new TemplateDataItem(msg, "#0077ff")
                };

                //发送成功  
                if (Send(openid, templateId, link_url, data))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch(Exception ex)
            {
                LogHelper.WriteDebugLog("[wx push msg]:" + ex.Message + "," + ex.Source);
                return false;
            }
        }


        /// <summary>
        /// 发送信息
        /// </summary>
        public bool Send(string open_id, string template_id, string link_url, object data)
        {
            try
            {
                if (!AccessTokenContainer.CheckRegistered(appId))    //检查是否已经注册    
                {
                    AccessTokenContainer.Register(appId, appSecret);    //如果没有注册则进行注册    
                }
                string access_token = AccessTokenContainer.GetAccessTokenResult(appId).access_token; //AccessToken  
                SendTemplateMessageResult sendResult = TemplateApi.SendTemplateMessage(access_token, open_id, template_id, link_url, data);
                //发送成功  
                if (sendResult.errcode.ToString() == "请求成功")
                {
                    LogHelper.WriteDebugLog("[wx push msg]:" + open_id + " send success");
                    return true;
                }
                else
                {
                    LogHelper.WriteDebugLog("[wx push msg]:" + open_id + " send failed");
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteDebugLog("[wx push msg]:" + ex.Message);
                return false;
            }
        }
    }
}
