from xlrd import open_workbook

class ExcelLibraryForArtifex(object):

    def __init__(self):

        self.book = None
        self.sheet = None
        self.dict_list = None
        self.keyNameofFirstColumn = None

    def _serialize(self):
        keys = [self.sheet.cell(0, col_index).value for col_index in xrange(self.sheet.ncols)]
        self.dict_list = []
        for row_index in xrange(1, self.sheet.nrows):
            d = {keys[col_index]: self.sheet.cell(row_index, col_index).value 
                for col_index in xrange(self.sheet.ncols)}
            self.dict_list.append(d)
        self.keyNameofFirstColumn = self.sheet.cell(0, 0).value
        print self.keyNameofFirstColumn
        
    def changeExcelTab(self,tabnameorindex=0):
        if isinstance(tabnameorindex, unicode):
             self.sheet = self.book.sheet_by_name(tabnameorindex)
        else:
             self.sheet = self.book.sheet_by_index(tabnameorindex)
        self._serialize()

    def openExcelFile(self,filepath,tabnameorindex=0):
        self.book = open_workbook(filepath)
        if isinstance(tabnameorindex, unicode):            
             self.sheet = self.book.sheet_by_name(tabnameorindex)
        else:
             self.sheet = self.book.sheet_by_index(tabnameorindex)
        self._serialize()
        
    def get_cell_by_first_column_key(self, rowkey, columnkey):
        for obj in self.dict_list:
            if obj[self.keyNameofFirstColumn]==rowkey:
                return obj[columnkey]

    def get_value(self, key):
        print self.dict_list
        for obj in self.dict_list:
            if obj['Key']==key:
                return obj['Value']

    def get_dictionary_by_key(self, keyname):
        for obj in self.dict_list:
            if obj['key']==keyname:
                return obj

    def get_all_data_list(self):
        print self.dict_list
        return  self.dict_list
            

    def get_first_column_list(self, containKeyname=None):
        resultList = []
        for obj in self.dict_list:
            if containKeyname is not None:
                if containKeyname in obj[self.keyNameofFirstColumn]:
                    resultList.append(obj[self.keyNameofFirstColumn])
            else:
                resultList.append(obj[self.keyNameofFirstColumn])
        return resultList

    def get_first_row_list(self):
        resultList = []
        for col_index in xrange(1,self.sheet.ncols):
            resultList.append(self.sheet.cell(0, col_index).value)            
        return resultList
