datatype shape =  Circle of real
                | Rectangale of real * real
                | Square of real


fun pow (x: real, n) =
    if n = 0 then 1.0 else x * pow(x, n - 1)


fun calc_area s = 
    case s of 
        Circle radius => Math.pi * radius * radius
        | Rectangale (v1, v2) => v1 * v2
        | Square v1 => pow(v1, 2)


val circle_area = calc_area(Circle 5.0)

val retangle_area = calc_area(Rectangale(3.0, 5.0))

val square_area = calc_area(Square 3.50)
