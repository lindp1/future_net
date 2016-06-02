function [ save_flag ] = save_result( G, describle, where )
%SAVE_RESULT ��ͼG���ֵ��ļ�(topo.csv, demand.csv)
% -ͼG(�ṹ��)Ӧ�ð������¼�������:
%   ��������
%       n: ���еĽ������
%       s: ��ʼ�ڵ�
%       t: ��ֹ���
%       req: ����, ���еı��뾭�����, ������s��t
%       m_dis: �ߵ��ڽӾ����ʾ, Ԫ��ֵ����20ʱ��ʾ�ñ߲�����
%   ������������
%       req2: ����, tour2���еı��뾭�����, ������s��t
%       m_dis2: �رߵ��ڽӾ����ʾ, ��Ϊtour2��ԭ��, ������Ҫ���Ǵγ��ı�
% -describle: �������������ļ���������
% -where: ָ���ļ���������data/��λ��·��
%
% ����: �׻ݿ�
% ����: 2016-03-25


%% Preparing: �ļ�·��, �ļ����ȵ�

if (nargin < 2)
    describle = 'default';
end

if (nargin < 3)
    where = '..\data\';
end

% ��Ч�ߵ�����
num_edge = numel(G.m_dis(G.m_dis <= 100));
num_edge = num_edge + numel(G.m_dis(G.m_dis2 <= 100));

file_path = ['case', int2str(G.n)];                             % ����
file_path = [file_path, '-', int2str(numel(G.req))];            % tour1�������
file_path = [file_path, '&', int2str(numel(G.req2))];           % tour2�������
file_path = [file_path, '-e(', int2str(num_edge), ')'];         % �ߵ�����
file_path = [file_path, '-', describle];                        % ����
%file_path = [file_path, '-', datestr(now, 30)];                % ʱ��
%file_path = [file_path, '-', int2str(round(rand()*10000))];    % ����������ļ�����ͻ
topo_filename = [where, file_path, '\topo.csv'];                % topo.csv
demand_filename = [where, file_path, '\demand.csv'];            % demand.csv
%result_filename = [where, file_path, '\result_example.csv'];   % һ�����н�

% �����ļ���
mkdir(where, file_path);

save_flag = 0;

%% ���� topo.csv

edge_no = zeros(G.n, G.n);  % m_dis�����еı���topo�еı��

topo_cnt = 0;
topo = [];
for i = 1 : G.n
    for j = 1 : G.n
        if (G.m_dis(i, j) <= 100)
            topo = [topo; topo_cnt i-1 j-1 G.m_dis(i, j)];
            edge_no(i, j) = topo_cnt;
            topo_cnt = topo_cnt + 1;
        end
        if (G.m_dis2(i, j) <= 100)
            topo = [topo; topo_cnt i-1 j-1 G.m_dis2(i, j)];
            topo_cnt = topo_cnt + 1;
        end
    end
end

dlmwrite(topo_filename, topo);

% mark flag
save_flag = 1;

%% ���� demand.csv

file = fopen(demand_filename, 'wt');

% tour1
if (~isempty(G.req))
    str_req = [];
    for i = 1 : numel(G.req)-1
        str_req = [str_req int2str(G.req(i)-1) '|'];
    end
    str_req = [str_req int2str(G.req(end)-1)];
else
    str_req = 'NA';
end

str_st_req = ['1,', int2str(G.s-1) ',' int2str(G.t-1) ',' str_req];

fprintf(file, '%s\n', str_st_req);

% tour2
if (~isempty(G.req2))
    str_req = [];
    for i = 1 : numel(G.req2)-1
        str_req = [str_req int2str(G.req2(i)-1) '|'];
    end
    str_req = [str_req int2str(G.req2(end)-1)];
else
    str_req = 'NA';
end

str_st_req = ['2,', int2str(G.s-1) ',' int2str(G.t-1) ',' str_req];
fprintf(file, '%s\n', str_st_req);

% close file
fclose(file);

% mark flag
save_flag = 2;


% %% ������н�
% 
% str_tour = int2str(edge_no(G.tour(1), G.tour(2)));
% for i = 2 : G.n-1
%     str_tour = [str_tour, '|', int2str(edge_no(G.tour(i), G.tour(i+1)))];
% end
% 
% % д���ļ�
% file = fopen(result_filename, 'wt');
% fprintf(file, '%s\n%s\n', str_tour, str_tour);
% fclose(file);
% 
% % mark flag
% save_flag = 3;


%% print

fprintf('save graph to folder "%s" successfully.\n', file_path);

end

