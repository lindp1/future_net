function [ flag ] = graph_validate( G )
%GRAPH_VALIDATE ���ͼ�Ƿ�Ϸ������Ƿ��������
%
% ���ߣ��׻ݿ�
% ���ڣ�2016-03-27
%
% ע�⣺����G�Ľṹ�����Խ��м�飬��Ĭ��G�ṹ����n, s, t, req, m_dis�ȳ�Ա
% ������Ŀ�У�
% 1. û���Ի�
% 2. ���� <= 8

flag = 0;

%% ����Ի�

dis_self = diag(G.m_dis);
if (numel(dis_self(dis_self <= 100)) > 0)
    flag = flag + 1;
end

%% ������

for i = 1 : G.n
    dis_out = G.m_dis(i, :);
    degree_out = numel(dis_out(dis_out <= 20));
    if (degree_out > 20)
        flag = flag + 2;
        break;
    end
end

end

