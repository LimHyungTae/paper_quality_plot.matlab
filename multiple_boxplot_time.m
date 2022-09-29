function multiple_boxplot2(data,xlab,Mlab,colors)

% data is a cell matrix of MxL where in each element there is a array of N
% length. M is how many data for the same group, L, how many groups.
%
% Optional:
% xlab is a cell array of strings of length L with the names of each
% group
%
% Mlab is a cell array of strings of length M
%
% colors is a Mx4 matrix with normalized RGBA colors for each M.

% check that data is ok.
if ~iscell(data)
    error('Input data is not even a cell array!');
end

% Get sizes
M=size(data,2);
L=size(data,1);
if nargin>=4
    if size(colors,2)~=M
        error('Wrong amount of colors!');
    end
end
if nargin>=2
    if length(xlab)~=L
        error('Wrong amount of X labels given');
    end
end

% Calculate the positions of the boxes
positions=1:0.25:M*L*0.25+1+0.25*L;
positions(1:M+1:end)=[];

% Extract data and label it in the group correctly
x=[];
group=[];
for ii=1:L
    for jj=1:M
        aux=data{ii,jj};
        x=vertcat(x,aux(:));
        group=vertcat(group,ones(size(aux(:)))*jj+(ii-1)*M);
    end
end
% Plot it
boxplot(x,group, 'positions', positions);

% Set the Xlabels
aux=reshape(positions,M,[]);
labelpos = sum(aux,1)./M;

set(gca,'xtick',labelpos)
if nargin>=2
    set(gca,'xticklabel',xlab);
else
    idx=1:L;
    set(gca,'xticklabel',strsplit(num2str(idx),' '));
end
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'TickLabelInterpreter','latex', 'fontsize', 20);


% Get some colors
if nargin>=4
    cmap=colors;
else
    cmap = hsv(M);
    cmap=vertcat(cmap,ones(1,M)*0.5);
end
color=repmat(cmap, 1, L);

% Apply colors
h = findobj(gca,'Tag','Box');
for jj=1:length(h)
   patch(get(h(jj),'XData'),get(h(jj),'YData'),color(1:3,jj)','FaceAlpha',color(4,jj));
end

if nargin>=3
    legend(fliplr(Mlab), 'Location','northeast','NumColumns',1, 'Interpreter','latex', 'FontSize', 20);
    set(gca, 'YScale', 'log')
%     ylim([0 100])
end