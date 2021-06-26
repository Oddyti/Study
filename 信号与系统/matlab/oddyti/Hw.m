% 零阶保持系统Ho(jw)
function H = Hw(w,T)
    H = T .* sin(w .* T ./ 2) ./ (w .* T ./ 2);
end