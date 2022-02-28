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
%     x1Min = 0.775;
%     x1Max = 0.875;
    vx = Var{ii}(times{ii}>250,1)-Var{ii}(times{ii}>250,2);
    vy = diff(vx);
    vx = vx(1:end-1);

    d = 100;%1000;
    x = linspace(min(vx),max(vx),d);
    y = linspace(min(vy),max(vy),d);
    [gridx,gridy] = meshgrid(x,y);
    gridx = gridx(:);
    gridy = gridy(:);
    grid = [gridx gridy];
    i = 1:1:d;
    [gridix,gridiy] = meshgrid(i, i);
    gridix = gridix(:);
    gridiy = gridiy(:);
    gridi = [gridix gridiy];
%     v1 = Var{ii}(:,1);
%     v2 = Var{ii}(:,2);
    v = [vx vy];
    [v,grid] = ksdensity(v,grid);
    v = full( sparse(gridi(:,1), gridi(:,2), v, d, d) );
    
    ix = full( sparse(gridi(:,1), gridi(:,2), gridi(:,1), d, d) );
    iy = full( sparse(gridi(:,1), gridi(:,2), gridi(:,2), d, d) );
    ix = ix(:,1);
    iy = iy(1,:)';

    x = full( sparse(gridi(:,1), gridi(:,2), grid(:,1), d, d) );
    y = full( sparse(gridi(:,1), gridi(:,2), grid(:,2), d, d) );
    x = x(:,1);
    y = y(1,:)';
    save([mfilename '_' num2str(ii)],'x','y','v')
end
end

for ii = 1:length(Var)
    load([mfilename '_' num2str(ii)],'x','y','v')
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


    
    

    max(abs(x))
    dd=100;
    tmp = round(max(abs(x))*dd);
    if mod(tmp,2)~=1
        tmp = tmp + 1;
    end
    tmp = tmp/dd;
    tmp = linspace(-tmp,tmp,tmp*dd*2+1);
    tmpI = interp1(x,ix,tmp);
    tmp = tmp(~isnan(tmpI));
    tmpI = tmpI(~isnan(tmpI));
    ax.XTick = tmpI;
    ax.XTickLabel = cellstr(num2str(tmp'));
    
    max(abs(y))
    dd=1000;
    tmp = round(max(abs(y))*dd);
    if mod(tmp,2)~=1
        tmp = tmp + 1;
    end
    tmp = tmp/dd;
    tmp = linspace(-tmp,tmp,tmp*dd*2+1);
    tmpI = interp1(y,iy,tmp);
    tmp = tmp(~isnan(tmpI));
    tmpI = tmpI(~isnan(tmpI));
    ax.YTick = tmpI;
    ax.YTickLabel = cellstr(num2str(tmp'));

%     f3 = figure('WindowStyle','docked');
%     plot(Var(times{ii}>60,1:2))
%     ylim([xMin xMax])
%     grid on
%     ax = gca;
%     ax.XGrid = 'off';
end


