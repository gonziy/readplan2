using System;
using System.Collections.Generic;
using System.Text;
using System.Collections.ObjectModel;
using System.Runtime.Serialization;

namespace DTcms.Common.Generic
{
    [Serializable]
    public class iList<T> : System.Collections.Generic.List<T>, IiTeamCollection<T>
    {
        #region 构造函数
        public iList()
            : base()
        { }

        public iList(IEnumerable<T> collection)
            : base(collection)
        { }

        public iList(int capacity)
            : base(capacity)
        { }
        #endregion

        public iList<T> Take(int count)
        {
            return this.GetRange(0, count < 0 ? 0 : count);
        }

        public iList<T> FindAll(Predicate<T> match)
        {
            iList<T> list = new iList<T>();
            list.AddRange(base.FindAll(match));
            return list;
        }

        public new iList<T> GetRange(int start, int count)
        {
            iList<T> list = new iList<T>();
            //对传入起始位置和长度进行规则校验
            if (start < this.Count && (start + count) <= this.Count)
            {
                list.AddRange(base.GetRange(start, count));
            }
            return list;
        }

        public object SyncRoot
        {
            get
            {
                return this;
            }
        }

        /// <summary>
        /// 是否为空
        /// </summary>
        public bool IsEmpty
        {
            get
            {
                return this.Count == 0;
            }
        }

        private int _fixedsize = default(int);
        /// <summary>
        /// 固定大小属性
        /// </summary>
        public int FixedSize
        {
            get
            {
                return _fixedsize;
            }
            set
            {
                _fixedsize = value;
            }
        }

        /// <summary>
        /// 是否已满
        /// </summary>
        public bool IsFull
        {
            get
            {
                if ((FixedSize != default(int)) && (this.Count >= FixedSize))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// 版本
        /// </summary>
        public string Version
        {
            get
            {
                return "1.0";
            }
        }

        /// <summary>
        /// 作者
        /// </summary>
        public string Author
        {
            get
            {
                return "iTeam";
            }
        }

        public bool IsReadOnly
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 追加元素
        /// </summary>
        /// <param name="value"></param>
        public new void Add(T value)
        {
            if (!this.IsFull)
            {
                base.Add(value);
            }
        }

        /// <summary>
        /// 接受指定的访问方式(访问者模式)
        /// </summary>
        /// <param name="visitor"></param>
        public void Accept(IiTeamVisitor<T> visitor)
        {
            if (visitor == null)
            {
                throw new ArgumentNullException("访问器为空");
            }

            //for (int i = 0; i < this.Count; i++)
            //{
            //    visitor.Visit(this[i]);

            //    if (visitor.HasCompleted)
            //    {
            //        break;
            //    }
            //}

            System.Collections.Generic.List<T>.Enumerator enumerator = this.GetEnumerator();

            while (enumerator.MoveNext())
            {
                visitor.Visit(enumerator.Current);

                if (visitor.HasDone)
                {
                    return;
                }
            }
        }

        /// <summary>
        /// 比较对象
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public int CompareTo(object obj)
        {
            if (obj == null)
            {
                throw new ArgumentNullException("obj");
            }

            if (obj.GetType() == this.GetType())
            {
                iList<T> l = obj as iList<T>;

                return this.Count.CompareTo(l.Count);
            }
            else
            {
                return this.GetType().FullName.CompareTo(obj.GetType().FullName);
            }
        }
    }
}
