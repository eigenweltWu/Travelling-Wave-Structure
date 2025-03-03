function sCommand = func_create_sCommand(originalCommand, handler, varargin)
    unk_num = sum(sum(handler=='%'));
    if nargin-2 ~= unk_num
        disp('Warning: Incorrect input numbers.');
    end
    sCommand = sprintf(handler, varargin{:});
    sCommand = [char(originalCommand) 10 char(sCommand)];
end