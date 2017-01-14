function [X] = Copy_of_YiFanHu(row, lambda, I_Y, Y, A)

    C_u = I_Y + 40 * diag(row);
    X = (A + Y' * (C_u - I_Y) * Y + lambda * I_f)^-1 * Y' * C_u * row';
    
end