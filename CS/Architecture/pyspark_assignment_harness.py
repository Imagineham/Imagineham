import argparse
import numpy as np
import math

# The input file contains a 100,000x10 matrix.
# The matrix we are going to use is the first N lines of it, named A.
# And we are going to compute transpose(A)*A.
# Complete the functions below as directed.


# In this function, you seperate matrix into K 
# submatrices and retun the array
def create_submatrices(matrix, k):
    RSIZE = len(matrix)
    CSIZE = len(matrix[0])
    l = 0 #submatrix array index counter
    m = 0 #submatrix column counter
    temp = [] 
    Ret = []

    if (CSIZE % k) == 0:
        index = int(CSIZE/k)
    else: 
        index = math.ceil(float(CSIZE)/k)

    
    for l in range(k):
        temp = [] #clear temp
        for m in range(RSIZE):
            temp.append(matrix[m][l*index:(l+1)*index]) #copy data
        Ret.append(temp)
    return Ret
    # pass
    # TODO: complete this function


# In this function, you calculate the matrix
# multiplication of transpose(matrix)*matrix
def multiply_rows(matrix):
    i = j = k = l = m = sums = 0 #counters
    rows = [] 
    columns = []

    #first transpose given matrix
    temp = []
    tMatrix = []
    for i in range(SIZE):
        temp = []
        for j in range(SIZE):
            temp.append(matrix[j][i])
        tMatrix.append(temp)
    print("Printing tMatrix:")
    print(tMatrix)

    #then matrix multiply
    for k in range(SIZE):
        columns = [] 
        for l in range(SIZE):
            for m in range(SIZE):
                sums += matrix[k][m] * tMatrix[m][l]
            columns.append(sums) 
            sums = 0   
        rows.append(columns)
    return rows
    # pass
    # TODO: complete this function

# In this function, you sum up two submatrices
# to get the result
def sum_submatrices(matrix_a, matrix_b):
    i = j = sums = 0
    SIZE = len(matrix_a)
    rows = []
    columns = []

    if not(len(matrix_a) == len(matrix_b)):
        print("Error: Matrices are not the same size, cannot sum")
    else: 
        for i in range(SIZE):
            columns = []
            for j in range(SIZE):
                sums = matrix_a[i][j] + matrix_b[i][j]
                columns.append(sums)
            rows.append(columns)
        return rows
    # pass
    # TODO: complete this function


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--data_source', help="The URI where the CSV data is saved, typically an S3 bucket.")
    parser.add_argument(
        '--output_uri', help="The URI where output is saved, typically an S3 bucket.")
    parser.add_argument(
        '--N')
    parser.add_argument(
        '--K')
    args = parser.parse_args()

    matrix=[]
    with open(args.data_source) as reader:
        for line in reader.readlines():
            matrix.append([float(i) for i in line.split()])
    # Take the first N line in lines
    length = min(int(args.N),len(matrix))
    matrix = np.array(matrix[:length])
    print('The shape of the input matrix is: '+str(matrix.shape))
    assert (matrix.shape == (int(args.N), 1024)), \
        f"The shape of the output of input matrix should be ({args.N},1024)"
    # transpose matrix
    matrix = matrix.T.tolist()

    # Seperate the matrix into K submtrices
    submatrices = np.array(create_submatrices(matrix, int(args.K)))
    print('The shape of the output of create_submatrices is: ' \
        + str(np.array(submatrices).shape))
    assert (submatrices.shape == (int(args.K),1024/int(args.K),int(args.N))), \
        f"The shape of the output of input matrix should be \
            ({args.K},{1024//int(args.K)},{args.N})"
    
    # Calculate multiplication of submatrices
    submatrices = np.array([multiply_rows(m) for m in submatrices])
    print('The shape of the output of multiply_rows is: ' \
        + str(submatrices.shape))
    assert (submatrices.shape == (int(args.K),int(args.N),int(args.N))), \
        f"The shape of the output of input matrix should be \
            ({args.K},{args.N},{args.N})"

    # And sum the submatrices up
    res=submatrices[0]
    for i in range(1,len(submatrices)):
        res = np.array(sum_submatrices(res,submatrices[i]))
    print('The shape of the output of sum_submatrices is: ' \
        + str(res.shape))
    assert (res.shape == (int(args.N),int(args.N))), \
        f"The shape of the output of input matrix should be \
            ({args.N},{args.N})"
    # Write the results to output_uri

    # res.saveAsTextFile(args.output_uri)






