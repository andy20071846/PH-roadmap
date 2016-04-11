function [ output_args ] = klein_bottle_emb( N )

% With this function you can sample N^2 points from the image
% of the embedding of the Klein bottle in R^4
% Input: N
% Output: plot, .mat file with points and txt file with one point
% per line
% Nina Otter, Oxford September 2015

%If no input value is provided compute point cloud of size 100
if nargin < 1
   N = 10;
end

%Parameters
r=3;
a=0;
b=2*pi;
c=2;

%Sample N points uniformly at random from (0,2pi)^2
u = (b-a).*rand(N,1) + a;
v = (b-a).*rand(N,1) + a;

%Alternatively, sample points linearly 
%u=linspace(0,2*pi,N);
%v=linspace(0,2*pi,N);

[u,v]=meshgrid(u,v);

%Parametric equations for embedding
x=(r*cos(u)+c).*cos(v);
y=(r*cos(u)+c).*sin(v);
z=r*sin(u)*cos(v/2);
t=r*sin(u)*sin(v/2);

%Point cloud
points=[x(:),y(:),z(:),t(:)];

%Save point cloud to .mat file
savefilename=['klein_bottle_emb',num2str(N^2),'.mat'];
save(savefilename,'points', 'N' );

%Save point cloud to .txt file
output_file_name=['klein_bottle_pointcloud_emb',num2str(N^2), '.txt'];
fileID=fopen(output_file_name,'w');
n=length(x(:));
for i=1:n
output_line=sprintf('%4.8f ', points(i,:));
fprintf(fileID,'%s\n',output_line);
end
fclose(fileID);

end

