#!/bin/sh

ALL_MODULES="Small Concurrency Exception Random CrudeIO Console"
MODULES=""

for MODULE in $ALL_MODULES; do
  ADD_IT=yes
  for EXCEPT in $WITHOUT; do
    if [ "${EXCEPT}x" = "${MODULE}x" ]; then
      ADD_IT=no
    fi
  done
  if [ "${ADD_IT}" = "yes" ]; then
    MODULES="${MODULES} ${MODULE}"
  fi
done

cat >Robin/Builtins.hs <<EOF
module Robin.Builtins (builtinModules) where

import qualified Robin.Core
EOF

for MODULE in $MODULES; do
    echo >>Robin/Builtins.hs "import qualified Robin.${MODULE}"
done

cat >>Robin/Builtins.hs <<EOF

builtinModules = [
EOF

for MODULE in $MODULES; do
    echo >>Robin/Builtins.hs "    (Robin.${MODULE}.moduleId, Robin.${MODULE}.moduleDef),"
done

cat >>Robin/Builtins.hs <<EOF
    (Robin.Core.moduleId, Robin.Core.moduleDef)
  ]
EOF

PACKAGES=""
for MODULE in $MODULES; do
  if [ "${MODULE}x" = "Consolex" ]; then
    PACKAGES="${PACKAGES} -package hscurses"
  fi
done

ghc ${PACKAGES} --make Main.lhs -o bin/robin
rm -f *.o *.hi Robin/*.o Robin/*.hi
