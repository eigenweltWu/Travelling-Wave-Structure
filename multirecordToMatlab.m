clear;
flname = "csthistorylist.txt";
historynames = ["define brick: grating1:cut1",...
    "define brick: grating1:strip1",...
    "boolean subtract shapes:grating1:strip1, grating1:cut1"
    ];

%%%----------------------------------------------
lines = {};                        % 初始化cell数组
fid = fopen(flname, 'r');
while ~feof(fid)                   % 循环至文件末尾
     lines{end+1} = fgetl(fid);     % 逐行读取
end
fclose(fid);
beginptr = 1;
endptr = 1;
nameptr = 1;
while endptr<=length(lines)
    while endptr<=length(lines) && ~isempty(strtrim(lines{endptr}))
        endptr = endptr + 1;
    end
    if endptr > beginptr
        if nameptr <= length(historynames)
            presentname = historynames(nameptr);
        else
            presentname = "Unknown";
        end
        matlabcode = func_cstHistoryToMatlab(strjoin(lines(beginptr:endptr-1),'\n'),presentname);
        %dispstr = sprintf("[%d %d]:%s",beginptr,endptr-1,presentname);
        %disp(dispstr);
        disp("sCommand = '';");
        disp(matlabcode);
        nameptr = nameptr + 1;
    end
    beginptr = endptr+1;
    endptr = endptr+1;
end
