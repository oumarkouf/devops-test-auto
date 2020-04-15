import cx_Oracle
username = 'OWN_AP22583'
password = 'N9ZI-G_9hF0efkH'
dsn = 'tuprevoyance02.xpf.net.intra'
port = 1521
encoding = 'UTF-8'
sid='D0PREVAP10'

allProducts = ["GTM","SP","PVQ","PB","GHOSPI","RNM","ASSIS","CA","ATC","AAC","SAC","TVI","AJ","PVGA","GFO","PROTEC","PACC","CAPREV","GCH","PSP","GIB","PRFAM"]

mylist=[]
listPolicies=[]
policiesTerminated=[]
polStatus = ['UNPAID','SUSPENDED']
dictPolicies = {}
dictPoliciesTerminated = {}
dictPoliciesUnpaid = {}


dsn_tns = cx_Oracle.makedsn(dsn,port,sid)
conn = cx_Oracle.connect(user=username, password=password, dsn=dsn_tns)
c = conn.cursor()
query = '''
    select POL_ID FROM 
    ( select POL_ID from POLICY 
        where POL_STATE='ACTIVE' and POL_STATUS='RUNNING' 
        ORDER BY DBMS_RANDOM.VALUE ) 
    WHERE ROWNUM <= 3
        '''
c.execute(query)
for row in c:
    #print(row)
    mylist.append(row[0])

for product in allProducts:
    query = '''
        select POL_ID FROM 
        ( select POL_ID from POLICY where POL_STATE='ACTIVE' and POL_STATUS='RUNNING' and POL_PROD_ID=
            '''
    query = query + "'" + product + "'"

    rest= '''
        ORDER BY DBMS_RANDOM.VALUE ) 
        WHERE ROWNUM <= 1
          '''
    query = query + rest
    c.execute(query)
    for row in c:
        print(row)
        listPolicies.append(row[0])

#Policies for DSinistre and resiliation
for i, e in zip(allProducts,listPolicies):
    dictPolicies[i] = e


for product in allProducts:
    query = '''
        select POL_ID FROM 
        ( select POL_ID from POLICY where POL_STATE='INACTIVE' and POL_STATUS='TERMINATED' and POL_PROD_ID=
            '''
    query = query + "'" + product + "'"

    rest= '''
        ORDER BY DBMS_RANDOM.VALUE ) 
        WHERE ROWNUM <= 1
          '''
    query = query + rest
    c.execute(query)
    for row in c:
        #print(row)
        policiesTerminated.append(row[0])

#Policies for Cancel Termination
for i, e in zip(allProducts,policiesTerminated):
    dictPoliciesTerminated[i] = e


#Request for Unpaid/Suspended Policies Cancelation
for product in allProducts:
    for stat in polStatus:
        query = '''
            select POL_ID FROM 
            ( select POL_ID from POLICY where POL_STATE='ACTIVE' and POL_STATUS=
                '''
        query = query + "'" + stat + "'"
        query = query + " and POL_PROD_ID="
        query = query + "'" + product + "'"

        rest= '''
            ORDER BY DBMS_RANDOM.VALUE ) 
            WHERE ROWNUM <= 1
              '''
        query = query + rest
        c.execute(query)
        for row in c:
            print(product)
            print(row)
            #policies.append(row[0])
            dictPoliciesUnpaid[product] = row[0]

conn.close()

with open('./tests/config.py', 'w') as f:  
    f.write('P_RI = "%s"\n' % mylist[0])
    f.write('P_RD = "%s"\n' % mylist[1])
    f.write('P_DS = "%s"' % mylist[2])
f.close()

with open('./allProductsTests/config.py', 'w') as f:  
    f.write('allPolicies = ')
    print(dictPolicies, file=f) 
f.close()

with open('./allProductsTests/config.py', 'a') as f:  
    f.write('allPoliciesTerminated = ')
    print(dictPoliciesTerminated, file=f) 
f.close()

with open('./allProductsTests/config.py', 'a') as f:  
    f.write('allPoliciesUnpaid = ')
    print(dictPoliciesUnpaid, file=f) 
f.close()