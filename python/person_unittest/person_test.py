#!/usr/bin/python

from person import Person
import unittest

class Tests(unittest.TestCase):
    def setUp(self):
        self.p = Person("George Smith", "male", 42)

    def test_name(self):
        self.assertEqual(self.p.name, "George Smith")

    def test_bad_age(self):
        # should raise an exception for non-integral age
        self.p.age = "frogs"
        self.assertRaises(TypeError, Person.__str__, self.p)

    def tearDown(self):
        del self.p

if __name__ == '__main__':
    unittest.main()

