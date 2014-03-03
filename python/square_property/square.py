#!/usr/bin/python

import math

# new-style classes inherit from object
class Square(object):
    def __init__(self, side):
        self.side = side

    @property
    def area(self):
        return self.side * self.side

    @area.setter
    def area(self, area):
        self.side = math.sqrt(area)

    # @area.deleter is not used

