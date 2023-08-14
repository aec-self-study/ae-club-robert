#test_subtract.py
import unittest

from calc2 import aec_subtract

class TestSubtract(unittest.TestCase):

    def test_subtract(self):
        arg_ints = [20, 5]
        sub_result = aec_subtract(arg_ints)
        self.assertEqual(sub_result, 15)

    def test_cant_go_below_zero(self):
        arg_ints = [5, 20]
        sub_result = aec_subtract(arg_ints)
        self.assertEqual(sub_result, 0)

    def test_raise_exception(self):
        arg_ints = [5, 20, 1]
        if len(arg_ints) > 2:
            self.assertRaises(Exception)

if __name__ =="__main__":
    unittest.main()