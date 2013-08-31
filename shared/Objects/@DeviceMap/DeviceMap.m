

classdef DeviceMap
   properties
       lineCollection;
       digitalLinesCount;
       analogLinesCount;
   end
   methods
       function obj = DeviceMap
          obj.lineCollection = java.util.HashMap;
          obj.digitalLinesCount = 0;
          obj.analogLinesCount = 0;
       end
       function obj = set.lineCollection(obj,value)
          obj.lineCollection = value; 
       end
       
       function value = get.lineCollection(obj)
          value = obj.lineCollection; 
       end

       function obj = set.digitalLinesCount(obj,value)
          obj.digitalLinesCount = value; 
       end
       
       function value = get.digitalLinesCount(obj)
          value = obj.digitalLinesCount; 
       end

       function obj = set.analogLinesCount(obj,value)
          obj.analogLinesCount = value; 
       end
       
       function value = get.analogLinesCount(obj)
          value = obj.analogLinesCount; 
       end

       
       function obj = removeLine(obj,index)
           removedLine = obj.lineCollection.remove(index);
           if(size(removedLine) == 3)
               obj.digitalLinesCount = obj.digitalLinesCount - 1;
           elseif(size(removedLine) == 5)
               obj.analogLinesCount = obj.analogLinesCount - 1;
           end
       end
       
       function obj = addLine(obj,line)
           if(obj.lineCollection.containsKey(line.lineIndex) == 1)
               display('Cannot add line, line index must be unique');
           else
               if(isa(line,'DigitalLine') == true)
                  obj.digitalLinesCount = obj.digitalLinesCount + 1; 
               elseif(isa(line,'AnalogLine') == true)
                  obj.analogLinesCount = obj.analogLinesCount + 1;  
               end
               
               obj.lineCollection.put(line.lineIndex,Java(line)); 
           end
       end
     
       
       function ret = getAllLines(obj)
          vals = obj.lineCollection.values;
          vals = vals.toArray();
          
          ret = cell(1,size(vals,1));
          
          %Need to sort by lineName so that indexing is correct.
          for p = 1:size(vals,1)
            for i = 1:size(vals,1)
               if(size(vals(i))==3)
                   if(p == vals(i).get(1)) 
                        ret(p) = {DigitalLine(vals(i))};
                   end
               else
                   if(p == vals(i).get(1)) 
                        ret(p + obj.digitalLinesCount) = {AnalogLine(vals(i))};
                   end                   
               end
            end
          end
       end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
   end
end