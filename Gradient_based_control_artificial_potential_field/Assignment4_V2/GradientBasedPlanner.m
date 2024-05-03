function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
route = 0;
% Initialize route with the start coordinates
route = start_coords;

% Initialize current position
current_pos = start_coords;

for i = 1:max_its
    % Get current position indices (swap x and y for matrix indexing)
    ix = round(current_pos(2));
    iy = round(current_pos(1));
    % Check if current position is close enough to the end position
    if norm(current_pos - end_coords) < 2
        break;
    end

    % Extract gradient components at the current position
    gx_val = gx(ix, iy);
    gy_val = gy(ix, iy);

    % Normalize the gradient vector
    norm_g = norm([gx_val, gy_val]);
    if norm_g == 0
        break; % Stop if gradient is zero
    end

    % Unit vector in the direction of the steepest descent
    step_direction = [gx_val, gy_val] / norm_g;

    % Update the position: move by 1 unit in the direction of the steepest descent
    new_pos = current_pos + step_direction;

    % Ensure the movement step size does not exceed 1.0
    if norm(new_pos - current_pos) > 1
        new_pos = current_pos + step_direction / norm(step_direction);
    end

    % Append new position to route
    route = [route; new_pos];

    % Update current position
    current_pos = new_pos;
end

% *******************************************************************
end
