module Extra.Jump.TileMap exposing (fullscreen, level1)

import Math.Vector4 exposing (vec4)
import Playground.Advanced exposing (..)
import Playground.Batch.Tilemap as Extra
import Playground.Render exposing (defaultEntitySettings)
import Playground.Shader as Shader
import WebGL


level1 =
    Extra.tilemap 8 8 tileset1 lut1


fullscreen =
    custom 1
        1
        (\translate scaleRotateSkew opacity ->
            WebGL.entityWith
                defaultEntitySettings
                vertFullscreen
                Shader.fragFill
                Shader.mesh
                { uP = translate
                , uT = scaleRotateSkew
                , uA = opacity
                , color = vec4 (14 / 255) (21 / 255) (28 / 255) 1
                }
        )


vertFullscreen =
    [glsl|
            precision mediump float;
            attribute vec2 aP;
            void main () {
                gl_Position = vec4(aP, 0., 1.0);
            }
        |]


tileset1 =
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPAAAACgCAYAAAAy2+FlAAAAAXNSR0IArs4c6QAAIABJREFUeJztfX1wVVWW7+/EhMSAfBgvYgLN3KgYEzERxXYmDa0OvJ6B7ppn47TS3Ta03WCoQp1+w1CjVEHDFDqjdM3Q8gok6sCzp1Gf2DVPwzQF6jSY1mmUTsRcIkru0JKIXmjCV8iHct4f565z19l37332ufcmkHB+VbfOPWd/nH0/fmetvdbaa1tjx5fb0CCx+tGVuvLyf/zJCl356JpLdcX4uykJbfm3J2iL0VO9Xlu+e9Uibfn//KxW3/+EmLa896/v0ZY3vNSiLW9u+YP+/iMPact/fWiMtnzk8JHa8uqJ47XlFTVV2vLFn+dpy8/9eoO2/JtF+vFtW/YzbfmW+Qu05f+7bLS2/E86+7TlB4oKtOWzf/iEtvz9pkZ9/x36/9ex7i5tuf7bDxEixAWNkMAhQgxihAQOEWIQIyRwiBCDGCGBQ4QYxAgJHCLEIEZI4BAhBjGsLZb1U12Fh8ui2g4S7XFt+xBDCyuXbPwWgBUAKgC0rjix92ahynuo33ALnXS/WqeMMyj61gbLrzzb8Z6MrU/rf9jBZvReXY1hB5vT7hEpi9qH18QxfkkUifZ41vfPBSJlUZuPhZ+TBM4DMIK1uQyhdA6M7lfrfnoytv6n3a/WDZmH2solG99duWTj15PvvwXg/wG4GcDw5FHEdbJ+Zj7yH5j5yH+47wcSww42e150jSNSFrVPxtbbh9fEAQB0PN+IlEXtnz8cR6QsatN5YvWj7nl+st5wAJMBtMAh7vUA3gdwOsjN6Gk3snKR/Mm1qd55Gs5foC5XlSX7V/YN4NwE2HmfQFm+cslGe8WahcryyZVT7X2xPcryni2wC+fK++9+tc6mp3rv1dXofrVuRS4kyAWAm7/4ou+ZOTPmneg6e/qm4ktH+NX/ULzACTvzkf/Ajsf/MicDoz+xTlLuePyXJv08cXhNHGjWR+1lC1GSmiDRHrceWuuQ+KG1SfIuewyiBD4FYD+AG+CQtwUZkld872JTvX3y1i8c8hKRRWjIC2geDEnoyAsAOvICgI68AGBKXgDucSigt6/nGgA3FxVeqtfKxowCbq0ehU31p7Gp/l1sqv8mAA9hdzz+l2kSWJTMJhI6Uha1p18/HSvmz3SJnCkS7fGl45c4U0UKzaVzU0TKoja9VOWL5z6S0ViTJMbhNXEPeYGUBB4Q+BFwsIKTlVSzoULgs91nuj49/N/FANDdcxYSCfwegOtwxZgjuK78GgDXJK/fDOBVqiSSmIPOxSMHl16RsqhdUFiMt9vexYGOYky/fjp2AZ5yes9jzZf84u8BAGu+/4/Sz+qQ9gkAXvKKpBOlaKQsah/csRQNlY4Ef0gyZz24Yyn++TmkjVXWv3ifSFnU3jQtjlfmApvujWP+7vQ58GVwJO8HSEliX12Jg5NTSlSSvD5q8mAFSV96DZWH1UetTfaZMycAAJ99Kll4Ub/hFtRvuAzXlZ/orzEQYUnCjRt1BUqKivGn5bfg69FhuOOrha4kjpRFbS6Vq6u+4r4A53cSrxEqxpzDPTWlqBhzLm0MB3csdefFMsI1VC7C7Fj6wpoUeS8BANxYUwuZJD64YykSqx8FAPfIcfIF4NiyhTj5gvc6SeAz8M553wegXwYhge+fdggSF3A+t86aOphxbUWN1XE4jjOnT+DUyeOIt8Vw5VVfQdGwS8/lXXLJ71nVCll7sgPQ9yPaBfzKAUcSEYmB1AqdAx0xHADwaU8Prir82CFfTRVWbtohnReLhisRrcfz0Hq8AzL7bWFyfnxwx1JcPTN9BdJDZVGgcpFzFMZ+9cwn7HGjrnCvHTlxNG18I3/nUJHmuGIfD5VF7Z+v3oiHyqJSFfocvHPeU9pPGiIN5BIZStIXAC4tGl58Vdmf4OMPnT//qZPHcerkcQD4q607N7/GqrZCbpV24WfU05UTifm1Iz1dIFUaAPp6uoCmDqVR67EVztxalLy8/3tqSvGipI/UnDidvNSWyCu2TZ7bwrkHMtKK56JqDgCWZVnofrXuy7RRGaDoWxsu2XrftC9nf6fK9auJkF3vvboaOx7/JeY8v/sSAFg+ZeKX9KU2t/wB1VVf8V0n+0znCHS0tVzCJV/DSy2Y/Z3U+lVxLW7dG4ex4c7xgc75PEQcQ6I9bpWWV2klb1/yT6Y6miBIXdk9/eroILbPdixBP39HW0vafLOgsBhta6dhQt12AMAnG76B8od3o6+nKyPfrZ/3QcS6ZQvt1qYWrGtoTHuoiEi0x63yihF9ba2nCwBgyr0Re+8LCfdey6dM1LZf/5nebphvovqpFqVvvW+aTYThJCUDDvndiMSpfpxjaXmV/VTt5Whu+YOHsCry7jzOlARrBErLq+xv/6+Um6DziwL87C3vAum//VolfvZWDDPGjACQJ5SPTDsH4KnPMbX4mPt+T1eJdIwidH9ekz9xJoQPQl4TEovtgsD085cUpdRj/l4El8QHdyx1Lh5szpi8maC1KcWHRVee8/4vAZy6tNx9n2iPO0ktWr11yitG2G2tpwOPd9GV57D+szz3qLVC67JJ1L1xGADwyXfSMzYQmUXCinD+OJcr7yF+MYT/tsa57X90Z8raS2PiaG75Q5KMDj7q9WaAEM/F+hzlkya77/c0dSjHzZGtBApKXtk9TceTi7EQ+QCHgKafn5PVLwtFoj1uTajbbh/c4fz2E+q2Z0zeyZVTbcARJqK01+GV/Z0Akkay5DUSPDuPt2UyFF+I5F105Tk1gf3ISz8Cl7YmbR9s/COeqr3cJZtM2qqIC3jJS2Mh0NN53KgrXEPBeqSrOFQuO1epLIn2uPWizzxGBvqTqo5+yLUElo3DlMT9KYEJOukrouKb6wKNRQSRl2BK4oqaKnwbLVjXBsx5fnfgB0d5xYjABk9OWjoHJH5gvxxOADw/tilxAYe8gFxSAnriAunkJYiE5O9Nyv3qc2y4c7xy/P2BXEtgv3voSOxHOkBOPNXDQqY+mxA3W3Di8vuZSuDWphZXAgPOPFalRotz670vJCw+D+ak5BDJqqrnEtiEuECKhKbtxPriH8WUtKr2gJeAMslI5SZSM1IWtYPUzwX81Nr+mgPr7m/SLihM1GcgmBQuKSrGEcM5PIFIxQ2QQdTnipoqYH8qWR1Xo3/6XnfafXSQqcX8CKhJDgBWz2uL7KDkFX9obrk1qS/i2mEnpde5xFW1H8gVI5GyqD21+Bj2dJW49/WzQvvBRL3sbwmsGgeQvRXaFCrSqohFUyVA7lc1BUnjY91dviSeM2OeDQC79u9CQWFxINJzcAkcKYvafiT2k8CBXEjO/LXL/YET7fH8ujeg+xN/CaSrvdQWAKA0xafanG/yEkytz6bwmyOKdYL2Cf+Y9mJqIxsPmCm+v8gLmEnbXCMgeY8D6Ny1fxeA9P+jTI3+bfyY0f+TS1rVUSmBX/nBdF8CczVYIn3zZj7yXQDedZZASr2m8opvrkPra4s95bMlVmzChLrt+GTDN7TlIigM7m9u+orbd8NLLfiX3zvGstbjXiMVfwjMmTHP3rpzc04fCrSwo+E1J5Jn7lL9gov+xrplC20AWLx6Y7+NQ+dXbbg39bCf/YL8uwhqEc4Esnmw6p5zZsz7IxGXI9Eed10o5M/lJDYhsMwPLKrQOuRDs+5XJC6ANFV29neq0AukrbMk8lJ5xTfXoW3tNCDNxQTc+dD/Tbv3336t0ricgwha98ZhwGNsUn8ZU+6N2P+5fBV++NA7yjrZ4PZVywFEkmf6RPYnY+ttIjuQPeGJsIDXf8mvB8GL/74d1RPHo/nQYez+4FCgsTXcC3vGX7FzwFaRuL8gWp655Jc9OObMmGfLyAt4F01Q8NGMMSOkdh3R76vyA4vk9VOrlW4k0fhExBVVB1mkFSdn79XVLnnLH97tXn+q9nJPXfK9rv8sD9cOO5l0L+X5losIKoEJt69ajihmpV3nhMqETE7bCP5uSgJP7o2411VE5dee3BtBpGxE4DWkhEhZ1H76V0648tejw/CbeC8qapyy1qYW/Cbe69alct1586HD6Dw3Fr+J92Jf7JA17YaJdlASA8DOfwc4kTnIpuAnhTOdA5NmMLlyqm063452H0e8aAyi3ccBwH0fL0rtiuEXOSgL5pBBJKjfnDhP5hIRyQuo5z+6APEHG//oKW9bO82Rwqycq9DrP8tLM4j5lYtwAtLzUPfGYUyo244JddtR98Zh97oMe19IWGRUOBlbb0+5N5IKz0wSipPvqUcX2Pyouk5H2fYxt69ajif3Rjz9ctD1RHvcOjcB0rWmdK1nC6Rlifa4tS+2x/p6dBjWNTRa+2J7rB987yb84Hs3uediue68euJ47IvtsR646yYA/tuyiCBpS+QVpa9oEMzWQKjDvtgeq6So2DWeqcjLpe9PjnXiJ8c6ZdU88dXKQCDm/9VtOaSSwHTOr+cBDpH4i0OlOhO4tG14qcU9p35k5U/VXp5WriKnX7kKFWPOYcOd47HhzvHS5WEqOOpuCnOXwnpybwTj3usB4JDywcfqLX5UXX/wsXqLJKuMqJzY5RUjbPqBn9wbQWfTWdBDJe8TWIn2uOWGEW6qt4mgifa4VTgXFg8x5Krd4tm19rqGRqV0Est1582HnIc9SXU6D4LCubD+9he1nuQIpeVVtoys/TkP5gYsGoOq7qRuZ/+keyYA9/xgjOcagWL4CTyccsq9kT4AMA2dFI1WKgOWNhILSDdYmZAY8LqPgMvxVO3lKH94t6s2i+WA40oS45g5xPLHR43H6M/U4YwkhR3ojQF8DswDzQl7X0hYs64dac+6dqRU4i6eXeuS+MPmmHtOcEiccEn65NSbsLqvFQBc1bqtNUFEtzubzirHmmiPW5i/QDqTTrTHrS1PwJ67NKVOVtRUYV2N8+dsbWpB7d3PAfDOganc7Hy7XT1xGEbnZaY+A8C6hkaLPxg4UYlIfuqz7JpOjeaGNXEe7He/7aPHAgCuPBcFXk9d4xqpbIUTYe8LCXeHNJMoLFMDFgBYtDuh6HM0de4XFBanEZP3A8AjccXyH49WzwvWf5aHzkmlyvLRB+QE5vNgANr5b6I9bpHKHD06C/ErtgGAlMgAMOvakfZf/vU94NJXxIfNMaxraHSlsFheHR1jX/JV77NzWUEFnn2nGds+Ojkg1tcgq29kfejaq8rXLVtok/WbvyeYBlbQ/HdSaSWuKvxYuwZYHBc/97M+83GJ/3/RD7x8ykSbr6L7VfdY6XdMPmA6+lmhVdKXYFmWlXFOIXGhNcE0GMB0FUx/QnQj/evPb8Ptq5YrCUwgcpK0va66Eh82x3BddSW4Ci2223rfNPvZd5qxp6sEG+4cD3o/tfgY2r+4BM3x4xf8WuJMCQzI3VhBI6Lo/8qFDmAWFyCqyib3Ky2vOs7vQ/ftaGtxrVhb75tmAzAiML2XEVhmhdaB1gOnranlPlpVpBYFcpOvU3QhzXl+t8XLGl5qwYONf3R9wVytlqG55Q9YtVevptEXp4Iubln3g+syUMrArcoPrc1dTmHuRx5QH3KWGUSxIPmfqg+embOyYooda92bcwmcLXT2BJUEJncRdxvx9/QwUkncQOuBiXjiUQQNcvmUifYznY7FTWaNpqedWMbP9QsDsk9NTYEg/MEEJD/DlRPtVXsPWeKfsWcL7BEba9GzpdGmLIV+BOK+3p8/HMfcpfJ6s64dabd/cQk6eke7Urejd7T2z5fqW+9Dzhk21dtofA+jPvwA0kRXC+qc8ulfs0/seit93EnyytpzbS8bwh05cRTHupOZOJp2ZNpNzqCaA5P7SOdG8lOXZfHRhECLGbivizoqKJSt/03Bu5Bffq9rh53ER70jXZWcn/uN6dl39HmO+LibV0h8dZvq7YLNm9CXJPH3hw+3r19p4fSKRhTOhXUyBleyOgYiNYm5r5eMFaLlkea4kbLRdusl5zC84DqgV77yCRD8yEjF0JLEz7lU5uSVkdOvnJN311tpGSsuu4w9hCSGp8qKKTYdVVKYW9xpMcP53kVBtEIT9r6QsMorRniycBCZp9wbsT/ZrQ+V1C1yAAKklRUd1bwjmSpMRiuZ9Vl8nw0+KZBuBOBizvO7rT+LlkjV7N/Gj1mYvwB9m+rt8n/8Cf5s+HD72WfO4Ec/Hu66OUQ/cHnFWXv1/add4vhZlXUYnne90WcU/chiEAghiC1D+ofPMXnpMpH21CnnO1x9/2k8tDaKyy5LeHQKIi8/16nSf1p+C64q/BgvNuk/60BAZ4VWZeSg9yYSWKxH3MsDzJcScoiiXEXOjrYW68HGP7rzZTrnxgPR8a1yhMtAhgLVEXDCLmeMGeF5eZBUn5snVuJHPx6O307w/mee3BtJI9GWJ+BK2FVvfeDWI6JvvW9amttJxKTSSnw9Okz7+biE7Ww6i/KKEXbDa4uUQSDk+9a9pMiWvMk5s4q8/D2RlwhdWTHFFskLADryAk5WSh4tpoNf4nXTOir4RWIBKQNWZ9NZtLWetvzWBMsgkt1IApsMDpBLVQqJUx2zzaoPmJFYBdFni2iNE1B5tUPQuUsbrS1PJGyRLM55ImVV3j3aY1V+trgZ7V9cor03pUX1w9ylsCJlUfuyyxJYfb/zJBdDMzlo8YgM0q1GGDm/crQHYO6WfbE9VrbkXn3/aSx7znlonjoV8ZAX8BJVRmQVyIhlKoFVKWE5KsacU0bs6eDjB3Y/n2uFZhLZ1GUk1geAvEykL3VCIPO67EiSVnUcCNS9cdjzBe88ftpdKaKLJqKyuUthUWTU6JpLPRL52XcconZOKvW83/bRScvPJWQigQFHmk8tPoYiaxKWPTdCG4IJqMNbpdfJIEXk1ZRnJJkBl7yr7z/tktczF06Ck9dP+gLBJDAAl7xc0opSNxPyAmZCjkJ2RRdlkNVHvD5gIIFlA+M3yjZpG4BTwsDF86yRaI9bzprlvOR5aplXMppI+tTnkUbkCiCjxNxkHO+O8U6iu9EHOtB6mWOUGn2gA513OJK97011GKOpBKYHA/KBJ6felPOADyLfPllh7c22jpx+5D11KgJadPDYJmB4HnAKRzE873qcgmO8C0pcDlXqIw7aHeH//FsqDz1fmSXDi8L2J4ATQaaqr5PAfshGAluv/GC6UmXRPVWoA5pTcRcNxzdnOSuQostSixLiq51645dEzyXa43o9k2Hx7Fr7055roFqzGymL2hVjzimXuZG6rPoh/KKUul+ts5ds2KdsT6GUuh+aj3X69dOTKqA6GTmvf09NKdoO7FMGfETKovaGO8dr11g3vNTiyXc9WEESkycw9KsbFLzPrfdNs2c+8l3KZy4N0AH8AzlyDaUENiEvByevGABS/8FCAE4OofjqFtR/sBCPbWmEbPcWXRSPoy6p46X95i8ULSUDRQi9+V89AJA2hqceXWDXv/0lPu25BpMre6VjVPWtgqkEJrzRdhYJls5HhuaWP8jdZR6kviNKE/OvP78NP3zoHffIccdXC933b/5XT1rdrd//Gub84i388keb8d1n57nhqNGjzvLM717Vhl9+Wu4et0YvxZy4E++dTQIFXfJBEYElMEsbfDK23h52sBm9cOwL3d+psk23jhXXXbc2taCipkp6VEFVvq6h0Qq8O6GJekvE/dlbMTzYWAVOXgBJ8qbDL0Tv69Fh+LTnGuyL7ZGWtx7Pwz01pVjXHnxz5sWrN1q6QPoHH6u3pt0wMSmh1dFhQVboBDXC3Fl+KV5sOq6tE3T6QQT6V9xmb9252aIjr3PHV5245XXLFnrquHW//zXn+CPYW3dudmPLqZ/v3jfN/u5Vban7LajLKvMJSVROXtViBqrrZ7xS3efgjqXM8JciUferdUYkbm1qwZq6VD5x3DZZf1RBKKctWPPr3jiMRVee8+jwplZnIF3aApCuKiLyclVaxL7YHisbCUz72qhAscpokD9ASoqKlbmZaOHCf/6uF5PPxZRj7Dw3FsAh5Rg4MpHAOsi2vbwj8gXeTOQbqczSfZ1N6ibdcKrQ0zSVM4PwShE8lBKA8ncXJa8MJN1kkm7H4790/+M8B7qp8beiJsUP1dRGFr6sui7WcSWwCWn9VGfVckAZeeOrW9I2UZYt8+IgguvqLJ83Aw8+Vq8sX7V5p645SoqKIfsrmErg0Xmfa/vn6A8JfCHAbyFINuDS98iJXR5DqUwKB5K8kofAYzuWokEigWd/pwp4fndafR1EQvK0U6o6IsRrxiq0ytStW8MLiHNeB4/OrYVsuxU/FdlPxdbNcQHnKa1Ssf3mwEAqA8XuD9QStnrieG05R64lsAz3TP4TvJllInpaOUTH8737Ilm1J5U6edEcKTxaKoUp7DJy2RgkTh03MhbyuiMrF6XmwEwCm86BW5tagNsmS428OoLKCC4jfD5gHgkik8Af9Y70yet8zENeRxq3JKWxV131U5H9VGw/VIw5p1S1/ObABJ0K7vcAIYiraYBSqdtCVv/O8o+1dQctkv5kV70Wzxlo7nus+91+TXVLGFm5yHKs0NVKK7QJODl15abnAJBPT6hMfK/un0iT19lRk1NETanN6XNNPwkM6KOr/MjTejwPFWPOIdEuL9fNgU3uEcQKTSpgf9UnmG4Dc96k6oK6dgAY9dzmDgA4IZ5rmoqBQzokTplPPWR15zy/2wqqMhPI4NQfsCzLSq39DApagnchtW98D6i9OXWkazLkwJgSwgvVmllPzu0Fdbb0u99Ub496bjNO3D/P85uN+vAD82vX3aD8XSdXTrUpQZ/feE0/K6AP8PBbr54t8o3IoyLAgjrbJYkJxH5y3Z7KhWPBx9IYI+COWrvvzUargB0BJ3qKrhmNy29x+0UOMjzK8lK5GhWpzLmA6gEhgZifyxTUJi2WXsDP3oqhZYJ81VnVJ/sBAF+clO+tkD/SiXGaNvGYtHz3oRIfI5bmC41sc3ZFSKgI6PNjEKn6ctVeUl9JXKTyaSWQCneUEZZITRCJ7qksEjl5vgWw5+L878jA09jo8lPJ8lVlipQEagOuKgJunmajuwW4uQgAMCdY7Eu/IAiJ1y1baLc2tbhS16/tjDEj8NvrbpD2NeP0JwCAts/lwSjlE0cBAJY9ICfw6idHaAjsQ15tTitNWx2pctbeoF7npFKXxDIJzOv6nevGy8krI/K0GybaFIDyYlMHls+boZxLX1ddiVWbd7p1KWx08exaW2dAo+ASkhb8nBYDlJZX2XybUDqnBO90DGpINDL45FL6EgJIYcAhom7bmYHYkiYTpBPY4IvMhLymxMuovdDG5F6qjJYZY0Gd7ZmTz19g0bi+P3y4/YszZ6y5gLUFsBuGD8cvzpyxgJRhjVxcbrAJUkYxfs7Jy8NGqS7tnjA673NP4vUffO8mPMqCFPh50nWGY91dKCkq9px/2lMJIIZPe64BEHPV4CAk/rNoiS3uEyS7dr7BNRJVmQxEflUd0lbTcKVzoLS1IhbB8QyJ8RJuuScvtOETsPR1jSXufJA3i7oiZCq08TyYP+2Fz0Fk/f7w4TbOnHHPAceST1Zx1z8tuqkkbituSU9X3xw/NPdH1979nIdwwrm7jUmHcL61zSG56BkI4sqbMWYEfhs/Jr/WH9KXEFAKEzKRshRqytsunl1r49P+3QzeIXBA8krTwmbwI4w+0JFKqcLacxL2XaOOER19oAMJRTs/cBUaSJ/r8uvGJOZI/nkahg+3t5w5k6Y6k1QO3G+GEAnHz3VlQRApi9ovNnX4JlkfqiASA04Ax7qGRmvrfdPsDeroYQBANuWBFzN0/Pk0RLZtNyZv0Dlvwcf7PKR1jVXJa9lIWIKoPusIakTe+g1W2tM++f4XZ85YSJIYZ87gfBuz+gMU3vjJhm+40UK0Z7QvkecvsLCp/ngyaGPMCQDY9RZyda2/PrMKovQ29cNnCstauMjXjcTVZlH6JlY/mjGBRx/o8LQXycuvcSLT+9EHOpCY9Q3f+6juDRj8wZIqHr+nDrSTRN81kx0/tDgvNsUgck1FyqL2Nzo/x5HSVHaRikmVRuucA4Fcnv2lcpNHY5B874CPBBaJC0gMWNl+mf31Y2hgYsAi1Tmy7LHM+j7QAWzbPlCZnM87nnnhPgDexS0vIvN9iAk/vo1HCDr/lWfGnnOvP/OO8/6Zd8w3sFPio+Q8n435QrM6i1ASWDRWqfYH1sHED8tB0pWryzrpa3Ifk/sC3jlw35uNFqnOpCFkIYGNxzaY8eN7n0+TwEBqLghIEggq4Kl/22Qs2ZD++y5pkr/PJWgp4IUMa+z4cpvUUILM0qzaz0hsSzAlr6y9jLCq9gC0G6D5tSUVr0ASldX3ZmPWWTNdFZJUYj/VmMqFOfXJ2Hp7ZOUi62RsvV3YvMhde8tJUVFTlSYxaIEG9/GagG/8xV1H3C9MRIuURW2+AwZhKKTuySVMwyqDLJbIB/SuISKuyvcrm7cGgax9Nv3p4Cc9ZZboxKxvoODjfYH9xp2TSp3PUb/B6yPOAD1bYBdWLrLoCKQIDaQWorc2tSijqMjHawK+oIOTF4DrD3aOKfeWSgIDTrAKvffbklSsyyOferY4hjF6ePXn+eLZtbbsgZgN+sOglZP9gbNVYXOhApu0E11HHCprs9IJb3A/cDcZYGaYIptAUvqejK23C0nycglMhJ7baKGhEdNumGhXTxyfllGCL43M5JujNizXNviRoJoDE3Z/cMji5NQhSN3BhEVXnsPaERMAAGPGRnD88wSGHWxH79Vlbp2HT3+CVYrVcjLkA969fHVpYmXkJUL4qbEq4mTbnspM1Gjd/JeHUnKQBPYbA4dnHly/IRXkYWKwI5dU8n1hs7OFykiJBEZzanuV3R8csqonjj9vf/oJddtRXdzpnjd3jXbfEyFNNgTX1RVT9vT3+UCCCB0U7npgTk5VonYRNL+JlEXtTCTjhdJet5ghEwnMLdEJIPhWm6xe4Vx4VEf3fZLQYtOKmiplwoH+An2PzYqdB2meXj1xvO825JjDAAAWs0lEQVSCAbEuaRTZWrODgNRmv8yVmSJTsspgDbvza3bfvPkZNS7YvAkAkE37vjcbUxInAEpf342OthbH2CS5f8HmTY6fuD0u7T+ybXvODCw8+oZbLrkFVgWaa/E2dL549UZ3LiZm8nx0bq3b/7plC+3HtjSipKgYo/M+x9hxt+OOrxZ6Ynuf/pU3sdsDd93kRg75uWQW3LAxmRrYez4Qe/IOJWy9b5otmwf3Xl3mkvq5iVYwI1Yg8gkqoOsqyaC9O+8NQF5xrlxaXmV3KMjbd81kxxcr6b/g433onFSKCEtNI1s2aDImIg/gkErM/bWupsrW5QKuqKkCJ9cDd93kntODgc47lv8N0PgeSl/fjce2NDq5xRoa0drUgquLT6PhpcUobF6EW/4hhquahqWNjycXfPpXv8e6ZQvtlZt2AJjpShvuknmxqQPjRl2B1qZa/Cb+e9cQRucDBdrDmpLqc8t7povxhwrkRiyDuVrp67vR19MlXQ/sSmYh/JGfRw51Ou01FmeVcStyyJlrqQJKVO4nP2MZkVY2F1YRnJNPlHJEnKuLT+OV/Z3KI8fTv/q9awV++le/xwN33eSWla76F+m4K2qq8Mr+TtTe/RxG503EpNJKVNQUpqnSPdXrUdicvi1pa1NLWq6we2qcefyx7i40H/ocx7pHSM8HAmICuYudtBzpibB8yFv6+m6XvDKQ9BODMYhUpa/vdsmrQsHH+wKRlx4YHLKQTFk/qkUMsjIe4MERX92C1tcWA0hKSXYsKSpGw0t/rzzK2rS+ttiVlhwdy/8GHX8+Le06SeDGl+/HzmWHcKAj5krU1qYWPDq3FiVFxai9+znc8g9TUVJUjAfuusmtQ+Q9vCaOw2vinmsAcLBrhGvE7OvpwsGugSMv4EjgxbNrbZK89N40MGQowyuBDcgLaJKINb6XFk3FiSSVnAx+ElJFXp3fWNYn9QN4VeVM1WgASck2NS2dz+i8z1HYvAij8yZKj0BVWhsuJVubWly1uuSJjc5FgYA6Ccznz1wFJ+lesF/+m/BMj1lsXJcThBJYjXxT0hLSIrIkCxE4ofzam5JW1V5GXvdBY9Cf268BWVXSmhLWlxSl7k3HseNuxy3/EMOk0krpEejytikq9vRHc+Rj3V2eOazpHNjzvUhUcE5cvnDc85Dk37ciIq8/Ic55s0lEN9SQH9m2XRkOqVr/y388ai9KXtP2Oh8ul7h+95fdU+zfI3llASmaLUFVBOdGJ/6ezgHgqqZhqKgpVBxv8hi+Hrgrdc7nv4B6Dms6B+YSmLBi/kz3vWPQSr8mBvIMJHmBdIkbkjcFy7KsrLdfPJ/t/dpSnc5JpWlz78HgRqL+VW4g6qP50GE0vPT3SQk81Y1V9nND6faSMkHoRjJHf7iRnLzQC+qC79kBAPUbLs2oXQgXrh+bhVjKVHXX3SfU8yTjU/Sjsq5nlGkkRMbQEZgQnMDCgn7dEj4ZlH8C01U3mZZTHREDtRg7x59PXM6oaibWE1P+yPpRTQ0yThcUIiOYappBtBppRg6RxDJoM1oMBHnPJ3zG50uMC/3zhRg0yAe8FmRT8ipX9vgtncsxeXV+XEAe5lmweRP65s33+I+NJdGqlfrxrVpp9y1fEZI3xIDAiYVmFmTTpX1SCeyXxnOwS96h/vlCDDrkASlfbFYZH/3+3NlK5vMNv8/nI5kL7qi9sD9fiEGJ/CBSlyCq0AV31Np9fuTNRnLlEB6LLV3zU6Xn3OVPXh+1uS8kb4h+gGUtXGT7EDjNxcTnvp2TSi/Vzh/9yduF+QsGLi4vIHwNUoP884UY3LCG3fm1QEEUovTVmrz9/9xnCzZvKtLd74J2cxh8PsxfEPrKQ/QbjHdm4KlvjLJfGM6JZfHKgXC+fMEZTAtMNgTzk/jV0TF2c/z4hftQCzGgSF9OqADFE5smRfclbwabTkkxf4GV9upvBCTvX/+PH9oAMKm00nPO4c7NyZ0nuMeqo2NsAPiLicc95yEublhjx5fbpgnhZNJXVKGznjMGhM4PbOoDBsxV9Ww+38olG+0Vaxb6R5dpHkIN98Ke/cLQ218pRGbwJTBfzSOTvpzAA03eAYeftVzy+SZXTrUnlVbixppa/OT+L/HPz12C95sacaAj5qZqLbij1qb0RN0l76Ho2M3ubhB9bzZa1dEx9l9MPI7p44A//14dXv+3Ddh1BPj1oTEI1emLG1oCi1JXJ4GHOnlzER4ZSuAQuUYe4JWs9J6T12T+O1jIW3BHrU0vbKp3X+41BXw/n4Z0NOd9v6nRcy6OC0AqQYJiDrzriPc8xMWNnKwH1mJBXRfqNwxdP2iAzxdaoUPkGpZlWZgzY15GBN66c7Pfn/FsxWe9RXfPcnboe/qVtXjg2w+7kuhARwz7li7UdXFh79Ua+nlDnGdYd8+c70veAx0xZZlKopAkmTNjnn1jTS2efmUt/rT8lrQ+/SSSEc6DLziTtbSl5VU236sok35DCRyCQxvIoSPukRNHlWX8T8jJ+3bbu26doNtdajHAUjrThfAlRcW+G4z1XTMZeFO9NcpfTDyO5njQO4cYqlAS2I+8usyE/M9N6jIAVwITkfk2lplCZXgK4gMGgoVsZiJ5S4qKKZDDPtbdBVESc1cSUGeTC4nKuSsJt8MOXUghAAmBdcQlBEkryvuj9yVFxTkhL6Ahk0SK9SWvZx2+GRAdbS1WUvIqjVh9bzZazpgdi704xub4cas5DuB22P/0n7CA4/065hCDAy6BTYgLZCY1S4qK8Xbbu67aTH0MdHrS8w2T767g433aB8yvD41BSN4QhHwgOHmDJPfmO8PzP/BAZ/cnpGVmFNYF9+fqJz8DFuCvnodqcwiOfCB9j1kdSoqKcSRAcu++ni77WPq1Ac/u795bJAhTtQdatQ4RIltYN1bd+qVfJZnkZNn682hjr2EHm916E+pS++9m4md+u+1dV2JNrpwauL1oKCIXTq6Pfv0PxL0vZOh+u5y4EC9y5EOzpFAkLpBuwGpbOw1gxAWA7609i+nXT8cuwJ5+/XTjwYiqPFlvTSHOMUvLq2wgaUTqBwKZHOn+/UHeXBFZRTIimKyck08sF4kpI2omD+UQ6VC6kUQyqPbF6b262pW831sbbIMH1dzbY+TSENjPKNTX04VEe9wlUklRMUoqp9rHurvSpKL7h1IQhspLkuGQKmKJ/QApopn0QWMUywH2p2cPBqMv2gAiyXSk1BFaRUx+PZS8uUP+kRNHMW7UFZ6LMmKo5q0q8vKgDRE6o5mJhdrEmkvtZVLcPRdJR2VJgqSRMgkZ2Yl4sn7EMuqDSCobJy/3G7/vl2EI+lwqgpnEcuuwL7Yn7bsMkR3yAT0hiLgqo5NM6qrI62ft9iOvqQuLt9ep4JxYlC3jQEfM46em9byysRNJVffQ3ZsHdfC6fBx+f3aTyK5cQkdeE2KG5M09tKGUEoOVr+VYJK8paVX3DOp31lm4iRx8XPwanfMxU7msLZcoqr637twsrUPn/Pvi5ZzIqv5zDQ1B7cmVU8/xc8N2geqECA5r7PhyG0jtyK7ajV1HXJk/l9cXVXSCqV/Zz1+sax/EiHZjTS1e3lbvsWCvXLLR5uGgN9bU4v2mRncllljO6/HF+7SoQ+yL6pCqfPesBZD1p8LWnZuVW6yOG3UFJx2OnDiaJ1sCKpDTxb7YHuOcaSqEVuj+Ba0Hlv6Afki0x/MAZ9c1/gBg5RaVZ9h/TtoTeUQQUahMlS1j5ZKNNm8jLqPk5QRZX+I4/O4njk8cO40jUha1xYck2Tb4EQj38x1qsCzLwsolGzPaH3jFmoWXAsDkyqlp7Y+cOIpEe1xZnpRylwLAnBnzjO7PVUfqX/eEp0UXKpCVWndPkrB0b90qLCClbVAerHVbHsc9NamURS82dXjOOcSyF5s6jAhHDzgZYTmxk9+Zp79SwaJN5/yaWFcsI+MWN4L5GbzEcj9XlF/5xYp8UXq839QIruqJah/HnBnzbNl87Fi3o9KKkoHCKkl1jpRFpX7iAx2xtLmoiGS/NiAnFb+vTLU2DeNct+Vxo3oEGsuRE7uwa/8u9/reWCumVFa47+UYmVbXFPR5OXn5eFTTGA5OUPEa96XTdSIxkcnUyLUvtseS1fVzRfmVX4xIM2IRYemoIi/9OUWCqkBlqjoiaf0MNSJpRUkjghNWJLTs6U7XaE6ajQQG4CHkR70jtX0EJa9sXOL3QeWRsqjNpTCXpDqXlBiUwstkEljWB6/D2/SX2+piQD6Qkrr8vc6Qsmv/LifSikkYP/KqlhByK6sJaWVqIpUBaknDLekyqKKHjpw4GuhpL5PALzalO3tENZfey+rqwLUcsT+VKg3AQ2IVOVWEztT3nG1EVyh505HPCctJrAMnr5+bR0deIEXcIOSl84HA9Oun40BHLPD9xo26ApNKKz2aiuyBI76X1fW7j6ydqFKLDz8kSSxTmznEkFBdXZ209JOk2ZZfrHAlMD/mGjqS+2X+UElcXRsdZPNh3Z+DaxlB4JBmFxLtcStSFrVNrcBB6vJ7iQ83mVTmRw5RjRZJLS7akF3XSUdRxdbVA0KyBoG16u/qpX5MHUQV2s8PrCtPtMc9P2xQ0uqMM6ZWaN1cixvqgkpFCuQwapQhImXRcxJLc57oGiSf8JETR/OAlAtQjLcG/AlrKpFD9D9MdieUuniIvIn2eLGJH1hXLhLDVE1Ottf6sE3WHPtI4MDzLj4PHgBY/Hui75QIyiD9HDISqlY50fWQuBcO8g2kryfvscyAtXjuI2k5Xt5vasTWdid94vTrp6eVH+iIIZEsl7WXgY+VPUDyyJBDEo8HTKxYs9DirjLJuSdwgtrTvHfcqCvA81pTtBSdM6nUJI63o62lRnadlyfb+pJLpdaK81jZOmXV/XMFE8OXbPyq5Ze6fmT3G0zro3MN4/2BiTAiecUoJW7BFv28oqsoUha1F899JO1eJpZwWm+caI9bpELy+TR3/dC5eA/Cy9vqpbHGnLxUXzwHfElSrSrwI5fsjx2kzKRvOletMZZdl6nQNBbd/FkcE52LR5OHjuqzX2wwjnUlIqqMOn6GMD//rtjeTzPg4xBVbdGqzXeCkJ3L2vB+deT3Qy4kQ9A+gtbnxOMk0s1/ZX1QPf4yGRMPDtGViZqGSd9DHXmmVlZSnWXgLigZSPKq2ppIXBqDaiyiW4afi+RUkVXm2nl5W72nvngug+zPm4lPVSdlRKklwsQ9JNaTEclEvdeNhYjHX/y6qk9d3+IDwmS8QxXW2PHl2rQ3nCwysk+/frqSfLv273L9obI//JETR7F47iNGEk029wb6PzifVgnRCiXxnNej9ypV09Q9I5bl4jMEua9uvqq7h0m5zkAmG2N/pBAaStCq0Jw0fhJYB5208ov4EschAwXzkztKPDc9yvohspYUFbtk3hfbY4mL9U2kgkq9pDLZew5RivldD9K3CmL8s0rdNdEEdNKRS1rZIgod8XWffajDXQ/MpSyRRTyqICM2ry/z1fJgBZ61Msh9qb22QpaQWUpNJRI/D0IcWd+yP6hKxZa1DWLV1ZWr7uPnesrEsGYClSX7YrFO52R/YG5t5oTj5WJkkFiezf0vZOQi6EFFaNWf9EL64wYZS6YEpvcXC2k5LMuyMg4SpwCIk7H1NgCM/F0+Tt76BUb+Lh8rP7Cx4gaf7zG5q2C2+xPLFtSLeHlbPYBUappd+50wR5O2Kqzb8rj7EFEF6ptkpPBbPierk2mZrE6IwQvrxqpbff/Auljm1tcWY+Tv9O7klR+k30IkFEH0FfutUiK/LIdo1RbbcxKTr/flbfVuX/SeX5ONmx4COpJku4JG14dfGRCmtBnq0DLPL1ulDDKyBvGbEmH9VimJvl+RtOI9eb9AitREUB6gIV6jQA9VIjwd+pvEqvrZ3C/E4IFxYncOnkSOS18ib9DFESKx/KQuX+hgkjlElihgUmmlJ1aZS2vyaYtagsmaZUC9tjiomq1b8M6zYMja+y2GD0k+NJCmQgfNvbx47iPuXHflB7YxeXmssSh1TUASmPzIKjVZDCIR82qJoZ68rVif981isdPIKRJWReAgi9mzQZhPaujCJXAm+ZeBVCDHihssYwLnIq8xEZgW3KseAuJ1fiRXlUhq6ld0ZXFLOl1XWcIzIY3Jzgiy/ky2LQnX2g5N5AGZJ0/PFkdOHA00n+TtRN+yLNZaVJ1lqjTPtsHJy49AeuaL/gAle1OpxLJz5bYvwjVVIrkQgxvGq5FEyIxYQaSvjIRBQGTTqd7i3FokN82BxfQzsvBRMdGAX4BJNhkUZbmgdPmh/OqHxB26yM/l1iV+4ARKZdsIpk6LmTp0Elw3pxazbIgSVmynStvqh1yQx8+I1R/3DDE4YLyckLYWlZFXt4MAQTQmBU0SJyZmU/WtM0DJ6gDexG/8XlTGr3HNYTBEgoUY2jAmsCwljilENTcT9VkWikl9y47ivPbIiaPSeS+vk2iPW/SS3Us1hhAhzhfyTAmpMlzxuaBsDiwjVibpYVWkF6WpKq2qrA6QTlrxuo7oRgMPEaIf4SuBTbcWlUVgydTmoHNIWfJz1T0mlVZK640bdUXGVmRO8JC4IS40aAnM57x+riMK5iBrr8ytkwl5xcTkMqjS9cjm3KH6G2IoISf7AwNA56RSVHzWq62jIw+fX4p5oXXEFwMxxFhn3qd4nsyhHErUEIMWOVsPfL7aZ9pWHEOIEIMRlmVl9//125+XCLJyycZewM29PIy350v3+DH0Z4YIoUfe5MqpvSuXbOzN5Eid3D1rASaVVrqvu2ct8Ki8yUXzBe83NRZs3bl5GF/Avy+2x6LlevwYkjdECH/k7YvtGfbytvqCSaWVBS9vqy+4e9YC7ZHq7YvtcaUorcXdunOzRcv6aM7JM15s3bnZWrlko027HwCpsD/uK87FGtpcIFIWtafcG7EjZVE7Uhbder7HEyKEiHwWN2uLUpBUWX6dE4xLyRVrFlpzZsyz6chDNGnLkpVLNtor1iy0JldOtd9ue1e2ybPvps8yTLk3oiR7Z5OztVNb6+nAEn3CtNPobDqLyy47i1OnIkGbhwjR78jjhBGX23HS6sgLOJKWSLpr/y7Xai0jL+VUPtbdlUZi060oCTLyEmnpCADlFSPOu0QPESLXyJdJQdUaWhnRACcG+ulX1mLOjHn206+s9bikSF0WyevudAfv6plMJDCHjLwhQgxV5MlIGYS8QGrXvrfb3nWDPrjfmEgskheQL5XLdA4ckjbExYY8lQrLyNubvN4jHgHHVdTX0+UeVdi6c7NFuxvwvL0qSRtUAuvIe+pUJKM5bPhACHGhw80LrZqHJo+9+2J7holHAODuJBEU8SRry4+q9tzSfSGDtAW/nF58/2K/elQeutNC6KCUwMJxmOyY7KMAALmVpEddH1RPfA0W8gIpkvnl+qJE9HTkbTlC8oYwhmVZuLHqVlt2pJeuXFWWyZFesjEMhhf/DEHHn03b8HXxvnzJSy8/4snKxo4vz4rUg/ElEvDumfPtu2fOTyPljVW32nfPnJ92bTB/9vA18C9Yljlx+lsCBxnLhf4SH3CcxOL5UPi84ev8vAITpj8lsHiPofQSv6eh+BnD18C/YFnBCWMqgceOL1eS21RlH0qvoaJdhK8L6HVj1a0ZRT2RldpvPS7t3qezdGdughs8ED/rxfTZQ/QfLMsK/0MhQgxWGKeVDREixIWHkMAhQgxihAQOEWIQIyRwiBCDGCGBQ4QYxAgJHCLEIEZI4BAhBjH+P5gXUdLAMhG6AAAAAElFTkSuQmCC"


lut1 =
    "data:image/png;base64,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"
