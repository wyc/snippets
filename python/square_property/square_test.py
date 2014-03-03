#!/usr/bin/python

from square import Square
import unittest

class Tests(unittest.TestCase):
    def setUp(self):
        self.sq = Square(10)

    def test_get_area(self):
        self.assertEqual(self.sq.area, 10*10)

    def test_set_area(self):
        self.sq.area = 16
        self.assertEqual(self.sq.area, 16)
        self.assertEqual(self.sq.side, 4)

    def tearDown(self):
        del self.sq

if __name__ == '__main__':
    unittest.main()

