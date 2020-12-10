import onnx
from onnx import shape_inference

path = "../../DNNModel/cifar10_torch.onnx"
onnx.save(onnx.shape_inference.infer_shapes(onnx.load(path)), path)
