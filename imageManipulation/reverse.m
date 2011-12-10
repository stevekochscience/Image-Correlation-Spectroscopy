function backwards = reverse(forwards);

% Reverses a string

for i=1:2:size(forwards,2)
    backwards(i) = forwards(end-i);
    backwards(i+1) = forwards(end+1-i);
end