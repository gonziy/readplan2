using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTcms.Model
{
    public class UserReadBook
    {
        public int? id { get; set; }
        public int? category_id { get; set; }
        public int? user_id { get; set; }
        public int? count { get; set; }
    }
}
