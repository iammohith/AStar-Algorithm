function display_exploration(m, n, startCell, goalCell, obstacles)
    % Display the A* exploration pattern
    % Shows which cells were explored and in what order, demonstrating
    % how the Manhattan distance heuristic guides the search toward the goal

    % Run A* algorithm to get exploration data
    [~, ~, ~, exploration_order] = astar_algorithm(m, n, startCell, goalCell, obstacles);

    % Create the grid figure
    figure;
    hold on;
    title('A* Exploration Pattern');
    axis equal;
    xlim([0 n]);
    ylim([0 m]);
    set(gca, 'XTick', [], 'YTick', []);
    axis off;

    % Get max exploration order for color scaling
    maxOrder = max(exploration_order(:));
    if maxOrder == 0
        maxOrder = 1; % Prevent division by zero
    end

    % Draw the grid cells with exploration coloring
    for row = 1:m
        for col = 1:n
            cellIndex = (row - 1) * n + col; % Row-major linear index

            % Determine cell color based on type and exploration status
            if any(obstacles == cellIndex)
                color = [0 0 0]; % Black for obstacles
                textColor = 'w';
            elseif cellIndex == goalCell
                color = [1 0 0]; % Red for goal
                textColor = 'k';
            elseif cellIndex == startCell
                color = [0 1 0]; % Green for start
                textColor = 'k';
            elseif exploration_order(row, col) > 0
                % Color gradient for explored cells (light cyan to dark blue)
                t = exploration_order(row, col) / maxOrder;
                color = [0.7 - 0.5*t, 0.85 - 0.4*t, 1.0 - 0.3*t];
                textColor = 'k';
            else
                color = [1 1 1]; % White for unexplored cells
                textColor = [0.7 0.7 0.7];
            end

            rectangle('Position', [col-1, m-row, 1, 1], 'EdgeColor', 'k', 'FaceColor', color);

            % Show exploration order number for explored cells
            if exploration_order(row, col) > 0
                text(col - 0.5, m - row + 0.5, num2str(exploration_order(row, col)), ...
                    'HorizontalAlignment', 'center', 'Color', textColor, ...
                    'FontSize', 11, 'FontWeight', 'bold');
            elseif ~any(obstacles == cellIndex)
                % Show '-' for unexplored non-obstacle cells
                text(col - 0.5, m - row + 0.5, '-', ...
                    'HorizontalAlignment', 'center', 'Color', textColor, ...
                    'FontSize', 11, 'FontWeight', 'bold');
            end
        end
    end

    % Draw robot at start position
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    draw_robot(startCol - 0.5, m - startRow + 0.5);

    hold off;
end
