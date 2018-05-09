import os
import traceback
import sys
import cv2
import numpy as np

from decimal import Decimal
from PIL import Image
from PIL import ImageDraw
from robot.api import logger
import imagehash

class ImageLibrary(object):

    def crop_image(self, image_file, left, top, width, height):
        """Crop the saved image with given filename for the given dimensions and overwrite the current file.
        """
        if (int(left) < 0 and int(top) < 0):
            raise ValueError("either given left or top argument is not satisfied")
        img = Image.open(os.path.join(image_file))
        left = int(left)
        top = int(top)
        width = int(width)
        height = int(height)
        box = (left, top, left + width, top + height)

        area = img.crop(box)

        with open(os.path.join(image_file), 'wb') as output:
            area.save(output, 'png')
        return os.path.join(image_file)

    def resize_image(self, source, destination, width, height):
        """Resize the saved image to given width and height
            width/height could be decimal and it is used as a factor of a source width/height
        """
        try:
            img = Image.open(os.path.join(source))
            norm_width = Decimal(width.strip(' "'))
            norm_height = Decimal(height.strip(' "'))
            if (norm_width < 1 and norm_height < 1):
                source_width = img.size[0]
                source_height = img.size[1]
                img = img.resize((int(norm_width*source_width),int(norm_height*source_height)), Image.ANTIALIAS)
            else:
                img = img.resize((int(norm_width),int(norm_height)), Image.ANTIALIAS)
            img.save(os.path.join(destination),'png')
            return os.path.join(destination)
        except Exception, e:
            logger.info(e)
            raise RuntimeError("Cannot resize the image")

    def compare_image(self, image1, image2, min_similarity=0.9, hash_size=16):
        """Compare whether image1 is similar to image 2 or not. The algorithm used is phash.
            more detail can be found at http://www.hackerfactor.com/blog/index.php?/archives/432-Looks-Like-It.html
            if min_similarity is 0.9 and similarity of image 1 and image 2 is more than 0.9 (90%) then it's the same
        """
        #try:
        diff_threshold = 1.0 - float(min_similarity)
        hash_size=int(hash_size)
        logger.info("diff_threshold= 1 - %s = %s, hash_size= %s" % (min_similarity, diff_threshold, hash_size))
        hash1 = imagehash.phash(Image.open(os.path.join(image1)),hash_size)
        hash2 = imagehash.phash(Image.open(os.path.join(image2)),hash_size)
        diff_ratio = float(1.0*abs(hash1-hash2)) / (hash_size * hash_size)
        print "diff_ratio= %s, diff_threshold= %s" % (diff_ratio,diff_threshold)
        #logger.info("% difference between image1 and image2: %s with hash size: %s" % (diff_ratio, hash_size))
        if (diff_ratio <= diff_threshold):
            return True
        return False
        #except Exception,e:
            #logger.info(sys.exc_info()[0])
            #raise RuntimeError("Cannot compare the image")
            
    def compare_image_by_ahash(self, image1, image2, min_similarity=0.9, hash_size=16):
        """Compare whether image1 is similar to image 2 or not. The algorithm used is ahash.
            more detail can be found at http://www.hackerfactor.com/blog/index.php?/archives/432-Looks-Like-It.html
            if min_similarity is 0.9 and similarity of image 1 and image 2 is more than 0.9 (90%) then it's the same
        """
        #try:
        diff_threshold = 1.0 - float(min_similarity)
        hash_size=int(hash_size)
        logger.info("diff_threshold= 1 - %s = %s, hash_size= %s" % (min_similarity, diff_threshold, hash_size))
        hash1 = imagehash.average_hash(Image.open(os.path.join(image1)),hash_size)
        hash2 = imagehash.average_hash(Image.open(os.path.join(image2)),hash_size)
        diff_ratio = float(1.0*abs(hash1-hash2)) / (hash_size * hash_size)
        print "diff_ratio= %s, diff_threshold= %s" % (diff_ratio,diff_threshold)
        #logger.info("% difference between image1 and image2: %s with hash size: %s" % (diff_ratio, hash_size))
        if (diff_ratio <= diff_threshold):
            return True
        return False
        #except Exception,e:
            #logger.info(sys.exc_info()[0])
            #raise RuntimeError("Cannot compare the image")

    def find_sub_image_in_image(self, image1, image2, ignore_color=False,min_similarity=0.9):
        """Return the location of the image1 that locates in image2
        """
        result=[]
        if ignore_color:
            img_rgb = cv2.imread(image1, 0)
            template = cv2.imread(image2, 0)
        else:
            img_rgb = cv2.imread(image1)
            template = cv2.imread(image2)
        w, h = template.shape[:-1]

        res = cv2.matchTemplate(img_rgb, template, cv2.TM_CCOEFF_NORMED)
        loc = np.where(res >= min_similarity)
        for pt in zip(*loc[::-1]):
            result.append([pt[0],pt[1]])
        return result
            
    def fill_black_box_in_image(self, image, left, top, width, height):
        """Fil the black box in image
        """
        try:
            img = Image.open(os.path.join(image))
            left = int(left)
            top = int(top)
            right = left + int(width)
            bottom  = top + int(height)
            draw=ImageDraw.Draw(img)
            draw.rectangle((left,top,right,bottom),fill='black')
            img.save(os.path.join(image))
            logger.info('Fill black box successfully and file saved: ' + os.path.join(image))
        except Exception as e:
            logger.info(e)
            raise RuntimeError("Cannot fill black box in the image")

    def get_image_size(self, image):
        """Get size of image
            return size of image. format: python tuple {'width': w, 'height': h}
        """
        try:
            img = Image.open(os.path.join(image))
            source_width = img.size[0]
            source_height = img.size[1]
            return {'width': source_width, 'height': source_height}
        except Exception, e:
            logger.info(e)
            raise RuntimeError("Cannot get image size")
