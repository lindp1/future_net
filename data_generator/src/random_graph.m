function [ G ] = random_graph( n, reqs, reqs2, dout)
%RANDOM_GRAPH ����һ��n���ڵ�, reqs���ؾ��ڵ�, dout��ƽ�����ȵ�һ��ͼ
% ���ű����ɵ����ͼ��֤�н�; ��Ϊ�������ڽӾ�����, ����Ҳû���ر�
%
% *******��������********
% reqs2: tour2�ı�������
% m_dis2: �رߵĵڶ���
% tour: һ����s��t��tour(�����), ��tour����tour1�Ŀ��н�, Ҳ��tour2�Ŀ��н�
%
% ����: �׻ݿ�
% ����: 2016-03-25
%
% �����¼: ��һ�����ʻ������Ի�, ����ֻ���򵥵�ȥ���Ի�����, ��������ʹ����Ч��������

%% ��ʼ����׼��

if (reqs + reqs2 > n - 2)
    disp('|v*| + |v**| > n-2...');
    exit;
end

max_weight = 10000;
max_dout = 20;

m = n * dout;

G.n = n;
G.s = 1;
G.t = 2;

rp = randperm(reqs + reqs2);
G.req = 2 + rp(1:reqs);
G.req2 = 2 + rp(reqs+1:end);

G.m_dis = max_weight * ones(n, n);
G.m_dis2 = max_weight * ones(n, n);


% ���ڵ�Ķ�(ƽ��Ϊdout, ���Ӹ�˹�ֲ�)
if (dout == max_dout || dout == 1)
    degree = dout * ones(1, n);
else
    sigma = min([(max_dout-dout)*0.25, (dout-1)*0.25]); % ��˹�ֲ���׼��
    degree = round(normrnd(dout, sigma, 1, n));
    degree(degree <= 0) = 1;
    degree(degree > max_dout) = max_dout;
    while (sum(degree) ~= m)
        degree = round(normrnd(dout, sigma, 1, n));
        degree(degree <= 0) = 1;
        degree(degree > max_dout) = max_dout;
    end
end


%% ��֤�н��

% ��֤tour1, tour2�н�
rp = randperm(n-2)+2;
rand_eweight = floor(100 * rand(1, n-1));
G.tour = [1 rp 2];
for i = 1 : n - 1
    add_edge(G.tour(i), G.tour(i+1), rand_eweight(i));
end

% ��������
for i = 1 : n
    for j = 1 : n
        if G.m_dis(i, j) < max_weight
            degree(i) = degree(i) - 1;
            m = m - 1;
        end
        if G.m_dis2(i, j) < max_weight
            degree(i) = degree(i) - 1;
            m = m - 1;
        end
    end
end


%% �õ������

% ÿ���ڵ�i���Ƴ�degree(i)�����node_list
node_cnt = 0;
node_list = zeros(1, m);
for i = 1 : n
    node_list(node_cnt+1 : node_cnt+degree(i)) = i;
    node_cnt = node_cnt + degree(i);
end

% ����node_list, ��ʹ��node_list����ԪΪs, ĩԪΪt
node_list = node_list(randperm(m));
for i = m:-1:1  % ����һ��Ԫ��ʹnode_list����ԪΪs
    if (node_list(1) == G.s)
        break;
    end
    if (node_list(i) == G.s)
        node_list(i) = node_list(1);
        node_list(1) = G.s;
    end
end
for i = 1:m     % ����һ��Ԫ��ʹnode_list��ĩԪΪt
    if (node_list(end) == G.t)
        break;
    end
    if (node_list(i) == G.t)
        node_list(i) = node_list(end);
        node_list(end) = G.t;
    end
end

%����
rand_eweight = ceil(100 * rand(1, m-1));
for i = 1 : m - 1
    if (node_list(i) ~= node_list(i+1)) % ������Ϊʲô�����Ի���ԭ��
        add_edge(node_list(i), node_list(i+1), rand_eweight(i));
    end
end


%% ���ҽڵ���

G = shuffle(G);

    function add_edge(u, v, w)
        if (G.m_dis(u,v) == max_weight)
            G.m_dis(u, v) = w;
        else
            G.m_dis2(u, v) = w;
        end
    end
end