function isSame = isSameFile(path1, path2)
    % 创建Java文件对象
    file1 = java.io.File(path1);
    file2 = java.io.File(path2);

    try
        % 获取规范化绝对路径
        canonPath1 = char(file1.getCanonicalPath());
        canonPath2 = char(file2.getCanonicalPath());
    catch
        % 文件不存在时返回false
        isSame = false;
        return;
    end

    % 处理操作系统差异
    if ispc
        % Windows系统转为小写
        canonPath1 = lower(canonPath1);
        canonPath2 = lower(canonPath2);
    end

    % 统一替换路径分隔符
    canonPath1 = strrep(canonPath1, '/', filesep);
    canonPath2 = strrep(canonPath2, '/', filesep);

    isSame = strcmp(canonPath1, canonPath2);
end