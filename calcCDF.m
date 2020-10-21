function y_cum_norm = calcCDF(error, max_range, interval)
gap = max_range / interval;
error = reshape(error, 1, []);
e_m_cum = round(error / gap);
y = zeros(1, interval+1);
for i=e_m_cum
    if i < interval + 1
        y(i+1) = y(i+1) + 1;
    end
end
y_cum = cumsum(y);
y_cum_norm = y_cum / max(y_cum);
end

