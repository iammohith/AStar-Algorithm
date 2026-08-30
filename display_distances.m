function display_distances(m, n, startCell, goalCell, obstacles)
    % Generate the distance matrix using the Grassfire algorithm
    distances = grassfire_algorithm(m, n, goalCell, obstacles);
    
    % Call the display_grid function to create the grid
    display_grid(m, n, startCell, goalCell, obstacles);
    
    % Hold on to overlay the distances on top of the existing grid
    hold on;

    % Draw the robot at the start position
    [startRow, startCol] = ind2sub([m, n], startCell);
    draw_robot(startCol - 0.5, m - startRow + 0.5); % Center the robot within the cell

    % Overlay distance values in the center of each cell
    for row = 1:m
        for col = 1:n
            cellNum = (row - 1) * n + col; % Calculate cell number
            
            % Get the distance value
            distanceValue = distances(row, col);
            
            % Determine the text color based on the distance value
            if isinf(distanceValue)
                textColor = 'w'; % White for obstacles (Inf)
                displayValue = 'Inf'; % Display "Inf" for obstacles
            else
                textColor = 'k'; % Black for non-obstacle cells
                displayValue = num2str(distanceValue); % Display the distance value
            end
            
            % Display the distance at the center of each cell
            text(col - 0.5, m - row + 0.5, displayValue, ...
                'HorizontalAlignment', 'center', 'Color', textColor, ...
                'FontSize', 12, 'FontWeight', 'bold');
        end
    end
    
    hold off; % Release the plot
end