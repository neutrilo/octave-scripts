clear
#Variables de entrada
n=21;      #número de nodos por dimension
A=1;       #parámetro A
rho=1;     #densidad
#-------------------------------------------------------------------------------
#Elija el ejercicio a mostrar
ejercicio=4;
if (ejercicio>4|ejercicio<1)
  display('ejercico debe ser un numero entre 1 y 4')
end

#-------------------------------------------------------------------------------
if ejercicio==1
display('Ejercicio 1')
  
  x0=-1;x1=0; #dominio en x
  y0=-1;y1=1; #dominio en y
  #Coordenadas y campo de velocidades
  X=linspace(x0,x1,n);
  Y=linspace(y0,y1,n)';
  v=@(r,A) -A*[r(1),-r(2)]; #Calcula el campo en un punto, importante para las lineas
                        #de corriente, 'x' y 'y' son puntos                    
  vx=-A*ones(n).*X;    #campo de velocidades en i
  vy=A*ones(n).*Y;     #campo de velocidades en j
  quiver(X,Y,vx,vy)
  axis([x0 x1 y0 y1]);
  xlabel ("X");
  ylabel ("Y");
  title ("Campo de velocidades con lineas de corriente");
  hold on
  nlcor=11;
  y0cor=linspace(y0,y1,nlcor);
  x0cor=x0;
  for i=1:nlcor
    r0=[x0cor,y0cor(i)];
    lcor=lsode(v,r0,linspace(0,3,100));
    if(r0(2)==0)
      plot(lcor(:,1),lcor(:,2),'r')
    else
      plot(lcor(:,1),lcor(:,2),'g')
    end
    
  endfor
  hold off
end
if ejercicio==2
  a=1;
  h=a/n;
  x0=-a;x1=0; #dominio en x
  y0=0;y1=a; #dominio en y
  #Coordenadas y campo de velocidades
  X=linspace(x0,x1,n);
  Y=linspace(y0,y1,n)';              
  vx=-A*ones(n).*X;    #campo de velocidades en i
  vy=A*ones(n).*Y;     #campo de velocidades en j
  circ=sum(vx(1,:))*h-sum(vx(end,:))*h-sum(vy(:,1))*h+sum(vy(:,end))*h;
      #Nota: No se utiliza ningún esquema formal para la integracion numerica porque 
      # la velocidad tangencial es constante a lo largo de cada arista. Si no lo fuese
      # esta sería una primera aproximacion.
  display('La circulación es igual a')
  display(circ)
  if (circ==0)
    display('La velocidad tangencial es igual para caras opuestas del cuadro')
    display('Debido a esto la circulación es nula')
     msgbox (['La circulación es igual a ', num2str(circ)])
     msgbox (['La velocidad tangencial es igual para caras opuestas del cuadro';'Debido a esto la circulación es nula'])
  end
  quiver(X,Y,vx,vy)
  axis([x0 x1 y0 y1]);
  xlabel ("X");
  ylabel ("Y");
  title (strcat("Campo de velocidades en la region (-a,0)x(0,a) con a=",num2str(a)));
end
if ejercicio==3
  n=3*(n-1)+1; #aumentamos el numero de nodos para optener una mejor gráfica
  a=1;
  x0=-a;x1=0; #dominio en x
  y0=-a;y1=a; #dominio en y
  X=linspace(x0,x1,n);
  Y=linspace(y0,y1,n)';              
  vx=-A*ones(n).*X;    #campo de velocidades en i
  vy=A*ones(n).*Y;     #campo de velocidades en j
  p=-A*A*rho*0.5.*(X.^2+Y.^2);
  figure 1
  surfc(X,Y,p)
  axis([x0 x1 y0 y1 min(min(p)) 0]);
  xlabel ("X");
  ylabel ("Y");
  zlabel ("Presion");
  title ('Presión en el área de estudio');
  vel=1; #cambial a 1 si se desea mostrar el campo de velocidades

  if vel==1
    msgbox(['El gradiente de presion curva las lineas de corriente, ';'esto se observa facilmente en la gráfica.'])
    display(['El gradiente de presion curva las lineas de corriente';'esto se observa facilmente en la gráfica'])
    figure 2
    contour(X,Y,p,'b')
    hold on
    #quiver(X,Y,vx,vy)
    axis([x0 x1 y0 y1]);
    xlabel ("X");
    ylabel ("Y");
    title ("Lineas de corriente (verde) curvadas por las isobaras (azul)");
      nlcor=11;
  y0cor=linspace(y0,y1,nlcor);
  x0cor=x0;
  v=@(r,A) -A*[r(1),-r(2)];
  for i=1:nlcor
    r0=[x0cor,y0cor(i)];
    lcor=lsode(v,r0,linspace(0,3,100));
    if(r0(2)==0)
      plot(lcor(:,1),lcor(:,2),'r')
    else
      plot(lcor(:,1),lcor(:,2),'g')
    end
    
  endfor
    
  end
  
end 
if ejercicio==4
  x0=-1;x1=0; #dominio en x
  y0=-1;y1=1; #dominio en y
  #Coordenadas y campo de velocidades
  X=linspace(x0,x1,n);
  Y=linspace(y0,y1,n)';
  v=@(r,A) -A*[r(1),-r(2)]; #Calcula el campo en un punto, importante para las lineas
                        #de corriente, 'x' y 'y' son puntos                    
  vx=-A*ones(n).*X;    #campo de velocidades en i
  vy=A*ones(n).*Y;     #campo de velocidades en j
  quiver(X,Y,vx,vy)
  axis([x0 x1 y0 y1]);
  xlabel ("X");
  ylabel ("Y");
  title (["Evolucion de las parcelas de fluido:";"rojo: t=0, verde: t=0.9, azul: t=2"]);
  hold on
  nlcor=6;
  y0cor=linspace(y0/4,y1/4,nlcor)';
  x0cor=linspace(x0,3*x0/4,nlcor);
  Y0=ones(nlcor).*y0cor;
  X0=ones(nlcor).*x0cor;
  vec1=zeros(nlcor*nlcor,2);
  vec2=zeros(nlcor*nlcor,2);
  vec3=zeros(nlcor*nlcor,2);
  pos=1;
  for i=1:nlcor
    for j=1:nlcor
      r0=[x0cor(i),y0cor(j)];
      lcor=lsode(v,r0,linspace(0,3,10));
      vec1(pos,:)=r0;
      vec2(pos,:)=lcor(4,:);
      vec3(pos,:)=lcor(6,:);
      pos=pos+1;
    end
  end
   plot(vec1(:,1)',vec1(:,2)','or')
   plot(vec2(:,1)',vec2(:,2)','og')
   plot(vec3(:,1)',vec3(:,2)','ob')

  analisis1=['las parcelas no rotan dado a que el campo es irrotacional,';
  'tan solo se desplaza.n y se deforman.'];
  analisis2=['Los puntos sobre una misma linea horizontal se mantienen sobre ella';
  'dado a que la velocidad vertical es constante sobre una linea horizontal'];
  analisis3=['Los puntos sobre una misma linea horizontal se acercan entre si';
  'dado que los puntos de la izquierda se mueven a la derecha más rápido de';
  'lo que lo hacen los de la derecha.'];
  analisis4=['Las lineas horizontales se alejan entre si porque la velocidad'; 
  'vertical del fluido toma signos distintos en torno a y=0, y porque aumenta ';
  ' de manera proporcional a la distancia a y=0, haciendo que la horizontales';
  'mas alejadas de y=0 sigan alejandose y más rapido que la horizontales más';
  'cercanas a y=0.'];
  msgbox(analisis1)
  msgbox(analisis2)
  msgbox(analisis3)
  msgbox(analisis4)
end


