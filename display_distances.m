function display_distances(m, n, startCell, goalCell, obstacles)
    % Display the distances (g-values) computed by the A* algorithm
    % Shows the cost from the start cell to each explored cell

    % Run A* algorithm to get distance data
    [~, distances, ~, ~] = astar_algorithm(m, n, startCell, goalCell, obstacles);

    % Call the display_grid function to create the base grid
    display_grid(m, n, startCell, goalCell, obstacles);

    % Hold on to overlay the distances on top of the existing grid
    hold on;

    % Draw the robot at the start position
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    draw_robot(startCol - 0.5, m - startRow + 0.5);

    % Overlay distance values (g-values) in the center of each cell
    for row = 1:m
        for col = 1:n
            % Get the distance value
            distanceValue = distances(row, col);

            % Determine the text color and display value
            if isinf(distanceValue)
                textColor = 'w'; % White for obstacles/unreachable (Inf)
                displayValue = 'Inf';
            else
                textColor = 'k'; % Black for reachable cells
                displayValue = num2str(distanceValue);
            end

            % Display the distance at the center of each cell
            text(col - 0.5, m - row + 0.5, displayValue, ...
                'HorizontalAlignment', 'center', 'Color', textColor, ...
                'FontSize', 12, 'FontWeight', 'bold');
        end
    end

    hold off;
end
