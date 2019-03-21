# -*- coding: utf-8 -*-
#------------------------------------------------------------------------Program Begins--------------------------------------------------------------
#JMMS
import pandas as pd
import subprocess
import os.path
import glob
import sys

__author__ = "J0MS"
__author_email__ = "passwd@ciencias.unam.mx"

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

try:
    availableFuntions = {'Matriz de Correlacion': 'correlationMatrix.R', 'scatter Plot': 'scatterPlot.R', 'Histograma':'histogram.R', 'Regresion Lineal':'linealRegression.R' }

    print "Conekta_Riesgo.py v1.0 | @J0MS"
    print "Verificando librerias.."
    print " "
    ntotal_Analysis = 4
    n_actual_Analysis = 0

    def getLongestKey(dictio):
        tempList =[]
        #x=0
        #n = [x+1 for k in availableFuntions.items()]
        for e in availableFuntions:
            tempLen = len(availableFuntions.get(e))
            tempList.append(tempLen)

        return max(tempList)

    size_LongestFunction = getLongestKey(availableFuntions)
    cwd = os.getcwd()
    found_libraries = []
    usable_libs = []
    if os.path.isdir('./lib'):
        for f in availableFuntions:
            R_lib = availableFuntions.get(f)
            size_actualFunction = len(R_lib)
            final_limit = 36 - (size_actualFunction + 12) #Revisar esos numeros
            if os.path.isfile(cwd+'/lib/'+R_lib):
                n_actual_Analysis = n_actual_Analysis + 1
                myList=[]
                longest_Word=[]
                usable_libs.append(R_lib)
                for i in range(0, final_limit):
                    myList.append('.')
                    a = R_lib + chr(27)+'\033[92m'+ ''.join(myList) + " presente." +chr(27)+"[0m"
                    longest_Word.append(len(a))
                    if len(a) == 44:
                        found_libraries.append(a)
        for library in found_libraries:
            print library

        print "Disponibles " + str(n_actual_Analysis) + " de " + str(ntotal_Analysis)+ " librerias. "
    else:
        print bcolors.FAIL + "Advertencia: Ninguna libreria disponible." + bcolors.FAIL +chr(27)+"[0m"

    print " "
    print "Ingrese el indice de archivo para analizar:"
    #f = raw_input()
    f = ""
    
    if os.path.isdir("data/"):
            detectedFiles = glob.glob("data/*.xlsx")
            print "Archivos detectados:"
            i = 1
            for e in detectedFiles:
                i+1
                print i,")"," ",e
            
            
    else:
        print bcolors.FAIL + "Error: No dispone de la carpeta de datos (data/)." + bcolors.FAIL +chr(27)+"[0m"
        sys.exit()
    
    val = int(raw_input())
    try:
        if val <= len(detectedFiles):
            f = detectedFiles[val-1]
        else:
            print("Indice invalido")
        
    except ValueError:
        print("Error en la lectura de archivo.")
        

    #print "Ingrese extensiones" + '\n' + "          1=.xlsx" +'\n' + "          2=.csv" +'\n' + "1/2?:"
    #getExtension = True
    extension = 1
    #while (getExtension):
    #    if extension == 1 or extension == 2:
    #        ~getExtension
    #        break
    #    else:
    #        print bcolors.FAIL + "Extension invalida, ingrese" +  bcolors.FAIL +chr(27)+"[0m"'\n' + "          1=.xlsx" +'\n' + "          2=.csv" +'\n' + "1/2?:"
    #        extension = int(input())


    def put_Extension(file,ext):
        temp = lambda x: file + '.xlsx' if  x== 1 else file + '.csv'
        return temp(ext)

    def gen_CVSFiles():
        s = raw_input()
        dfn.to_csv(s)

    def printLibs():
        i = 0
        for library in usable_libs:
            i += 1
            print str(i) + "-->" + library
        print str(i+1) + "-->" + "Generar todos los analisis en simultaneo"
    
    filename = f

    def execAnalysis(query,funtionsLibrary):
        if (query== len(funtionsLibrary)+1):
            print "------------------Ejecucion de todos los analisis---------"
            for i in range (0,len(funtionsLibrary)):
                analysisName = funtionsLibrary[i-1]
                print "Loading -->" + analysisName
                a = cwd+'/lib/'+analysisName
                subprocess.call (['Rscript', '--vanilla', a])
                print analysisName + " finalizado!"
            print "------------------Todas las operaciones completas---------"
        else:
            temp = 0
            for i in range (0,len(funtionsLibrary)):
                i += 1
                if query == i:
                    temp = query - 1
            analysisName = funtionsLibrary[temp]
            print "Loading -->" + analysisName
            a = cwd+'/lib/'+analysisName
            subprocess.call (['Rscript', '--vanilla', a])
            print analysisName + " finalizado!"

    if os.path.isfile(filename):
        print bcolors.OKGREEN + f + bcolors.OKGREEN + " cargado con exito." + chr(27)+"[0m"
        if extension == 1:
            xl = pd.ExcelFile(filename)
            print "Hojas disponibles en el libro actual:"
            print(xl.sheet_names)
            print "Ingrese el nombre de la  hoja:"
            getSheet = True
            query = raw_input()
            while (getSheet):
                if query in xl.sheet_names:
                    df1 = xl.parse(query)
                    print "Hoja seleccionada:" + query + '\n'#,df1
                    ~getSheet
                    break
                else:
                    print bcolors.FAIL + "Hoja invalida" +  bcolors.FAIL +chr(27)+"[0m"+'\n'
                    print "Hojas disponibles en el libro actual:"
                   # print(xl.sheet_names)
                    query = raw_input()

            print "Especifique un analisis:"
            printLibs()
            getAnalysis = True
            selectedAnalysis = input()
            while (getAnalysis):
                if selectedAnalysis in range(1,(len(usable_libs)+2)):
                    execAnalysis(selectedAnalysis, usable_libs)
                    ~getAnalysis
                    break
                else:
                    print bcolors.FAIL + "Seleccion de analisis invalido" +  bcolors.FAIL +chr(27)+"[0m"+'\n',"Librerias disponibles en la sesion actual:"
                    printLibs()
                    selectedAnalysis = input()

        else:
            cvs = pd.read_csv(filename)
            print cvs
            print "Especifique un analisis:"
            printLibs()
            getAnalysis = True
            selectedAnalysis = input()
            while (getAnalysis):
                if selectedAnalysis in range(1,len(usable_libs)+2):
                    execAnalysis(selectedAnalysis, usable_libs)
                    ~getAnalysis
                    break
                else:
                    print bcolors.FAIL + "Seleccion de analisis invalido" +  bcolors.FAIL +chr(27)+"[0m"+'\n',"Librerias disponibles en la sesion actual:"
                    printLibs()
                    selectedAnalysis = input()

    else:
        print bcolors.FAIL + "Archivo inexistente." + bcolors.FAIL +chr(27)+"[0m"

except KeyboardInterrupt:
    print 'Ejecucion finalizda'
except Exception:
        traceback.print_exc(file=sys.stdout)
sys.exit(0)

#------------------------------------------------------------------Program Ends---------------------------------------
