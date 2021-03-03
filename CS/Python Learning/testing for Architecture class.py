import math

#Defining variables
SIZE = 3 #size of given matrix
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
        for j in range(SIZE):
            columns.append(j)
        rows.append(columns)

    return rows

#creating copy matrix
matrix1 = create_2dmatrix(SIZE)
matrix2 = [[11, 12, 5, 2], [15, 6, 10, 4], [10, 8, 12, 5], [12,15,8,6]]
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
    index = math.ceil(SIZE/k)

def create_submatrices():
    l = 0 #loop counter don't know why it has to be local
    while l < index:
        Ret.insert(l, matrix2[l][l*k : (l+1) * k]) #copy data
        l += 1 

create_submatrices()

print("Printing Return")
for x in Ret:
    print(x)

#matrix transpose and multiply