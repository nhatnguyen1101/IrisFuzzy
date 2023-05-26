% doc du lieu tu file iris.data
fileID = fopen('iris.data', 'r');
data = textscan(fileID, '%f%f%f%f%s', 'Delimiter', ',');

% dong file sau khi doc
fclose(fileID);

% Tách du lieu so và du lieu chuoi
numericalData = cell2mat(data(1:4));

% So luong cum muon phân chia
num_clusters = 3;

% Thuc hien phân cum bang thuat toán Fuzzy C-Means
[centers, U] = fcm(numericalData, num_clusters);

% Hien thi trung tâm cua các cum
disp('Trung tâm của các cụm:');
disp(centers);

% Hien thi phân bố của các điểm dữ liệu trong từng cụm
U = U.';
[maxU, index] = max(U, [], 2);
disp('Phân bổ của các điểm dữ liệu trong từng cụm:');
for i = 1:size(U, 1)
    fprintf('Điểm %d thuộc vô cụm %d với độ thuộc là %f\n', i, index(i), maxU(i));
end

% Đánh giá kết quả bằng cách tính toán tổng bình phương sai số
total_variance = sum(sum((U.^2) .* pdist2(numericalData, centers).^2));
fprintf('Tổng bình phương sai số : %f\n', total_variance);

% Gán màu cho từng cụm
colors = ['r', 'g', 'b'];

% Mảng chứa tên các thuộc tính
attributeNames = {'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'};

% Vẽ scatterplot cho từng cặp thuộc tính
figure;
for i = 1:4
    for j = 1:4
        if i == j
            continue; % Bỏ qua cặp thuộc tính trùng nhau
        end
        
        subplot(4, 4, (i-1)*4 + j);
        hold on;
        
        % Vẽ các Điểm dữ liệu và gán màu theo cụm
        for k = 1:size(U, 1)
            scatter(numericalData(k, i), numericalData(k, j), [], colors(index(k)), 'filled');
        end
        
        % Vẽ trung tâm của các cụm
        for c = 1:num_clusters
            scatter(centers(c, i), centers(c, j), 'LineWidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(c), 'Marker', 'o');
        end
        % Đặt tên cho các trục
        xlabel(attributeNames{i});
        ylabel(attributeNames{j});
        
        % Đặt giới hạn trục để đảm bảo cùng tỷ lệ trên tất cả các scatterplot
        xlim([min(numericalData(:, i)) max(numericalData(:, i))]);
        ylim([min(numericalData(:, j)) max(numericalData(:, j))]);
        
        hold off;
    end
end

