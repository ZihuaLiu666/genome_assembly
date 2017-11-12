# Generate your heat map
This protocol describes how to generate heatmap by three columns **.matrix** files, which is genetated from **.allValidPairs** files.

### I. Generate small size .allValidPairs files
Generally, you just want to know the interaction of two seperate DNA fragments (or regions) within a chromosome. For example, I want to know the whether there is interaction between **region A (22618019 - 22672908)** and **region B (21895916 - 22068370)** within the chromosome 9.

    Here I show the first three lines of a complete .allValidPairs file:
    E00509:81:HF7YCALXX:8:2102:28909:49179  chr1  142  -   chr3   6071365  +  <forget about the rest data>
    E00509:81:HF7YCALXX:8:1101:31730:48160  chr1  142  +   chr18  11240651 +  <forget about the rest data>
    E00509:81:HF7YCALXX:8:1109:26372:45452  chr1  386  -   chr12  2580492  -  <forget about the rest data>
    
    
So you can see that this line indicates that the position 142 of chr1 interactes with position 6071365 of chr3. However, I just want to extract all the chr9-related data. So, I can use ```awk``` command ```awk '$2=="chr9" && $5=="chr9"' my_data.allValidPairs > my_data.allValidPairs.chr9``` (**NOTICE:** here chr9 in the second column and the fifth column is the marker for data extracting, and actually I only care about **four columns** (the 2rd, 3nd, 5th and 6th) of the .allValidPairs files).

    Here is your small size .allValidPairs file:
    E00509:81:HF7YCALXX:8:1118:27235:38368  chr9  33  +  chr9  25915975  + <forget about the rest data>
   
#### Congratulation! You have generated your small .allValidPairs files!

### II. Generate a .matrix files for heat map
We will use a pyhton script ```MakeIntraChrMatrix.py``` to build the matrix. Actually, the mechanism for the matrix building is to count the occurance numbers within different windows. For example, 10000 is the **window size** and I name position 1 to 10000 as **bin1**. so 
