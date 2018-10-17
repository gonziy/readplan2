using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    public partial class UserPay
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //获得站点配置信息
        private readonly DAL.UserPay dal;
        public UserPay()
        {
            dal = new DAL.UserPay(siteConfig.sysdatabaseprefix);
        }
        public int Add(Model.UserPay model)
        {
            return dal.Add(model);
        }
        public int Update(Model.UserPay model, string where)
        {
            return dal.Update(model, where);
        }
        public Model.UserPay Get(string where)
        {
            return dal.Get(where);
        }
        public int UpdateField(int id, string strValue)
        {
            return dal.UpdateField(id, strValue);
        }

    }
}