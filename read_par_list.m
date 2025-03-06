filename = 'partest.txt';
text = fileread(filename);
lines = strsplit(text, '\n');
outputtype = 2;

% 预分配存储空间
var_names = {};
expressions = {};
comments = {};

% 正则表达式模式（匹配 变量名="表达式" "注释" 结构）
pattern = '^(\w+)="([^"]*)"\s*"([^"]*)"$';

% 遍历每一行进行解析
for i = 1:numel(lines)
    line = strtrim(lines{i});

    % 跳过空行
    if isempty(line)
        continue;
    end

    % 使用正则表达式匹配
    tokens = regexp(line, pattern, 'tokens', 'once');

    if ~isempty(tokens)
        var_names{end+1} = tokens{1};
        expressions{end+1} = tokens{2};
        comments{end+1} = tokens{3};
    else
        fprintf('无法解析行 %d: %s\n', i, line);
    end
end

for i = 1:length(var_names)
    varname = var_names{i};
    expr = expressions{i};
    if outputtype == 1
        fprintf("func_register_par(mws,'%s','%s');\n",varname,expr);
    else
        fprintf("par_list('%s')='%s';\n",varname,expr);
    end
end