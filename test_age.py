import unittest
from age import is_adult


class TestIsAdult(unittest.TestCase):
    def test_adult_above_18(self):
        """Основной случай: 25 лет — совершеннолетний."""
        self.assertTrue(is_adult(25))

    def test_exactly_18(self):
        """Граничный случай: ровно 18 лет — совершеннолетний."""
        self.assertTrue(is_adult(18))

    def test_negative_age(self):
        """Ошибочный случай: отрицательный возраст вызывает ValueError."""
        with self.assertRaises(ValueError):
            is_adult(-1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
