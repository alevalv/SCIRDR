function confusionMatrix = compare_image(Image1, Image2)
[row, col] = size(Image1);
truepositives = 0;
falsenegatives = 0;
truenegatives = 0;
falsepositives = 0;
for kk = 1 : row
    for yy = 1 : col
        if Image1(kk, yy) > 0 && Image2(kk, yy) == 1
            truepositives = truepositives + 1;
        elseif Image1(kk, yy) > 0 && Image2(kk, yy) == 0
            falsepositives = falsepositives + 1;
        elseif Image1(kk, yy) == 0 && Image2(kk, yy) == 1
            falsenegatives = falsenegatives + 1;
        else
            truenegatives = truenegatives + 1;
        end
    end
end
confusionMatrix = [truepositives, falsenegatives, falsepositives, truenegatives];
