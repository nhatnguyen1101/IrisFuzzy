% ??c d? li?u t? file iris.data
fileID = fopen('iris.data', 'r');
data = textscan(fileID, '%f%f%f%f%s', 'Delimiter', ',');

% ?óng file sau khi ??c
fclose(fileID);

% Tách d? li?u s? và d? li?u chu?i
numericalData = cell2mat(data(1:4));

% S? l??ng c?m mu?n phân chia
num_clusters = 3;

% Th?c hi?n phân c?m b?ng thu?t toán Fuzzy C-Means
[centers, U] = fcm(numericalData, num_clusters);

% Hi?n th? trung tâm c?a các c?m
disp('Trung tâm c?a các c?m:');
disp(centers);

% Hi?n th? phân b? c?a các ?i?m d? li?u trong t?ng c?m
U = U.';
[maxU, index] = max(U, [], 2);
disp('Phân b? c?a các ?i?m d? li?u trong t?ng c?m:');
for i = 1:size(U, 1)
    fprintf('?i?m %d thu?c v? c?m %d v?i ?? thu?c là %f\n', i, index(i), maxU(i));
end

% ?ánh giá k?t qu? b?ng cách tính toán t?ng bình ph??ng sai s?
total_variance = sum(sum((U.^2) .* pdist2(numericalData, centers).^2));
fprintf('T?ng bình ph??ng sai s?: %f\n', total_variance);

% Gán màu cho t?ng c?m
colors = ['r', 'g', 'b'];

% M?ng ch?a tên các thu?c tính
attributeNames = {'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'};

% V? scatterplot cho t?ng c?p thu?c tính
figure;
for i = 1:4
    for j = 1:4
        if i == j
            continue; % B? qua c?p thu?c tính trùng nhau
        end
        
        subplot(4, 4, (i-1)*4 + j);
        hold on;
        
        % V? các ?i?m d? li?u và gán màu theo c?m
        for k = 1:size(U, 1)
            scatter(numericalData(k, i), numericalData(k, j), [], colors(index(k)), 'filled');
        end
        
        % V? trung tâm c?a các c?m
        for c = 1:num_clusters
            scatter(centers(c, i), centers(c, j), 'LineWidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(c), 'Marker', 'o');
        end
        % ??t tên cho các tr?c
        xlabel(attributeNames{i});
        ylabel(attributeNames{j});
        
        % ??t gi?i h?n tr?c ?? ??m b?o cùng t? l? trên t?t c? các scatterplot
        xlim([min(numericalData(:, i)) max(numericalData(:, i))]);
        ylim([min(numericalData(:, j)) max(numericalData(:, j))]);
        
        hold off;
    end
end

