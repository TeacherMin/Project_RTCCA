TSCCA_rank1 = function(Tensor, ku, kv, kw, Init_flag=1, niter=50, seed0=1, err=0.0001){
  # Tensor sparse CCA (TSCCA)
  # Input
  # Tensor: An array in R can have three dimensions
  # Tensor[,,i] = crossprod(X^i, Y^i)
  # X^i \in R^{n_i \times p} (n_i:samples, p:variables), i = 1, ..., M
  # Y^i \in R^{n_i \times q} (n_i:samples, q:variables), i = 1, ..., M
  # Extrate J TSCCA sparse factors
  ptm = proc.time()
  
  # Initialize_TSCCA
  DIM = dim(Tensor)
  set.seed(seed0)
  u0 = matrix(rnorm(DIM[1]),ncol=1);u0 = u0/norm(u0,'E')
  v0 = matrix(rnorm(DIM[2]),ncol=1);v0 = v0/norm(v0,'E')
  w0 = matrix(rnorm(DIM[3]),ncol=1);w0 = w0/norm(w0,'E')
  
  u = u0; v = v0;w = w0
  
  temp_d = c()
  # Iterative algorithm
  for (i in 1:niter){
    XTY = compute.C(Tensor, w, DIM[3])
    
    z.u = XTY%*%v
    u = TSCCA.project(z.u, ku)
    
    z.v = crossprod(XTY,u)
    v = TSCCA.project(z.v, kv) 
    
    z.w = compute.zw(Tensor, u, v, DIM[3])
    w = TSCCA.project(z.w, kw)
    
    temp_d = c(temp_d, t(w)%*%z.w) 
    
    # Algorithm termination condition
    if ((norm(u - u0,'E')<= err)&(norm(v - v0,'E')<= err)&(norm(w - w0,'E')<= err)){break}
    else {
      u0=u; v0=v; w0=w}
  }
  tim = proc.time() - ptm
  modularity = mean(abs(Tensor[which(u!=0), which(v!=0), which(w!=0)]))
  
  return (list(u=u, v=v, w=w, d_iter=temp_d, d=temp_d[i], modularity=modularity, time=tim[1]))
}

# Compute matrix C
compute.C = function(Tensor, w, dim){
  C = w[1]*Tensor[,,1]
  for(i in 2:dim){
    C = C + w[i]*Tensor[,,i]
  }
  return(C)
}

# Compute vector zw
compute.zw = function(Tensor, u, v, dim){
  zw = matrix(0, nrow=dim, ncol=1)
  for(i in 1:dim){
    zw[i] = t(u)%*%Tensor[,,i]%*%v
  }
  return(zw)
}

# Sparse project function
TSCCA.project = function(z, k){
  if(sum(z^2)==0) return(z)  
  u = abs(z);
  u[-order(u,decreasing=T)[1:k]] = 0
  u = u/sqrt(sum(u^2))
  u = sign(z)*u
  return(u) 
}