function shortest_path(m, n, startCell, goalCell, obstacles)
    % Visualize the shortest path found by the A* algorithm
    % Animates the robot moving step-by-step from start to goal

    % Display the grid with distances as the background
    display_distances(m, n, startCell, goalCell, obstacles);

    % Get the path and distances from A*
    [path, distances, ~, ~] = astar_algorithm(m, n, startCell, goalCell, obstacles);

    hold on;

    % Animate the robot along the A* path
    for idx = 1:size(path, 1)
        row = path(idx, 1);
        col = path(idx, 2);

        % Draw the robot at the current path cell
        draw_robot(col - 0.5, m - row + 0.5);

        % Display the distance value at the path cell
        distanceValue = distances(row, col);
        text(col - 0.5, m - row + 0.5, num2str(distanceValue), ...
            'HorizontalAlignment', 'center', 'Color', 'k', ...
            'FontSize', 12, 'FontWeight', 'bold');

        % Pause to visualize the movement
        pause(0.75); % Adjust pause time as needed for better visibility
    end

    % Mark the goal cell with robot and distance value
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);
    draw_robot(goalCol - 0.5, m - goalRow + 0.5);
    text(goalCol - 0.5, m - goalRow + 0.5, num2str(distances(goalRow, goalCol)), ...
        'HorizontalAlignment', 'center', 'Color', 'k', ...
        'FontSize', 12, 'FontWeight', 'bold');

    hold off;
end
