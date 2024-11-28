extension  Float
{
    func priceValidation(price : Float) -> Bool
    {
        if (price > 500)
        {
            return true
        }
        return false
    }
}
