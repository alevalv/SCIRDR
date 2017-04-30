function [images, filenames] = print_SCIRDK(filters, properties)
%print_SCIRD - prints the kernel filters
%
% Syntax: images = print_SCIRD(filters, properties)
%
% Prints the kernel filters generated by SCIRD, by normalizing the values, to facilitate viewing
disp(['Printing ', num2str(size(filters, 2)), ' filters'])
for filters_ind = 1:size(filters, 2)
    vector = filters{1, filters_ind}(:);
    dimension = size(filters{1, filters_ind}, 1);
    normalized = (vector - min(vector)) / (max(vector) - min(vector));
    images{filters_ind} = vec2mat(normalized, dimension);
    filenames{filters_ind} = strcat('sa', num2str(properties(filters_ind).s1), '_sb', num2str(properties(filters_ind).s2), '_ka', num2str(properties(filters_ind).k1), '_kb', num2str(properties(filters_ind).k2),'_a', num2str(properties(filters_ind).angle), '.png');
end