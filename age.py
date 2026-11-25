def is_adult(age):
    """Return True when age is 18 or older.

    Raises:
        TypeError: if age is not an integer (bool is not accepted).
        ValueError: if age is negative.
    """
    if not isinstance(age, int) or isinstance(age, bool):
        raise TypeError("Возраст должен быть целым числом")

    if age < 0:
        raise ValueError("Возраст не может быть отрицательным")

    # Учебный дефект: граница 18 лет обработана неверно.
    return age > 18
