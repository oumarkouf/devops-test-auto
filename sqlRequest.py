import cx_Oracle
username = 'OWN_AP22583'
password = 'N9ZI-G_9hF0efkH'
dsn = 'tuprevoyance02.xpf.net.intra'
port = 1521
encoding = 'UTF-8'
sid='D0PREVAP10'

allProducts = ["GTM","SP","PVQ","PB","GHOSPI","RNM","ASSIS","CA","ATC","AAC","SAC","TVI","AJ","PVGA","GFO","PROTEC","PACC","CAPREV","GCH","PSP","GIB","PRFAM"]

success_ds = ["SP","PVQ","PB","GHOSPI"]
success_r_ar = ["GTM","SP","PVQ","PB","GHOSPI","RNM","ASSIS","CA","ATC","AAC","SAC" ,"TVI" ,"AJ","PVGA"]

mylist=[]
listPolicies=[]
policiesTerminated=[]
polStatus = ['UNPAID','SUSPENDED']
dictPolicies = {}
dictPoliciesTerminated = {}
dictPoliciesUnpaid = {}
dictPoliciesTD = {}

#Functions
def filter_dict_success():
    global allPolicies,allPoliciesDS,allPoliciesTerminated,allPoliciesUnpaid,allPoliciesTD
    
    allPolicies = { key: dictPolicies[key] for key in success_r_ar if key in dictPolicies.keys() }
    allPoliciesDS = { key: dictPolicies[key] for key in success_ds if key in dictPolicies.keys() }
    allPoliciesTerminated = { key: dictPoliciesTerminated[key] for key in success_r_ar if key in dictPoliciesTerminated.keys() }
    allPoliciesUnpaid = dictPoliciesUnpaid
    allPoliciesTD = { key: dictPoliciesTD[key] for key in success_r_ar if key in dictPoliciesTD.keys() }

def filter_dict_failure():
    global allPolicies,allPoliciesDS,allPoliciesTerminated,allPoliciesUnpaid,allPoliciesTD

    allPolicies = { key: dictPolicies[key] for key in list(set(dictPolicies.keys()) - set(success_r_ar)) if key in dictPolicies.keys() }
    allPoliciesDS = { key: dictPolicies[key] for key in list(set(dictPolicies.keys()) - set(success_ds)) if key in dictPolicies.keys() }
    allPoliciesTerminated = { key: dictPoliciesTerminated[key] for key in list(set(dictPoliciesTerminated.keys()) - set(success_r_ar)) if key in dictPoliciesTerminated.keys() }
    allPoliciesUnpaid = {}
    allPoliciesTD = { key: dictPoliciesTD[key] for key in list(set(dictPoliciesTD.keys()) - set(success_r_ar)) if key in dictPoliciesTD.keys() }

def writeConfile(path):
    file = path + 'config.py'
    
    with open(file, 'w') as f:  
        f.write('allPolicies = ')
        print(allPolicies, file=f) 
    f.close()
    
    with open(file, 'a') as f:  
        f.write('allPoliciesDS = ')
        print(allPoliciesDS, file=f) 
    f.close()

    with open(file, 'a') as f:  
        f.write('allPoliciesTerminated = ')
        print(allPoliciesTerminated, file=f) 
    f.close()

    with open(file, 'a') as f:  
        f.write('allPoliciesUnpaid = ')
        print(allPoliciesUnpaid, file=f) 
    f.close()

    with open(file, 'a') as f:  
        f.write('allPoliciesTD = ')
        print(allPoliciesTD, file=f) 
    f.close()

#Connection to Oracle DB
dsn_tns = cx_Oracle.makedsn(dsn,port,sid)
conn = cx_Oracle.connect(user=username, password=password, dsn=dsn_tns)
c = conn.cursor()

"""
query = '''
    select POL_ID FROM 
    ( select POL_ID from POLICY 
        where POL_STATE='ACTIVE' and POL_STATUS='RUNNING' 
        ORDER BY DBMS_RANDOM.VALUE ) 
    WHERE ROWNUM <= 4
        '''
c.execute(query)
for row in c:
    #print(row)
    mylist.append(row[0])

with open('./tests/config.py', 'w') as f:  
    f.write('P_RI = "%s"\n' % mylist[0])
    f.write('P_RD = "%s"\n' % mylist[1])
    f.write('P_DS = "%s"\n' % mylist[2])
    f.write('P_AR = "%s"' % mylist[3])
f.close()


"""

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
        dictPolicies[product] = row[0]

#Policies for DSinistre and resiliation
#for i, e in zip(allProducts,listPolicies):
#    dictPolicies[i] = e


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
        dictPoliciesTerminated[product] = row[0]

#Policies for Cancel Termination
#for i, e in zip(allProducts,policiesTerminated):
#    dictPoliciesTerminated[i] = e


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
            dictPoliciesUnpaid[product] = row[0]

#Request for ACTIVE and TERMINATED_DELAYED policies
for product in allProducts:
    query = '''
        select POL_ID FROM 
        ( select POL_ID from POLICY where POL_STATE='ACTIVE' and POL_STATUS='TERMINATED_DELAYED' and POL_PROD_ID=
            '''
    query = query + "'" + product + "'"

    rest= '''
        ORDER BY DBMS_RANDOM.VALUE ) 
        WHERE ROWNUM <= 1
          '''
    query = query + rest
    c.execute(query)
    for row in c:
        dictPoliciesTD[product] = row[0]

conn.close()

filter_dict_success()
writeConfile('./allProductsTests/')

filter_dict_failure()
writeConfile('./allProductsTestsFail/')
