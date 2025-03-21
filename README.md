# Travelling-Wave-Structure

本项目提供了一种对于anisotropic periodic structure的Matlab与CST联合仿真方法。

测试版本：CST Studio Suite 2024、Matlab R2023b

## 项目介绍

在slow wave structure（如Leaky-Wave Antenna、SSPP等）周期性结构的设计中，为满足辐射要求或应对阻抗不匹配，通常需要结构随位置z发生改变。然而，在CST仿真中，如需增加/减少线性/非线性辐射单元的数量，则需要对其一侧的所有结构都进行人工处理，带来了极大的不便。

因而，本项目提供了一种工具，通过用户自定义生成规则，在不同位置上生成不同长度的单元结构。如需对某一参数（尤其是阵元个数）进行扫描，只需额外编写/人工生成扫描对应参数的脚本，即可生成对应结构的工程文件，方便研究者进行分析。

为满足不善于使用Matlab-CST联合仿真的研究者，本项目额外提供了将History Tree转化为Matlab代码的小工具，也将进行描述。

## 使用方法

本项目共包含如下文件：

- create_grating.m（主程序，需要修改入口参数）
- multirecordToMatlab.m（将History Tree转化为Matlab代码）
- func_create_sCommand.m（工具辅助函数，生成VBA句柄）
- func_cstHistoryToMatlab.m（工具辅助函数，通过History产生Matlab代码）
- func_generate_grating.m（工具辅助函数，记录单元结构信息）
- func_register_par.m（工具辅助函数，用于注册Parameter List）

另外，CST复制导出的History Tree以及使用multirecordToMatlab生成的建模代码也需要放在本文件夹下。在示例中，分别为：

- csthistorylist.txt
- sample_rectstrip_generation.m

### 前期准备：利用CST History Tree产生结构生成代码

![image](https://github.com/user-attachments/assets/deda590d-fa78-418c-827f-834b893065ec)

对于该结构而言，在CST的History List中，能够看到是由定义方块：strip、slot以及boolean操作三部分组成。将这三部分的代码都复制到csthistoryllist.txt中，**操作之间用若干行空行分离**。

进入`multirecordToMatlab.m`，修改变量`flname`为该文件名（csthistoryllist.txt），根据操作数量定义`historynames`为字符串数组。

新建一个空白的matlab**函数**，该函数不含输出变量，但包含**唯一的四个输入变量**：`idx`,`idy`,`compname`,`mws`。其中，`idx`表示需要生成的结构为x方向上的第`idx`个，`idy`表示需要生成的结构为y方向上的第`y`个，`compname`表示该结构应当所处的Component名，`mws`为该CST项目。

下一步，在调用之前使用`func_register_par`进行变量注册。变量不需要重复注册，类型可以为字符串（表达式）或常数。**但需要注意的是，无论是CST变量（即以字符串的形式存在）还是matlab变量，都需要在调用之前进行注册（包括表达式间的调用），否则将会报错！**

之后，根据需要将所有生成代码（即包含“func_create_sCommand”调用的可变参数）调整为你所需的规则。你也可以将History Tree中的记录名与个数相对应。这部分的代码可以参照`sample_rectstrip_generation.m`。这里所用到的所有变量都应是已在上一步中注册过的。

你也可以加入更多的判断逻辑，从而在不同位置上生成不同的结构，并进行更复杂的操作。

这样，就得到了完整的对第`i`个单元进行结构生成的代码了。

### 前期准备：提取CST Parameter List

![image](https://github.com/user-attachments/assets/0868ea7c-49cd-4e60-b0c4-27e2ab851f65)

在CST中，右键Parameter List，选择“Save Parameters to File”，将变量表导出到相同文件夹内"partest.txt"中。打开`read_par_list.m`，将首行文件名修改为你的保存文件名（以"partest.txt"）为例。执行脚本，即可将变量表转存为包含“func_register_par”的MATLAB语句。

### 结构生成

进入`create_grating.m`，首先进行参数设置。这些参数通常是已知并需要广泛使用的，如用于基板尺寸定义的`lx`、`ly`、`tp`等。如果你的单元结构尺寸与总数量有关，还需要先在此定义总数量（如`nr_strip`）。

在完成变量定义后，需要调用`func_generate_grating`进行周期结构生成。该函数的第一个参数为周期方向（可选x、y、xy）；第二个参数为单元在目标方向上的总个数（对于xy，如定义了nr_strip，则总个数为nr_strip\*nr_strip个）；第三个参数为结构生成函数的函数名（如例程中为sample_rectstrip_generation）。

你也可以生成多个周期结构，这些周期结构的生成将会依次执行。（即`func_generate_grating`函数可以多次调用）

之后，需要对所有你所用到的材料进行材料定义。材料参数请直接从CST中进行复制，利用`multirecordToMatlab.m`生成对应的定义代码。

完成以上所有工作后，就可以运行`create_grating.m`，将会得到所需的结构。

**需要注意的是，所有CST变量都需要在调用之前进行注册！可以通过在变量名后加“!”，并调用`func_register_par`对已注册的变量值进行修改（示例中已给出）。**

### 仿真与分析

本脚本暂不支持自动化生成端口并运行，也无法向你返回你所需要的mws。
