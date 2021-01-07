clearvars;clc;
graph=LabPlot();
graph.xData=[1,2,3,4];
graph.yData=[2,4.1,5.9,8];
graph.xError=0.1*ones(size(graph.xData));
graph.yError=0.1*ones(size(graph.yData));
graph.FitType=fittype('poly1');
graph.Model='$\Delta=\lambda n+\delta$';
graph.Title='Measuring Wavelength $\lambda$';
graph.xLabel='$n$';
graph.yLabel='$\Delta$[m]';
graph.Coefficients=[Literal('\lambda','m'),Literal('\delta','m')];
if graph.validate()
    graph=graph.updatePlot();
end