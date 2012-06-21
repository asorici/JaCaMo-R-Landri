from zipfile import ZipFile


class Validator(object):
    
    ORG_PREFIX = 'org/aria/'
    PROJECT_PREFIX = 'rlandri/'
    
    def validateSolution(self,jarFile,userID):
        with ZipFile(jarFile, 'r') as jar:
            path = self.ORG_PREFIX+self.PROJECT_PREFIX+'user'+str(userID)
            for name in jar.namelist():
                if cmp(name,'META-INF/MANIFEST.MF') != 0:
                    if not name.startswith(path):
                        return False
        return True
