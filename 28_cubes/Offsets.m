  XLENGTH = 22;
  XDIAG_DEMI = 15;
  YDIAG_DEMI = 22;
  RANK1_X_OFFSET = 250;
  RANK1_Y_OFFSET = 190;
  
  YDIAG = 2*YDIAG_DEMI;
  
X_offset = zeros(1,7); Y_offset = zeros(1,7);

for shift=0: 6
    X_offset(shift+1) = RANK1_X_OFFSET + shift*(XDIAG_DEMI+XLENGTH);
    Y_offset(shift+1) = RANK1_Y_OFFSET - shift*YDIAG_DEMI;
end

Point_nx = zeros(7,7); Point_ny = zeros(7,7);
for iter=0:6
    for dec=0: iter
        Point_nx(iter+1,dec+1) = X_offset(iter+1);
        Point_ny(iter+1,dec+1) = Y_offset(iter+1) + dec*YDIAG;
    end
end

