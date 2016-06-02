function [ g ] = combine_graph( g1, g2, extra_edge)
%COMBING_GRAPH ������ͼ�ϲ�����

% �����: ����ģ, ���, �յ�
g.n = g1.n + g2.n;
g.s = g1.s;
g.t = g2.t + g1.n;

% ����·�ı����
g.req = [g1.req, g2.req + g1.n];
g.req2 = [g1.req2, g2.req2 + g1.n];
if (numel(g.req) > 100)
    rp = randperm(numel(g.req), 100);
    g.req = g.req(rp);
end
if (numel(g.req2) > 100)
    rp = randperm(numel(g.req2), 100);
    g.req2 = g.req2(rp);
end

% �������1
g.m_dis = ones(g.n, g.n) * 10000;
g.m_dis(1:g1.n, 1:g1.n) = g1.m_dis;
g.m_dis(g1.n+1:end, g1.n+1:end) = g2.m_dis;
g.m_dis(g1.t, g2.s + g1.n) = 1; %ceil(100 * rand()); % ���ӵ�һ��ͼ���յ�͵ڶ���ͼ�����

% �������2
g.m_dis2 = ones(g.n, g.n) * 10000;
g.m_dis2(1:g1.n, 1:g1.n) = g1.m_dis2;
g.m_dis2(g1.n+1:end, g1.n+1:end) = g2.m_dis2;
g.m_dis2(g1.t, g2.s + g1.n) = 100; %ceil(100 * rand()); % ���ӵ�һ��ͼ���յ�͵ڶ���ͼ�����(�����β��ܱ�֤�н���)

% ��Ӷ���ı�(��g1�еĽ��ָ��g2�еĽ��)
if exist('extra_edge', 'var')
    for i = 1 : g1.n
        ei = g1.m_dis(i, :);
        ei2 = g1.m_dis2(i, :);
        dout = numel(ei(ei <= 100));
        dout = dout + numel(ei2(ei2 <= 100));
        rp = randperm(g2.n);
        for j = rp
            if (dout == 100)
                break;
            end
            if (i == j || g.m_dis(i, j + g1.n) <= 100)
                continue;
            end
            g.m_dis(i, g1.n + j) = ceil(100 * rand());
            dout = dout + 1;
        end
    end
end


% ���´��ұ��
% shuffle(g);

end

