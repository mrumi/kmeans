function [assignment,centroid,itr] = kmeans(data,nCluster,meanPoints)
  #randomize datapoint
  #data=data(randperm(size(data,1)),:);
  
  nRow=size(data,1);
  nCol=size(data,2);
  
  assignment = zeros(nRow,1); 
  
  pos_diff=1.0;
  itr=0;
  while abs(pos_diff) > 0
    % assign each datapoint to the closest centroid    
    for d=1:nRow
      distCenter=[];
      for c=1:nCluster       
        diff=distance(data(d,:),meanPoints( c,:)); 
        distCenter(end+1)=diff;
      end        
      cluster=find(distCenter==min(distCenter));            
      assignment(d)=cluster(1);      
    end    
    
    oldPositions = meanPoints;     
    % recalculate the positions of the centers    
    for c=1:nCluster
      pos=find(assignment==c);      
      clusteredData=data(pos,:);
      #m=mean(clusteredData);
      %clusteredData=sort(clusteredData);            
      if(isempty(clusteredData)==0)
        meanPoints(c,:)= mean(clusteredData,1);        
      end
%      mid =  ceil((length(clusteredData))/2);
%      if mid!=0
%        meanPoints(c,:) = clusteredData(mid,:);      
%      end
      %mean(clusteredData); 
    end            
    itr=itr+1;
    
    pos_diff=sum(sum((meanPoints .- oldPositions)));    
  end
  centroid=meanPoints;
  
end

function dist = distance(x1,x2)
  
  dist=sqrt(sum((x1-x2).^2));
end
