with(PlantGrowth, tapply(weight, group, mean))
with(PlantGrowth, aov(weight ~ group)) -> aov.out
print(summary.aov(aov.out))
print(summary.lm(aov.out))
