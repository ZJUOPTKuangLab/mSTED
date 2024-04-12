function [x1,x2,y1,y2] = phasorFigure(phasorPlot,plotRes,a,b,t0,gA,sA)
% Draw the phasor plot and calculate the intersection of the
% fitted line and the universal semicircle, sqrt(0.25 - (x-0.5)^2)
% ******************************************************************************
% phasorPlot:    Phasor distribution
% plotRes:       Resolution of the phasor plot
% a, b:          slope and intercept of the fitted line
% t0:            Average fluorescence lifetime
% gA, sA:        Average phasor coordinates

x1 = (-2*a*b + 1 + sqrt((2*a*b-1)^2 - 4*(a*a+1)*(b*b)))/(2*(a*a+1));
x2 = (-2*a*b + 1 - sqrt((2*a*b-1)^2 - 4*(a*a+1)*(b*b)))/(2*(a*a+1));
y1 = a*x1 + b;
y2 = a*x2 + b;

phasorPlot(floor(plotRes/2)+1:end,:)=[];
phasorPlot2 = imadjust(mat2gray(phasorPlot),[],[],0.6);


figure('Color','k');
cmp = [zeros(3,33) jet(256)']';
cmp(1:33,3) = 0:0.5/32:0.5;
imagesc(phasorPlot2); colormap(cmp);

% Draw universal circle
xx = 1:plotRes;
yy = round(sqrt((plotRes/2)^2 - ((xx)-plotRes/2).^2));
hold on; plot([0,xx],[0,yy],'-w','LineWidth',2);
hold on; plot([0,xx],[0,0*xx],'-w','LineWidth',2);

% Draw line through scatter plot
lx = x2:0.001:x1;
hold on;plot(lx*plotRes,(a*lx+b)*plotRes,'--w','LineWidth',2);

hold on;plot(gA*plotRes,sA*plotRes,'or','MarkerFaceColor','r');
hold on;text(gA*plotRes,sA*plotRes,['  ',num2str(t0),'ns'],'color','r');


axis xy; axis image;axis off;

return