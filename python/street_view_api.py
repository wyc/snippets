import urllib
import urllib2

baseurl = "http://maps.googleapis.com/maps/api/streetview"
api_key = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'


def getImage(latitude, longitude):
    #gets set of 4 images (N,S,E,W) from google
    values = {'size': '640x640', 'location': str(latitude)
              + "," + str(longitude),
              'heading': 0,
              'key': api_key,
              'sensor': 'false'
              }
    for i in range(0, 359):
        values['heading'] = str(i)
        data = urllib.urlencode(values)
        full_url = baseurl + '?' + data
        print full_url
        response = urllib2.urlopen(full_url)

        img = response.read()
        imgfilename = "heading"
        if i < 10:
            imgfilename += "0"
        if i < 100:
            imgfilename += "0"
        imgfilename += str(i) + ".jpeg"
        f = open(imgfilename, 'w')

        f.write(img)
        print data
        print imgfilename
        print i


def getImages(minlat, minlong, maxlat, maxlong):
    imgs = []
    m = (maxlong - minlong) / (maxlat - minlat)
    b = maxlong - maxlat*m
    x = minlat
    while x < maxlat:
        imgs.append(getImage(x, m*x + b))
        x = x + 0.000001

    return imgs

minlat = 48.853542
maxlat = 48.853742
minlong = 2.347699
maxlong = 2.347899
#res = getImages(maxlat, maxlong, minlat, minlong)
#getImage(48.853642, 2.347799)
#getImage(40.707295, -74.012071)
getImage(41.89128,12.491329)
