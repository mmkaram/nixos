-- Merges ...dictionaries? objects? tables?
function merge(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
end
