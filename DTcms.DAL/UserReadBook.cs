using System;
using System.Data;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;

namespace DTcms.DAL
{
    public partial class UserReadBook
    {
        private string databaseprefix; //数据库表名前缀
        public UserReadBook(string _databaseprefix)
        {
            databaseprefix = _databaseprefix;
        }

        public int Add(Model.UserReadBook model)
        {
            int id = 0;
            return DbHelperSQL.Insert(databaseprefix + "user_read_book", model, out id);
        }
        public int Update(Model.UserReadBook model,string where)
        {
            return DbHelperSQL.Update<Model.UserReadBook>(databaseprefix + "user_read_book", model, "id", where);
        }
        public Model.UserReadBook Get(string where)
        {
            return DbHelperSQL.Entity<Model.UserReadBook>("select * from " + databaseprefix + "user_read_book where id > '0' " + (string.IsNullOrEmpty(where) ? "" : " and " + where));
        }

        public List<Model.UserReadBook> List(string where)
        {
            return DbHelperSQL.ListEntity<Model.UserReadBook>("select * from " + databaseprefix + "user_read_book where id > '0' " + (string.IsNullOrEmpty(where) ? "" : " and " + where));
        }
        public int UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update " + databaseprefix + "user_read_book set " + strValue);
            strSql.Append(" where id=" + id);
            return DbHelperSQL.ExecuteSql(strSql.ToString());
        }

    }
}