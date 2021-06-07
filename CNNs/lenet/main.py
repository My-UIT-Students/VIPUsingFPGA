import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
import torch.backends.cudnn as cudnn
from lenet import *
WEIGHT_PATH = './weights/'
device = 'cuda' if torch.cuda.is_available() else 'cpu'

net = LeNet(WEIGHT_PATH)

if device == 'cuda':
    net = torch.nn.DataParallel(net)
    cudnn.benchmark = True

net = net.to(device)
checkpoint = torch.load(WEIGHT_PATH + 'lenet.pth',map_location=device)
net.load_state_dict(checkpoint['net'])
# print(net.eval())
# net.load_state_dic()
data = torch.randn([1,3,32,32],dtype=torch.float32)
data = data.to(device)
net.module.export_weights()
out = net.module.conv1(data)

print(out)