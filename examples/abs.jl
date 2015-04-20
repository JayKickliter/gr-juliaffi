
function abs!(y::AbstractVector, x::AbstractVector)
    for i in 1:length(x)
        y[i] = abs(x[i])
    end
    y
end

work = abs!