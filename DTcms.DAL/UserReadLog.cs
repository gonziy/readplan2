using System;
using System.Data;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;
using System.Linq;
using DTcms.Model;

namespace DTcms.DAL
{
    public partial class UserReadLog
    {
        private string databaseprefix; //数据库表名前缀
        public UserReadLog(string _databaseprefix)
        {
            databaseprefix = _databaseprefix;
        }

        public int Add(Model.UserReadLog model)
        {
            int id = 0;
            return DbHelperSQL.Insert(databaseprefix + "user_read_log", model, out id);
        }
        public int Update(Model.UserReadLog model,string where)
        {
            return DbHelperSQL.Update<Model.UserReadLog>(databaseprefix + "user_read_log", model, "id", where);
        }
        public Model.UserReadLog Get(string where)
        {
            return DbHelperSQL.Entity<Model.UserReadLog>("select * from " + databaseprefix + "user_read_log where id > '0' " + (string.IsNullOrEmpty(where) ? "" : " and " + where));
        }
        public List<Model.UserReadLog> List(string where)
        {
            return DbHelperSQL.ListEntity<Model.UserReadLog>("select * from " + databaseprefix + "user_read_log where id > '0' " + (string.IsNullOrEmpty(where) ? "" :" and " + where));
        }

        public int Count(string where)
        {
            return TypeConverter.ObjectToInt(DbHelperSQL.GetSingle("select count(1) from " + databaseprefix + "user_read_log where id > '0' " + (string.IsNullOrEmpty(where) ? "" : " and " + where)), 0);
        }
        public List<Model.UserReadLog> List(int pageSize, int pageIndex, string where, string filedOrder, out int recordCount)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from " + databaseprefix + "user_read_log");
            if (where.Trim() != "")
            {
                strSql.Append(" where " + where);
            }
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.ListEntity<Model.UserReadLog>(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }
        public int UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update " + databaseprefix + "user_read_log set " + strValue);
            strSql.Append(" where id=" + id);
            return DbHelperSQL.ExecuteSql(strSql.ToString());
        }

        public List<ArticleCategory> ReadCategory(int user_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select DISTINCT category_id from dt_user_read_log where user_id = '" + user_id + "' and compose_count<read_count");
            return DbHelperSQL.ListEntity<ArticleCategory>(strSql.ToString());
        }
        public int CategoryComposeCount(int user_id,int category_id)
        {
            if (user_id < 1)
            {
                return 0;
            }
            if (category_id < 1)
            {
                return 0;
            }
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select article_id, sum(read_count-compose_count) as count from dt_user_read_log where category_id = '" + category_id + "' and user_id = '" + user_id + "' group by article_id");
            List<Model.ReadArticleList> ReadLogList = DbHelperSQL.ListEntity<Model.ReadArticleList>(strSql.ToString());
            List<Model.article> articles = DbHelperSQL.ListEntity<Model.article>("select * from dt_article where category_id = '" + category_id + "'");
            if (ReadLogList.Count == articles.Count)
            {
               return ReadLogList.Min(x => x.count);
            }
            else
            {
                return 0;
            }

        }
        public int ArticleCompose(int user_id, int article_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from dt_user_read_log where article_id = '" + article_id + "' and user_id = '" + user_id + "' and compose_count < read_count");
            Model.UserReadLog log = DbHelperSQL.Entity<Model.UserReadLog>(strSql.ToString());

            string sql = "update dt_user_read_log set [compose_count] = [compose_count] +1 where article_id = '" + article_id + "' and user_id = '" + user_id + "' and id='" + log.id + "'";
            return DbHelperSQL.ExecuteSql(sql);
        }

    }
}