# input:
# weights file: *npy (PATH: ../lenet/weights/)
# base module: 
#               + 2d convolution module (inter)
#               + float 32 adder
#
# gen conv2d => module featuremap0 (python gen)
import json
from jinja2 import Template
import torch



def get_template_sample(file_name):
    with open(file_name, 'r', encoding='UTF-8') as file:
        return file.read()

def save_report(content, file_name):
    with open(file_name, 'w', encoding='UTF-8') as file:
        file.write(content)
    

def build_report():
    # input_data = json.loads(get_input_sample())
    # read data from *.npy
    # w0,w1,w2,w3 ..
    # 
    w0 = "8'hbd3e76c9"
    bias = "8'h3ddb8bac"
    verilog_template = get_template_sample("./featuremap_template.v")
    jinja2_template = Template(verilog_template)
    contents = jinja2_template.render(w0=w0, bias=bias)
    save_report(contents,"fm0.v")
    print("create  success!")





# def generare_verilog_module (weight_path,output_path):
#     weights = torch.load(weight_path)
#     weights = weights.cpu().numpy() # [(6, 3, 5, 5)], 16 kernel
#     for 6 output:
#         # create module feature map
#         # (3 conv + add )
#         for 3 kernel:
#             create 1 conv

if __name__ == "__main__":
    build_report();

