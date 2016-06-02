function [ G_s ] = shuffle( G, discrete )
%SHUFFLE ��ͼG�Ľ���Ŵ���, ���discrete, �򽫶�������ɢ��1~2000
% ����: �׻ݿ�
% ����: 2016-03-25

rmap = randperm(G.n); % new -> old rmap[old] = new
rmap2(rmap) = 1:G.n;  % old -> new rmap2[new] = old

if exist('discrete', 'var')
    rmap = randperm(2000);
    rmap2(rmap) = 1:2000;
    G_s.m_dis = 100000 * ones(2000, 2000);
    G_s.m_dis2 = 100000 * ones(2000, 2000);
    G_s.m_dis(1:G.n, 1:G.n) = G.m_dis;
    G_s.m_dis2(1:G.n, 1:G.n) = G.m_dis2;
    G.m_dis = G_s.m_dis;
    G.m_dis2 = G_s.m_dis2;
    G_s.n = 2000;
else
    rmap = randperm(G.n); % new -> old rmap[old] = new
    rmap2(rmap) = 1:G.n;  % old -> new rmap2[new] = old
    G_s.n = G.n;
end

G_s.s = rmap(G.s);
G_s.t = rmap(G.t);
G_s.req = rmap(G.req);
G_s.req2 = rmap(G.req2);
G_s.m_dis = G.m_dis(rmap2, rmap2);
G_s.m_dis2 = G.m_dis2(rmap2, rmap2);
% G.tour = rmap(G.tour);

end

