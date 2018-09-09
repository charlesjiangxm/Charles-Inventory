Pytorch notes
===
These are some notes about using the pytorch.  


1. __Detach__  
如果我们有两个网络 A,B, 两个关系是这样的 y=A(x),z=B(y) 现在我们想用 z.backward() 来为 B 网络的参数来求梯度，
但是又不想求 A 网络参数的梯度。我们可以这样
```python
# the first method
y = A(x)
z = B(y.detach())
z.backward()

# the second method: y has been eternally detached
y = A(x)
y.detach_()
z = B(y)
z.backward()
```


2. __asdf__  
