%% ��ʼ, ׼��
% �˽ű�Ϊ�������ɵ������
% ����: �׻ݿ�
% ����: 2016-03-25
% ********************************ע��*************************************
% ��Ҫ����ȡ�������е�ѭ�����ע��, ���������ɴ���������, ��ذ���ʹ��.
% *************************************************************************

clear;
clc;

%% һ������

G_example.n = 6;
G_example.s = 1;
G_example.t = 4;
G_example.req = [1];
G_example.req2 = [2];
G_example.m_dis = [200 1 200 200 200 1;
                   200 200 1 200 1 200;
                   200 200 200 1 200 200;
                   200 200 200 200 200 200;
                   200 200 200 1 200 200;
                   200 200 1 200 200 200];
G_example.m_dis2 = 200 * ones(6, 6);
G_example.tour = 1:6;
% ����matlab�������±��1��ʼ, ��**ע��**, ���浽csv��, �±��0��ʼ, ����save_result����Ҫ�����±�����.
% save_result(G_example, 'example');

% ���ɳ�С����

% file_folder = '..\data\case-mini\';
% 
% for n = 5:10
%     for reqs = 0:4
%         for reqs2 = 0:4
%             if (reqs + reqs2 > n-2)
%                 continue;
%             end
%             for dout = 2:n
%                 g = random_graph(n, reqs, reqs2, dout);
%                 save_result(g, 'mini', file_folder);
%             end
%         end
%     end
% end

% ����һЩС����

% file_folder = '..\data\case-small\';
% 
% for n = 25 : 5 : 40
%     req_end = floor((n-2)/2);
%     req_step = min(floor(req_end/2), 10);
%     for reqs = 0 : req_step : req_end
%         for reqs2 = 0 : req_step : req_end
%             for dout = 6:2:12
%                 g = random_graph(n, reqs, reqs2, dout);
%                 save_result(g, 'small', file_folder);
%             end
%         end
%     end
% end % ��������: 4*3*3*2 = 72 ��

% ����һЩ�ռ�����

file_folder = '..\data\case-dag\';

for n = 1 : 2       % �е���...
    g = dag_graph(2000, 100, 100, 20);
    save_result(g, ['ultimate_dag', num2str(n)], file_folder);
end % ��������: 5��


