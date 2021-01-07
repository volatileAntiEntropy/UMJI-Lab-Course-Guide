classdef LabPlot
    %LABPLOT 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        Title (1,:) char = '';
        xLabel (1,:) char = '';
        yLabel (1,:) char = '';
        xData double {isvector(xData)} = 0;
        yData double {isvector(yData)} = 0;
        xError double {isvector(xError)} = 0;
        yError double {isvector(yError)} = 0;
        FitType (1,:) fittype = fittype();
        Model (1,:) char = '';
        Coefficients (1,:) Literal = [Literal('k',''),Literal('b','')];
    end  
    
    properties(SetAccess=private)
        xDataProcessed (:,1) double = 0;
        yDataProcessed (:,1) double = 0;
        xErrorProcessed (:,1) double = 0;
        yErrorProcessed (:,1) double = 0;
    end
    
    methods
        function obj = LabPlot()
            
        end
        
        function status=validate(self)
            arguments
                self (1,1) LabPlot;
            end
            status=isequal(size(self.xData),size(self.xError))...
                && isequal(size(self.yData),size(self.yError))...
                && isequal(size(self.xData),size(self.yData));
        end
        
        function obj=preparePlot(self)
            %Trim Data and Validate Properties
            arguments
                self (1,1) LabPlot;
            end
            if validate(self)
                obj=self;
                [obj.xDataProcessed,obj.yDataProcessed,obj.xErrorProcessed,obj.yErrorProcessed]...
                    =trimData(obj.xData,obj.yData,obj.xError,obj.yError);
                [obj.xDataProcessed,obj.yDataProcessed]=prepareCurveData(obj.xDataProcessed,obj.yDataProcessed);
                [obj.xErrorProcessed,obj.yErrorProcessed]=prepareCurveData(obj.xErrorProcessed,obj.yErrorProcessed);
                [obj.xDataProcessed,obj.xErrorProcessed]=roundU(obj.xDataProcessed,obj.xErrorProcessed);
                [obj.yDataProcessed,obj.yErrorProcessed]=roundU(obj.yDataProcessed,obj.yErrorProcessed);
            else
                error('Dimension not match!');
            end
        end
        
        function obj=updatePlot(self)
            arguments
                self (1,1) LabPlot {validate(self)};
            end
            self=preparePlot(self);
            figure('Name','Lab Data Plot');
            errorbar(self.xDataProcessed,self.yDataProcessed,self.yErrorProcessed,self.yErrorProcessed,self.xErrorProcessed,self.xErrorProcessed,'LineStyle','None');
            hold on;
            if isempty(self.FitType)
                legend('Data Points with Error Bar','Interpreter','Latex');
            else
                [fitobj,goodness]=fit(self.xDataProcessed,self.yDataProcessed,self.FitType);
                coefficients=coeffvalues(fitobj);
                coefferror=diff(confint(fitobj,0.95))./2;
                [coefficients,coefferror]=roundU(coefficients,coefferror);
                plot(fitobj);
                legend('Data Points with Error Bar',['Fit Result ($R^2=',sprintf('%.3f',goodness.rsquare),'$)'],...
                    'Interpreter','Latex');
                if numel(coefficients)==numel(self.Coefficients)
                    if isempty(self.Model)
                        model=['$',latex(str2sym(formula(fitobj))),'$'];
                    else
                        model=self.Model;
                    end
                    comments=[{'Model:',model,...
                        'Coefficients:'},zeros(1,numel(coefficients))];
                    for i=1:numel(coefficients)
                        self.Coefficients(i).value=coefficients(i);
                        self.Coefficients(i).error=coefferror(i);
                        comments(i+3)={str(self.Coefficients(i))};
                    end
                else
                    error('Dimension of coefficients not match!');
                end
                annotation('textbox',[0.2 0.5 0.3 0.3],'String',comments,'FitBoxToText','on','Interpreter','Latex');
            end
            xlabel(self.xLabel,'Interpreter','Latex');
            ylabel(self.yLabel,'Interpreter','Latex');
            title(self.Title,'Interpreter','Latex');
            set(gcf,'units','pix','pos',[100,100,765,588]);
            hold off;
            obj=self;
        end
    end
end

