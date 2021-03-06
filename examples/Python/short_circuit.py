# Autogenerated with DRAKON Editor 1.32

def columnNN(nna, nnb):
    #item 96
    if (nna) or (nnb):
        #item 101
        nnm = 2
    else:
        #item 100
        nnm = 1
    #item 104
    return nnm


def columnNY(nya, nyb):
    #item 84
    if (nya) or (not (nyb)):
        #item 89
        nym = 2
    else:
        #item 88
        nym = 1
    #item 92
    return nym


def columnYN(yna, ynb):
    #item 72
    if (yna) and (not (ynb)):
        #item 76
        ynm = 1
    else:
        #item 77
        ynm = 2
    #item 80
    return ynm


def columnYY(yya, yyb):
    #item 18
    if (yya) and (yyb):
        #item 22
        yym = 1
    else:
        #item 23
        yym = 2
    #item 26
    return yym


def complex1(x1, x2, x3, x4):
    #item 114
    if ((x1) and (not (x2))) or (not ((x3) or (not (x4)))):
        #item 122
        return 1
    else:
        #item 127
        return 2


def complex2(x1, x2, x3, x4):
    #item 132
    if ((x1) or (not (x2))) and (not ((x3) and (not (x4)))):
        #item 138
        return 1
    else:
        #item 143
        return 2


def main():
    #item 109
    assert columnNN(False, False) == 1
    assert columnNN(False, True) == 2
    assert columnNN(True, False) == 2
    assert columnNN(True, True) == 2
    assert columnNY(False, False) == 2
    assert columnNY(False, True) == 1
    assert columnNY(True, False) == 2
    assert columnNY(True, True) == 2
    assert columnYN(False, False) == 2
    assert columnYN(False, True) == 2
    assert columnYN(True, False) == 1
    assert columnYN(True, True) == 2
    assert columnYY(False, False) == 2
    assert columnYY(False, True) == 2
    assert columnYY(True, False) == 2
    assert columnYY(True, True) == 1
    assert stairsNN(False, False) == 1
    assert stairsNN(False, True) == 1
    assert stairsNN(True, False) == 1
    assert stairsNN(True, True) == 2
    assert stairsNY(False, False) == 1
    assert stairsNY(False, True) == 1
    assert stairsNY(True, False) == 2
    assert stairsNY(True, True) == 1
    assert stairsYN(False, False) == 1
    assert stairsYN(False, True) == 2
    assert stairsYN(True, False) == 1
    assert stairsYN(True, True) == 1
    assert stairsYY(False, False) == 2
    assert stairsYY(False, True) == 1
    assert stairsYY(True, False) == 1
    assert stairsYY(True, True) == 1
    #item 128
    assert complex1(True, False, False, True) == 1
    assert complex1(True, True, False, False) == 2
    #item 146
    assert complex2(True, False, False, True) == 1
    assert complex2(False, False, True, True) == 1
    assert complex2(False, True, False, True) == 2
    #item 110
    print("all done!")


def stairsNN(nnas, nnbs):
    #item 58
    if (nnas) and (nnbs):
        #item 65
        nnms = 2
    else:
        #item 64
        nnms = 1
    #item 68
    return nnms


def stairsNY(nyas, nybs):
    #item 44
    if (nyas) and (not (nybs)):
        #item 51
        nyms = 2
    else:
        #item 50
        nyms = 1
    #item 54
    return nyms


def stairsYN(ynas, ynbs):
    #item 30
    if (ynas) or (not (ynbs)):
        #item 36
        ynms = 1
    else:
        #item 37
        ynms = 2
    #item 40
    return ynms


def stairsYY(yyas, yybs):
    #item 4
    if (yyas) or (yybs):
        #item 10
        yyms = 1
    else:
        #item 11
        yyms = 2
    #item 14
    return yyms

main()
