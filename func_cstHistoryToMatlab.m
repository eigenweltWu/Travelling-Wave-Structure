function matlabCode = func_cstHistoryToMatlab(vbaCode, historyTitle)
    % 分割VBA代码为行
    lines = strsplit(vbaCode, '\n');
    matlabLines = {};

    if length(lines) > 1
        % 处理With语句
        withLine = strtrim(lines{1});
        matlabLines{end+1} = sprintf('sCommand = ''%s'';', withLine);

        for i = 2:length(lines)
            line = strtrim(lines{i});
            if isempty(line), continue; end

            % 处理End With
            if strcmp(line, 'End With')
                matlabLines{end+1} = 'sCommand = func_create_sCommand(sCommand, ''End With'');';
                continue;
            end

            % 解析命令和参数（With块内的命令）
            tokens = regexp(line, '^\.(\w+)\s*(.*)$', 'tokens');
            if isempty(tokens), continue; end
            cmd = tokens{1}{1};
            argsStr = tokens{1}{2};

            % 提取参数（处理含空格的参数）
            args = {};
            if ~isempty(argsStr)
                pattern = '"([^"]*)"';  % 匹配双引号内的完整内容
                matches = regexp(argsStr, pattern, 'tokens');
                for m = matches
                    args{end+1} = m{1}{1};
                end
            end

            % 构建格式字符串
            prefix = ['.' cmd];
            if isempty(args)
                formatStr = prefix;
            else
                paramPlaceholders = repmat({'%s'}, 1, numel(args));
                paramStr = strjoin(paramPlaceholders, '", "');
                formatStr = sprintf('%s "%s"', prefix, paramStr);
            end

            % 生成MATLAB代码
            if isempty(args)
                matlabLine = sprintf('sCommand = func_create_sCommand(sCommand, ''%s'');', formatStr);
            else
                quotedArgs = cellfun(@(x) ['''' x ''''], args, 'UniformOutput', false);
                argVars = strjoin(quotedArgs, ', ');
                matlabLine = sprintf('sCommand = func_create_sCommand(sCommand, ''%s'', %s);', formatStr, argVars);
            end
            matlabLines{end+1} = matlabLine;
        end
    else
        % 处理单行命令
        line = strtrim(lines{1});

        % 解析命令和参数（完整命令）
        tokens = regexp(line, '^(\S+)\s+(.*)$', 'tokens');
        if isempty(tokens)
            % 没有参数的命令
            cmd = line;
            argsStr = '';
        else
            cmd = tokens{1}{1};
            argsStr = tokens{1}{2};
        end

        % 提取参数（处理含空格的参数）
        args = {};
        if ~isempty(argsStr)
            pattern = '"([^"]*)"';  % 匹配双引号内的完整内容
            matches = regexp(argsStr, pattern, 'tokens');
            for m = matches
                args{end+1} = m{1}{1};
            end
        end

        % 构建格式字符串
        prefix = cmd;
        if isempty(args)
            formatStr = prefix;
        else
            paramPlaceholders = repmat({'%s'}, 1, numel(args));
            paramStr = strjoin(paramPlaceholders, '", "');
            formatStr = sprintf('%s "%s"', prefix, paramStr);
        end

        % 生成MATLAB代码
        if isempty(args)
            matlabLine = sprintf('sCommand = func_create_sCommand(sCommand, ''%s'');', formatStr);
        else
            quotedArgs = cellfun(@(x) ['''' x ''''], args, 'UniformOutput', false);
            argVars = strjoin(quotedArgs, ', ');
            matlabLine = sprintf('sCommand = func_create_sCommand(sCommand, ''%s'', %s);', formatStr, argVars);
        end
        matlabLines{end+1} = matlabLine;
    end

    % 添加invoke语句
    invokeLine = sprintf('invoke(mws, ''AddToHistory'', ''%s'', sCommand);', historyTitle);
    matlabLines{end+1} = invokeLine;

    % 合并所有行
    matlabCode = strjoin(matlabLines, '\n');
end