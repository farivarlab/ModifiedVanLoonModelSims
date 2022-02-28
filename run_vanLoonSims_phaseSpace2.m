clear all
close all

load(fullfile('simRes','run_vanLoonSims_symetric_gammaOnly_triState_1.mat'))
param = 'gamma';
Var = Var.(param);
times = times.(param);

%% Plot time courses
for i = 1:length(Var)
    f{i} = plot_vanLoonSims(times{i}(end),250,times{i},Var{i});
end

% put all on same yscale
for subplotInd = 1:2
    YLim = [nan nan];
    for i = 1:length(f)
        YLim(1) = min([YLim(1) f{i}.Children(subplotInd).YLim(1)]);
        YLim(2) = max([YLim(2) f{i}.Children(subplotInd).YLim(2)]);
    end
    for i = 1:length(f)
        f{i}.Children(subplotInd).YLim = YLim;
    end
end

%% Plot phase space
if 1
for ii = 1:length(Var)
    display(['Level ' num2str(ii)])
    xMin = 0.775;
    xMax = 0.875;
    x1 = Var{ii}(times{ii}>250,1);
    x2 = Var{ii}(times{ii}>250,2);
    d = 400;%1000;
    gridx = linspace(min([xMin; x1; x2]),max([x1; x2; xMax]),d);
    gridi = 1:1:d;
    [x1,x2] = meshgrid(gridx, gridx);
    [i1,i2] = meshgrid(gridi, gridi);
    x1 = x1(:);
    x2 = x2(:);
    xi = [x1 x2];
    i1 = i1(:);
    i2 = i2(:);
    i = [i1 i2];
    v1 = Var{ii}(:,1);
    v2 = Var{ii}(:,2);
    v = [v1 v2];
    [v,xi] = ksdensity(v,xi);
    v = full( sparse(i(:,1), i(:,2), v, d, d) );
    i1 = full( sparse(i(:,1), i(:,2), i(:,1), d, d) );
    i2 = full( sparse(i(:,1), i(:,2), i(:,2), d, d) );
    i1 = i1(:,1);
    i2 = i2(1,:)';
    x1 = full( sparse(i(:,1), i(:,2), xi(:,1), d, d) );
    x2 = full( sparse(i(:,1), i(:,2), xi(:,2), d, d) );
    x1 = x1(:,1);
    x2 = x2(1,:)';
    save([mfilename '_' num2str(ii)],'x1','x2','v')
end
end

for ii = 1:length(Var)
    load([mfilename '_' num2str(ii)],'x1','x2','v')
    f2 = figure('WindowStyle','docked');
    hIm = imshow(repmat(uint8(zeros(size(v))),[1 1 3]));
    v = v - min(v(:));
    v = v./max(v(:));
    hIm.AlphaData = v;
    f2.Color = 'w';
    ax = gca;
    ax.Color = 'none';
    ax.XAxis.Visible = 'on';
    ax.YAxis.Visible = 'on';
    ax.YDir = 'normal';


    ax.YTick = interp1(x1,1:length(x1),xMin:0.1:xMax);
    ax.YTickLabel = cellstr(num2str((xMin:0.1:xMax)'));
    ax.XTick = ax.YTick;
    ax.XTickLabel = ax.YTickLabel;
    grid on

%     f3 = figure('WindowStyle','docked');
%     plot(Var(times{ii}>60,1:2))
%     ylim([xMin xMax])
%     grid on
%     ax = gca;
%     ax.XGrid = 'off';
end


