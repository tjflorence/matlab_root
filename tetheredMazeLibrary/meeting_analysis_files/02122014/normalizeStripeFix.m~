function data = normalizeStripeFix(data)

    x  = linspace(0,1,length(data.flyTheta_stripe));
    xi = linspace(0,1,1000);
    yi = interp1(x, data.flyTheta_stripe, xi);
    data.normalizedFix = (yi-pi);