function [path, distances, cells_explored, exploration_order] = astar_algorithm(m, n, startCell, goalCell, obstacles)
    % A* Algorithm for pathfinding using Manhattan distance heuristic
    % Inputs:
    %   m, n        - Grid dimensions (rows, columns)
    %   startCell   - Linear index of the start cell (row-major order)
    %   goalCell    - Linear index of the goal cell (row-major order)
    %   obstacles   - Array of linear indices representing obstacle cells
    % Outputs:
    %   path              - Nx2 matrix of [row, col] from start to goal
    %   distances         - m x n matrix of g-values (cost from start)
    %   cells_explored    - Number of cells explored during search
    %   exploration_order - m x n matrix showing exploration order (0 = unexplored)

    % Initialize g-scores (cost from start) with Inf
    distances = Inf(m, n);
    f_scores = Inf(m, n);
    exploration_order = zeros(m, n);

    % Convert start and goal to row-column indices (row-major order)
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);

    % Create obstacle map
    obstacle_map = false(m, n);
    for i = 1:length(obstacles)
        [obsRow, obsCol] = index_to_rowcol(obstacles(i), m, n);
        obstacle_map(obsRow, obsCol) = true;
    end

    % Initialize start cell: g = 0, f = h
    distances(startRow, startCol) = 0;
    h = abs(startRow - goalRow) + abs(startCol - goalCol); % Manhattan distance
    f_scores(startRow, startCol) = h;

    % Open list (priority queue): each row is [row, col, f_score]
    open_list = [startRow, startCol, f_scores(startRow, startCol)];
    closed_set = false(m, n);
    came_from = zeros(m, n, 2); % Parent tracking: came_from(r,c,:) = [parentRow, parentCol]
    cells_explored = 0;

    % Directions for moving: up, down, left, right (4-connectivity)
    directions = [0, 1; 0, -1; -1, 0; 1, 0];

    while ~isempty(open_list)
        % Select node with lowest f_score from the open list
        [~, idx] = min(open_list(:, 3));
        current = open_list(idx, 1:2);
        open_list(idx, :) = []; % Remove selected node

        currRow = current(1);
        currCol = current(2);

        % Skip if already in closed set (duplicate entry in open list)
        if closed_set(currRow, currCol)
            continue;
        end

        % Add to closed set and record exploration order
        closed_set(currRow, currCol) = true;
        cells_explored = cells_explored + 1;
        exploration_order(currRow, currCol) = cells_explored;

        % Check if goal reached — path found
        if currRow == goalRow && currCol == goalCol
            break;
        end

        % Explore all 4 adjacent neighbors
        for i = 1:size(directions, 1)
            newRow = currRow + directions(i, 1);
            newCol = currCol + directions(i, 2);

            % Check if the new cell is within bounds
            if newRow >= 1 && newRow <= m && newCol >= 1 && newCol <= n
                % Skip obstacles and already-explored (closed) cells
                if ~obstacle_map(newRow, newCol) && ~closed_set(newRow, newCol)
                    tentative_g = distances(currRow, currCol) + 1;

                    % Update if this path to the neighbor is better
                    if tentative_g < distances(newRow, newCol)
                        distances(newRow, newCol) = tentative_g;
                        came_from(newRow, newCol, :) = [currRow, currCol];
                        h = abs(newRow - goalRow) + abs(newCol - goalCol);
                        f_scores(newRow, newCol) = tentative_g + h;
                        open_list(end + 1, :) = [newRow, newCol, f_scores(newRow, newCol)];
                    end
                end
            end
        end
    end

    % Reconstruct path from goal back to start using came_from pointers
    path = [goalRow, goalCol];
    current = [goalRow, goalCol];
    while ~(current(1) == startRow && current(2) == startCol)
        parent = squeeze(came_from(current(1), current(2), :))';
        path = [parent; path];
        current = parent;
    end

    % Mark obstacles as Inf in the distances matrix for display purposes
    distances(obstacle_map) = Inf;
end
