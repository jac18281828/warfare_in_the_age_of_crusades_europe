#!/usr/bin/env /bin/sh

WEST=-4
EAST=4
NORTH=45
SOUTH=40

WIDTH=15c
PROJECTION=-JM10/${WIDTH}

OPT="-V --FONT_ANNOT_PRIMARY=10p"

PEN=0.25p,200/200/200
LINE=-W${PEN}
LAND=255
LAKE=170
RIVER=220
TRANS=15
MINAREA=-A100
SCALEBAR="f2/41/40/50M"

if [ ! -x $(which gmt) ]
then
    echo GMT required
    exit 1
fi

VERSION=$(gmt --version)

if [ "${VERSION}" = [0-5]* ]
then
    gmt --version
    echo gmt 6 reqired
    exit 1
fi

gmt gtd2cpt --show-sharedir

BEDROCK=ETOPO_europe.nc

if [ -f /bedrock/${BEDROCK} ]
then
    ETOPO=/bedrock/${BEDROCK}
else
    echo "${ETOPO} not found"
    exit 1
fi

gmt set PS_LINE_CAP=ROUND PS_LINE_JOIN=ROUND PS_SCALE_X=1 PS_SCALE_Y=1 MAP_ORIGIN_X=1c MAP_ORIGIN_Y=1c ANNOT_FONT_PRIMARY=18

BASEMAP='-B10dg10d -B+gwhite'

PROJECT="${NAME}"

gmt begin /pdf/${PROJECT}
    gmt basemap -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} ${BASEMAP} 
    gmt makecpt -Cgrey -T-50/1500
    gmt grdimage ${ETOPO} -n+c -I+a45+nt1 ${PROJECTION} -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${OPT}

    gmt coast -R${WEST}/${EAST}/${SOUTH}/${NORTH}  ${PROJECTION} ${OPT} -G${LAND} -t${TRANS} ${MINAREA}
    gmt coast -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -S${LAKE} ${MINAREA}
    gmt coast -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} ${LINE} ${MINAREA}
    gmt coast -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -I0/0.5p,${RIVER} -I1/0.5p,${RIVER} -I2/0.5p,${RIVER} ${MINAREA}
    # water bounds
    gmt coast -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -L${SCALEBAR} -N3/0.25p,${LAKE} ${MINAREA}

    if [ -f city.dat ]
    then
        cat city.dat | gmt text -Dj6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -F+f6p,Helvetica+jCB
        cat city.dat | gmt plot -Sc2p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT}
    fi

    if [ -f castle.dat ]
    then
        cat castle.dat | gmt text -Dj6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -F+f6p,ZapfChancery-MediumItalic+jCB
        cat castle.dat | gmt plot -Sd4p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT}
    fi

    if [ -f monastery.dat ]
    then
        cat monastery.dat | gmt text -Dj6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -F+f6p,Optima-Bold+jCB    
        cat monastery.dat | gmt plot -Sh4p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT}
    fi

    if [ -f battle.dat ]
    then
        cat battle.dat | gmt text -Dj6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -F+f6p,Times-Roman+jCB
        cat battle.dat | gmt plot -S+6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT}
    fi

    if [ -f place.dat ]
    then
        cat place.dat | gmt text -Dj6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} -F+f6p,AvantGarde-Book+jCB
        cat place.dat | gmt plot -Sx6p -R${WEST}/${EAST}/${SOUTH}/${NORTH} ${PROJECTION} ${OPT} 
    fi
gmt end
