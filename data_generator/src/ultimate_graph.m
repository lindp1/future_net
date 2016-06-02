function [ G ] = ultimate_graph( )
%ULTIMATE_GRAPH �����ռ���������
% ��2000����, 100+100���ؾ����, 1000*20=20000����Ч��
%
% ����: �׻ݿ�
% ����: 2016-03-26

%% ����

n = 2000;
n_v1 = 100;
n_v2 = 100;
max_dout = 20;
max_valid_weight = 100;

%% ���������ͼ(��Ч�߲���1000*20)

G = random_graph(n, n_v1, n_v2, max_dout);


%% ���ٵı߲���(�������, till all node's out degree is 8)

for i = 1 : G.n
    ei = G.m_dis(i, :);
    ei2 = G.m_dis2(i, :);
    dout = numel(ei(ei <= max_valid_weight));
    dout = dout + numel(ei2(ei2 <= max_valid_weight));
    rp = randperm(G.n);
    for j = 1 : G.n
        if (dout == max_dout)
            break;
        end
        if (i == rp(j) || G.m_dis(i, rp(j)) <= max_valid_weight)
            continue;
        end
        G.m_dis(i, rp(j)) = ceil(max_valid_weight * rand());
        dout = dout + 1;
    end
end


end

