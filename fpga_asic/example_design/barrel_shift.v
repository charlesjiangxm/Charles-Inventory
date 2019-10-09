// circular shift x left by n bit, the most straight forward way
// 将x左端的n位先移动到y的低n位中
// 将x左移n位，其右面低位补0
// 进行按位或运算
(x >> (32 - n) | (x << n));