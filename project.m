% ??c d? li?u t? file iris.data
fileID = fopen('iris.data', 'r');
data = textscan(fileID, '%f%f%f%f%s', 'Delimiter', ',');

% ?�ng file sau khi ??c
fclose(fileID);

% T�ch d? li?u s? v� d? li?u chu?i
numericalData = cell2mat(data(1:4));

% S? l??ng c?m mu?n ph�n chia
num_clusters = 3;

% Th?c hi?n ph�n c?m b?ng thu?t to�n Fuzzy C-Means
[centers, U] = fcm(numericalData, num_clusters);

% Hi?n th? trung t�m c?a c�c c?m
disp('Trung t�m c?a c�c c?m:');
disp(centers);

% Hi?n th? ph�n b? c?a c�c ?i?m d? li?u trong t?ng c?m
U = U.';
[maxU, index] = max(U, [], 2);
disp('Ph�n b? c?a c�c ?i?m d? li?u trong t?ng c?m:');
for i = 1:size(U, 1)
    fprintf('?i?m %d thu?c v? c?m %d v?i ?? thu?c l� %f\n', i, index(i), maxU(i));
end

% ?�nh gi� k?t qu? b?ng c�ch t�nh to�n t?ng b�nh ph??ng sai s?
total_variance = sum(sum((U.^2) .* pdist2(numericalData, centers).^2));
fprintf('T?ng b�nh ph??ng sai s?: %f\n', total_variance);

% G�n m�u cho t?ng c?m
colors = ['r', 'g', 'b'];

% M?ng ch?a t�n c�c thu?c t�nh
attributeNames = {'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'};

% V? scatterplot cho t?ng c?p thu?c t�nh
figure;
for i = 1:4
    for j = 1:4
        if i == j
            continue; % B? qua c?p thu?c t�nh tr�ng nhau
        end
        
        subplot(4, 4, (i-1)*4 + j);
        hold on;
        
        % V? c�c ?i?m d? li?u v� g�n m�u theo c?m
        for k = 1:size(U, 1)
            scatter(numericalData(k, i), numericalData(k, j), [], colors(index(k)), 'filled');
        end
        
        % V? trung t�m c?a c�c c?m
        for c = 1:num_clusters
            scatter(centers(c, i), centers(c, j), 'LineWidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(c), 'Marker', 'o');
        end
        % ??t t�n cho c�c tr?c
        xlabel(attributeNames{i});
        ylabel(attributeNames{j});
        
        % ??t gi?i h?n tr?c ?? ??m b?o c�ng t? l? tr�n t?t c? c�c scatterplot
        xlim([min(numericalData(:, i)) max(numericalData(:, i))]);
        ylim([min(numericalData(:, j)) max(numericalData(:, j))]);
        
        hold off;
    end
end

