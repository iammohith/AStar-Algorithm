function start_simulation(m, n, startCell, goalCell, obstacles)
    % A* Algorithm Pathfinding Simulation
    % Entry point that orchestrates the complete simulation workflow:
    %   1. Display the problem statement (grid with start, goal, obstacles)
    %   2. Display the A* exploration pattern (heuristic-guided search)
    %   3. Display the distances computed by A*
    %   4. Animate the shortest path simulation

    % First output: Grid display (Problem Statement)
    display_grid(m, n, startCell, goalCell, obstacles);
    title('Problem Statement');
    pause(5); % Pause for 5 seconds to view the grid

    % Second output: A* exploration pattern
    display_exploration(m, n, startCell, goalCell, obstacles);
    title('A* Exploration Pattern');
    pause(5); % Pause for 5 seconds to view the exploration

    % Third output: Distances from A* Algorithm
    display_distances(m, n, startCell, goalCell, obstacles);
    title('Distances from A* Algorithm');
    hold on;
    pause(5); % Pause for 5 seconds to view the distances

    % Fourth output: Shortest path simulation
    shortest_path(m, n, startCell, goalCell, obstacles);
    title('Shortest Path Simulation');
end
