//
//  Rational.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/21/21.
//

typealias Rational = (num: Int, den: Int)

struct RationalUtil {
    // ** NOTE **
    // This was NOT my function. When I couldn't find a built in swift library to do this, I google
    // for outside influence and found this. I do no take credit for code. The link to this page is:
    // https://newbedev.com/decimal-to-fraction-conversion-in-swift
    static func rationalApproximation(of x0: Double, withPrecision eps: Double = 1.0E-6) -> Rational {
        var x = x0
        var a = x.rounded(.down)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)
        
        while x - a > eps * Double(k) * Double(k) {
                x = 1.0/(x - a)
                a = x.rounded(.down)
                (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
            }
        
        return (h, k)
    }
}
