### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    KALMAN_FILTER.agc
## Purpose:     A section of Luminary revision 178.
##              It is part of the reconstructed source code for the final
##              release of the flight software for the Lunar Module's
##              (LM) Apollo Guidance Computer (AGC) for Apollo 14. The
##              code has been recreated from copies of Zerlina 56, Luminary
##              210, and Luminary 131, as well as many Luminary memos.
##              It has been adapted such that the resulting bugger words
##              exactly match those specified for Luminary 178 in NASA
##              drawing 2021152N, which gives relatively high confidence
##              that the reconstruction is correct.
## Reference:   pp. 1458-1459
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2019-08-14 MAS  Created from Zerlina 56.

## Page 1458
                EBANK=                  NO.UJETS
                BANK                    16
                SETLOC	                DAPS1
                BANK

                COUNT*	                $$/DAP

RATELOOP        CA                      TWO
                TS                      DAPTEMP6
                DOUBLE
                TS                      Q
                INDEX                   DAPTEMP6
                CCS                     TJP
                TCF                     +2
                TCF                     LOOPRATE
                AD                      -100MST6
                EXTEND
                BZMF                    SMALLTJU
                INDEX                   DAPTEMP6
                CCS                     TJP
                CA                      -100MST6
                TCF                     +2
                CS                      -100MST6
                INDEX                   DAPTEMP6
                ADS                     TJP
                INDEX                   DAPTEMP6
                CCS                     TJP
                CS                      -100MS		# 0.1 AT 1
                TCF                     +2
                CA                      -100MS
LOOPRATE	EXTEND
		INDEX                   DAPTEMP6
		MP                      NO.PJETS
		CA                      L
		INDEX                   DAPTEMP6
                TS                      DAPTEMP1        # SIGNED TORQUE AT 1 JET-SEC FOR FILTER
		EXTEND
                MP                      BIT10           # RESCALE TO 32; ONE BIT ABOUT 2 JET-MSEC
		EXTEND
                BZMF                    NEGTORK
STORTORK        INDEX                   Q               # INCREMENT DOWNLIST REGISTER.
                ADS                     DOWNTORK        #   NOTE: NOT INITIALIZED; OVERFLOWS.

                CCS                     DAPTEMP6
                TCF                     RATELOOP +1
                TCF                     ROTORQUE
SMALLTJU        CA                      ZERO
                INDEX                   DAPTEMP6
                XCH                     TJP
                EXTEND
## Page 1459
                MP                      ELEVEN          # 10.24 PLUS
                CA                      L
                TCF                     LOOPRATE
ROTORQUE        CA                      DAPTEMP2
                AD                      DAPTEMP3
                EXTEND
                MP                      1JACCR
                TS                      JETRATER
                CS                      DAPTEMP3
                AD                      DAPTEMP2
                EXTEND
                MP                      1JACCQ
                TS                      JETRATEQ
                TCF                     BACKP
-100MST6        DEC                     -160

NEGTORK         COM
                INCR                    Q
                TCF                     STORTORK

