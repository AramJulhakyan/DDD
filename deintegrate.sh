### Definitions

PROJECT=xcodeproj

### Deintegrate Frameworks

BASES=(MyFoundation System)
for BASE in ${BASES[@]} ; do
  pod deintegrate Libraries/Core/$BASE/${BASE}.$PROJECT
done

KITS=(MyUIKit)
for KIT in ${KITS[@]} ; do
  pod deintegrate Libraries/Kits/$KIT/${KIT}.$PROJECT
done

MODULES=(Authentication Feed Guests)
for MODULE in ${MODULES[@]} ; do
  pod deintegrate Libraries/Modules/$MODULE/${MODULE}.$PROJECT
done

### Deintegrate Apps
APPS=(DDDModularArchitecture)
for APP in ${APPS[@]} ; do
  pod deintegrate ${APP}.$PROJECT
done
