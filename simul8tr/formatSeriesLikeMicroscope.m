function formattedMatrix=formatSeriesLikeMicroscope(matrix, noBits);

% Makes any matrix look like a noBits one, normalized with the maximum
% value

matrix=matrix/max(max(max(matrix)));
formattedMatrix=round(matrix*(2^noBits-1));