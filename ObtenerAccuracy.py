import glob
from array import array


w, h = 4, 20;
confusion_file = [[0 for x in range(w)] for y in range(h)] 
files=[]
best_accuracy=[]
best_error=[]
best_file=[]

def readFile(file):
    read_file = open(file, "r")
    
    for j in range (0,20):
        line=read_file.readline()
        confusion_matrix_image=line.split(",")
        #print(confusion_matrix_image)
        confusion_file[j][0]=int(confusion_matrix_image[0])
        confusion_file[j][1]=int(confusion_matrix_image[1])
        confusion_file[j][2]=int(confusion_matrix_image[2])
        confusion_file[j][3]=int((confusion_matrix_image[3].split("\n"))[0])
        j=j+1
        if(j==20):
            return

def obtainAccuracyAndError(file):
    i=0
    for confusion_matrix_image in confusion_file:
        true_positive=int(confusion_file[i][0])
        false_negative=int(confusion_file[i][1])
        false_positive=int(confusion_file[i][2])
        true_negative=int(confusion_file[i][3])
        accuracy_by_image_by_one_set_parameters=(true_positive+true_negative)/(true_positive+false_negative+false_positive+true_negative)
        print(str(accuracy_by_image_by_one_set_parameters))
        error_rate=(false_negative+false_positive)/(true_positive+false_negative+false_positive+true_negative)
        if(accuracy_by_image_by_one_set_parameters>best_accuracy[i]):
            best_accuracy[i]=accuracy_by_image_by_one_set_parameters
            best_error[i]=error_rate
            best_file[i]=file
        i=i+1
        if i==21:
            return

def init():
    for i in range(0,20):
        files.append("")
        confusion_file[i][0]=0
        confusion_file[i][1]=0
        confusion_file[i][2]=0
        confusion_file[i][3]=0
        best_accuracy.append(0)
        best_error.append(0)
        best_file.append("")

def bestFiles():
    print("*******************************BEST FILES*******************************")
    for f in best_file:
        print(f)


def cargar(*args):
    files_all_dir=[]
    for x in args:
        print(x)
        for y in glob.glob(str(x)):
            files_all_dir.append(y)
    return files_all_dir
            


'''
Put the folders at the same level 
'''

if __name__ == "__main__":
        i=0
        init()
        '''
        directories must be writen separated by comma
        #files_all_directories=cargar("5/*.txt,"3/*.txt",...,"n/*.txt")  '''
        files_all_directories=cargar("5/*.txt","3/*.txt")
        for files_directory in files_all_directories:
                print(files_directory)
                files.append(files_directory)
                readFile(files_directory)
                obtainAccuracyAndError(files_directory)
                confusion_file = [[0 for x in range(w)] for y in range(h)] 
                i=i+1
        bestFiles()
        print("tamanhodir: ",len(files_all_directories))


    

