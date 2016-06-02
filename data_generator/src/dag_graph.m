function [ G ] = dag_graph( n, reqs, reqs2, dout)
%RANDOM_GRAPH ����һ��n���ڵ�, reqs���ؾ��ڵ�, dout��ƽ�����ȵ�һ��ͼ
% ���ű����ɵ����ͼ��֤�н�; ��Ϊ�������ڽӾ�����, ����Ҳû���ر�
%
% *******��������********
% reqs2: tour2�ı�������
% m_dis2: �رߵĵڶ���
% tour: һ����s��t��tour(�����), ��tour����tour1�Ŀ��н�, Ҳ��tour2�Ŀ��н�
%
% ����: �׻ݿ�
% ����: 2016-05-19
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

rp = [1 randperm(n-2)+2 2];
for i = 1 : n - 1
    add_edge(rp(i), rp(i+1), ceil(100*rand()));
    degree(rp(i)) = degree(rp(i)) - 1;
end

%% ������
for i = 1 : n-1
    x = rp(i);
    neibor = rp(i + randperm(n - i, min(degree(x), n-i)));
    degree(x) = degree(x) - numel(neibor);
    for y = neibor
        add_edge(x, y, ceil(100*rand()));
        if (degree(x) > 0 && rand() > 0.35)
            add_edge(x, y, ceil(100*rand()));
            degree(x) = degree(x) - 1;
        end
    end
end


% G = shuffle(G);


    function add_edge(u, v, w)
%         fprintf('edge: %d %d %d\n', u, v, w);
        if (G.m_dis(u,v) == max_weight)
            G.m_dis(u, v) = w;
        else
            G.m_dis2(u, v) = w;
        end
    end
end

