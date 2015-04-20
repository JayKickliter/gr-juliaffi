# For folks not familiar with Julia, there is no need to define three functions
# 


#
# Negates a value.
#

function negate(x)
    -x
end


#
# Negates an array of values
#

function negate!(y::AbstractVector, x::AbstractVector)
    for i in 1:length(x)
        y[i] = negate(x[i])
    end
    y
end


#
# Defining work as negate, since all calls from jlblock assume
# the function that does the actuall processing is called work
#

work = negate!