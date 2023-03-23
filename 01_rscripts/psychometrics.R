library(psych)


# Find two estimates of reliability: Cronbach's alpha and Guttman's Lambda 6.
bfi %>% select(N1:N5) %>% alpha()

# same result
items_N <- bfi %>% select(N1:N5) 
items_N %>% alpha()

# check arguments for alpha()
?alpha()


# Calculate McDonald's omega estimates of general and total factor saturation
bfi %>% select(N1:N5) %>% omega(nfactors = 1)
bfi %>% select(N1:N5) %>% omega(nfactors = 3)

bfi %>% select(A1:O5) %>% omega(nfactors = 5)

# Parallel analysis ------

bfi %>% select(A1:O5) %>% fa.parallel()

# check arguments for fa.parallel
?fa.parallel()

# PCA
bfi %>% select(A1:O5) %>% 
  principal(nfactors = 5)

library(lavaan)

fit_bfi_5 <- bfi %>% select(A1:O5) %>% 
  efa(nfactors = 5)
# check efa() arguments
?efa

fit_bfi_5 %>% summary(nd = 3L, cutoff = 0.2, dot.cutoff = 0.05)
