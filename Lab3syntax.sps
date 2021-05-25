* Encoding: UTF-8.
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=Survived Sex
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN KURTOSIS SEKURT
  /ORDER=ANALYSIS.

CORRELATIONS
  /VARIABLES=Survived Pclass Age SibSp Parch
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY Pclass.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY Sex.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY SibSp.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY Parch.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY Parch
  /PANEL ROWVAR=Sex_numbered ROWOP=CROSS.

GRAPH
  /BAR(STACK)=COUNT BY Survived BY SibSp
  /PANEL ROWVAR=Sex_numbered ROWOP=CROSS.

GRAPH
  /BAR(GROUPED)=COUNT BY Survived BY SibSp
  /PANEL ROWVAR=Sex ROWOP=CROSS.

GRAPH
  /BAR(GROUPED)=COUNT BY Survived BY Parch
  /PANEL ROWVAR=Sex ROWOP=CROSS.
DATASET ACTIVATE DataSet2.
LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex SibSp Parch 
  /CONTRAST (Sex)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

RECODE Pclass (1=1) (SYSMIS=SYSMIS) (ELSE=0) INTO First_class.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Sex SibSp Parch Embarked Pclass Age 
  /CONTRAST (Sex)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Age SibSp Parch Sex 
  /CONTRAST (Sex)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

DATASET ACTIVATE DataSet1.
RECODE Age (SYSMIS=SYSMIS) (0 thru 17=1) (18 thru 39=2) (40 thru 100=3) INTO Age_cat.
VARIABLE LABELS  Age_cat '1 - 0-17 2-18-39 3-40-100'.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex SibSp Parch Age_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator
  /CONTRAST (SibSp)=Indicator
  /CONTRAST (Parch)=Indicator
  /CONTRAST (Age_cat)=Indicator
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

RECODE SibSp (SYSMIS=SYSMIS) (0=0) (1=1) (ELSE=2) INTO Sib_Sp_cat.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex Age_cat Parch_cat Sib_Sp_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator(1)
  /CONTRAST (Age_cat)=Indicator(1)
  /CONTRAST (Sib_Sp_cat)=Indicator(1)
  /CONTRAST (Parch_cat)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

DATASET ACTIVATE DataSet1.
RECODE Age_cat (SYSMIS=SYSMIS) (2=0) (1=1) (0=2) INTO Age_cat_reversed.
EXECUTE.

RECODE Sib_Sp_cat (0=2) (2=0) (1=1) (SYSMIS=SYSMIS) INTO Sib_sp_cat_reversed.
EXECUTE.

RECODE Parch_cat (0=2) (2=0) (1=1) (SYSMIS=SYSMIS) INTO Parch_cat_reversed.
EXECUTE.



NOMREG Survived (BASE=FIRST ORDER=ASCENDING) BY Sib_sp_cat_reversed Parch_cat_reversed Pclass Sex 
    Age_cat_rev
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=CLASSTABLE FIT PARAMETER SUMMARY LRT CPS STEP MFI IC.

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex Age_cat Sib_Sp_cat Parch_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator(1)
  /CONTRAST (Age_cat)=Indicator(1)
  /CONTRAST (Sib_Sp_cat)=Indicator
  /CONTRAST (Parch_cat)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).


LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex Age_cat Sib_Sp_cat Parch_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator(1)
  /CONTRAST (Age_cat)=Indicator(1)
  /CONTRAST (Sib_Sp_cat)=Indicator
  /CONTRAST (Parch_cat)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex Sib_Sp_cat Parch_cat Age_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator(1)
  /CONTRAST (Age_cat)=Indicator
  /CONTRAST (Sib_Sp_cat)=Indicator
  /CONTRAST (Parch_cat)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES Survived
  /METHOD=ENTER Pclass Sex Sib_Sp_cat Parch_cat Age_cat 
  /CONTRAST (Sex)=Indicator
  /CONTRAST (Pclass)=Indicator(1)
  /CONTRAST (Age_cat)=Indicator
  /CONTRAST (Sib_Sp_cat)=Indicator
  /CONTRAST (Parch_cat)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).
