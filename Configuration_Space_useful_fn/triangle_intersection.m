function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
    % If no intersection or containment is found
    flag = false;
    
    function isInside = pointInTriangle(pt, tri)
        % Using barycentric coordinates to determine if a point is inside a triangle
        detT = det([tri(2,:)-tri(1,:); tri(3,:)-tri(1,:)]);
        lambda1 = det([pt-tri(1,:); tri(3,:)-tri(1,:)]) / detT;
        lambda2 = det([tri(2,:)-tri(1,:); pt-tri(1,:)]) / detT;
        lambda3 = 1 - lambda1 - lambda2;
        isInside = all([lambda1, lambda2, lambda3] >= 0 & [lambda1, lambda2, lambda3] <= 1);
    end

    % Helper function to check if two line segments intersect
    function doesIntersect = lineIntersect(A, B, C, D)
        % Line segment intersection using vector cross products
        a = B - A;
        b = D - C;
        c = C - A;
        % Sign of areas correspond to direction of cross product
        aCrossB = a(1) * b(2) - b(1) * a(2);
        t = (c(1) * b(2) - b(1) * c(2)) / aCrossB;
        u = (c(1) * a(2) - a(1) * c(2)) / aCrossB;
        % Check if scalar parameters are within bounds
        doesIntersect = t >= 0 && t <= 1 && u >= 0 && u <= 1;
    end

    % Iterate over each combination of edges
    for i = 1:3
        for j = 1:3
            A = P1(i,:);
            B = P1(mod(i,3)+1,:);
            C = P2(j,:);
            D = P2(mod(j,3)+1,:);
            if lineIntersect(A, B, C, D)
                flag = true;
                return;
            end
        end
    end

    % Check if any vertex of one triangle is inside the other
    for k = 1:3
        if pointInTriangle(P1(k,:), P2) || pointInTriangle(P2(k,:), P1)
            flag = true;
            return;
        end
    end


% *******************************************************************
end