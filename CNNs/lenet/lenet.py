'''LeNet in PyTorch.'''
import torch
import torch.nn as nn
import torch.nn.functional as F
# import torch.backends.cudnn as cudnn

class LeNet(nn.Module):
    def __init__(self, weight_path):
        super(LeNet, self).__init__()
        self.conv1 = nn.Conv2d(3, 6, 5)
        self.conv2 = nn.Conv2d(6, 16, 5)
        self.fc1   = nn.Linear(16*5*5, 120)
        self.fc2   = nn.Linear(120, 84)
        self.fc3   = nn.Linear(84, 10)
        self.weight_path = weight_path
        self.device = 'cuda' if torch.cuda.is_available() else 'cpu'

    # def init_weights(self):
    #     self.to(self.device)
    #     if self.device == 'cuda':
    #         self = torch.nn.DataParallel(self)
    #         cudnn.benchmark = True
    #     # checkpoint = torch.load(self.weight_path + 'lenet.pth')
    #     # self.load_state_dict(checkpoint['net'])

    def forward(self, x):
        out = F.relu(self.conv1(x))
        out = F.max_pool2d(out, 2)
        out = F.relu(self.conv2(out))
        out = F.max_pool2d(out, 2)
        out = out.view(out.size(0), -1)
        out = F.relu(self.fc1(out))
        out = F.relu(self.fc2(out))
        out = self.fc3(out)
        return out

    def export_weights(self):
        # if self.device == 'cuda':
        torch.save(self.conv1.weight.data,self.weight_path + "conv1.weights.npy")
        torch.save(self.conv2.weight.data,self.weight_path + "conv2.weights.npy")