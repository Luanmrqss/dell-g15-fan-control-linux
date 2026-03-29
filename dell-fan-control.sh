#!/bin/bash
# Valor do boost (0 a 100)
BOOST=50

# 1. Força o perfil Balanced (Equilibra o Power Limit da CPU/GPU)
if [ -f /sys/firmware/acpi/platform_profile ]; then
    echo balanced > /sys/firmware/acpi/platform_profile
fi

# 2. Aplica o boost manual (O seu 25%)
# No Dell G15, o boost via hwmon costuma "atropelar" a curva do perfil ativo
for f in /sys/class/hwmon/hwmon*/fan*_boost; do
    [ -w "$f" ] && echo "$BOOST" > "$f"
done
