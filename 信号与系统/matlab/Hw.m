function H = Hw(w,T)
    %零阶保持系统Ho(jw)
    H = T .* sin(w .* T ./ 2) ./ (w .* T ./ 2);
end