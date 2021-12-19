// 算法思路：用一个数组来记录链表的data是否为首次出现，由于|data|小于等于n，所以数组的长度为n+1，初始值赋为0，若出现，则对应的值赋为1，以此来判断是否为首次出现，并决定是否对链表进行删减。
// 输入为头节点head，|data|最大值n

//链表结构体定义
typedef struct node
{
    int data;
    struct node *link;
} NODE;

void delete(NODE *head, int n)
{
    NODE *p = head->link;

    // 创建并初始化用于记录是否首次出现的临时数组q
    int *q;
    q = (int *)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i < n + 1; i++)
    {
        *(q + i) = 0;
    }

    // 判断与删除
    while (p!= NULL)
    {
        //将数据data转换为绝对值
        int temp;
        if (p->data > 0)
        {
            temp = p->data;
        }
        else
        {
            temp = -p->data;
        }
        //判断data是否已出现
        if (*(q + temp) == 0) //首次出现
        {
            *(q + temp) = 1;
            p = p->link;
        }
        else //不是首次出现
        {
            NODE *t = p->link;
            p->link = t->link;
            free(t);
        }
    }
    free(q);
}
