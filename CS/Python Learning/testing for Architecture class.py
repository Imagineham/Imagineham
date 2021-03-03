import math

#Defining variables
SIZE = 5 #size of given matrix
k = 2 #num submatrices
n = 0
index = int(SIZE/k)
print ("index after cast:", index) #return array index given in terms of k submatrices

#define matrix1
Ret = []

#will create a matrix of given size
#every element is just index

def create_2dmatrix(SIZE):
    i = 0
    j = 0
    rows = []
    columns = []
    
    for i in range(SIZE):
        columns = []
        for j in range(SIZE):
            columns.append(j)
        rows.append(columns)

    return rows

#creating copy matrix
matrix1 = create_2dmatrix(SIZE)
matrix2 = [[1, 2, 3, 0, 4], [2, 1, 3, 0, 4], [2, 3, 1, 0, 4], [3, 2, 1, 0, 4], [0, 0, 0, 0, 0]]
matrix3 = [[1, 1, 1, 1], [1, 1, 1, 1], [1, 2, 1, 1], [1, 2, 2, 2]]
SIZE = len(matrix2)

#printing copy matrix to check
print("Printing matrix1:")
print(matrix1)

#submatrix code testing
#we want to define number of iterations as a function of modularity
#ex: 10/3 we want to iterate 4 times 
if (SIZE % k) == 0:
    index = int(SIZE/k)
else: 
    index = math.ceil(float(SIZE)/k)

def create_submatrices():
    l = 0 #loop counter don't know why it has to be local
    m = 0 #row counter
    temp = []
    while l < index:
        temp = []
        for m in range(SIZE):
            temp.append(matrix2[m][l*k:(l+1)*k]) #copy data
            m += 1
        Ret.append(temp)
        l += 1 

create_submatrices()

print("Printing Return")
print(Ret)

#matrix transpose and multiply
def multiply_rows():
    i = j = k = l = m = sums = 0 #counters

    #first transpose given matrix
    temp = []
    tMatrix = []
    for i in range(SIZE):
        temp = []
        for j in range(SIZE):
            temp.append(matrix2[j][i])
        tMatrix.append(temp)
    print("Printing tMatrix:")
    print(tMatrix)

    #then matrix multiply
    rows = []
    columns = []
    for k in range(SIZE):
        columns = [] #clear columns
        for l in range(SIZE):
            for m in range(SIZE):
                sums += matrix2[k][m] * tMatrix[m][l]
            columns.append(sums) 
            sums = 0   
        rows.append(columns)
    return rows


MM = multiply_rows()
print("printing matrix_multiply:")
print(MM)

#sum submatrices
def sum_submatrices():
    i = j = sums = 0
    SIZE = len(matrix2)
    rows = []
    columns = []

    if not(len(matrix2) == len(matrix3)):
        print("Error: Matrices are not the same size, cannot sum")
    else: 
        for i in range(SIZE):
            columns = []
            for j in range(SIZE):
                sums = matrix2[i][j] + matrix3[i][j]
                columns.append(sums)
            rows.append(columns)
        return rows

SS = sum_submatrices()
print("Printing Sum Submatrices:")
print(SS)
