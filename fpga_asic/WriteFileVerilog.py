"""
The outcome will be
    data_in[`BYTE*1-1:`BYTE*0]	    =	 0;
    data_in[`BYTE*2-1:`BYTE*1]      =    1;
    data_in[`BYTE*3-1:`BYTE*2]      =    2;
    data_in[`BYTE*4-1:`BYTE*3]      =    3;
    data_in[`BYTE*5-1:`BYTE*4]      =    4;
    ...
"""

f = open('test.txt', 'w')

for i in range(64):
    content = str("data_in[`BYTE*")+str(i+1)+str("-1:`BYTE*")+str(i)+str("]\t=\t")+str(i)+str(';')
    f.write(content)
    f.write('\n')
    
f.close()
