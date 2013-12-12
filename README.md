trialist.nof1.dpu
=================

A JAGS based DPU

# Usage in R

    #install
    library(devtools)
    install_github("trialist.nof1.dpu", "openmhealth")

    #use
    nof1=wrap.norm(
      Pain=c(22, 18, 21,16, 22, 15, 23, 14), 
      Fatigue=c(7,4,9,3,7,4,8,3), 
      Drowsy=c(5,5,5,4,5,5,4,5), 
      Sleep=c(4,2,4,1,4,1,4,1), 
      Thinking=c(5,2,6,1,8,4,7,6), 
      Constipation=c(10,7,10,6,9,5,10,3),
      Treat=c(0,1,0,1,0,1,0,1), 
      conv.limit=1.05, 
      niters=10000, 
      setsize=1000, 
      alphaprior = list("norm",0,1e-6),
      betaprior = list("norm",0,1e-6),
      varprior=list("sd","unif"),
      varprior.params=c(0,5)
    )

# DPU in OpenCPU

    curl https://public.opencpu.org/ocpu/github/openmhealth/trialist.nof1.dpu/R/wrap.norm/json \
    -H 'Content-Type: application/json' \
    -d '{"Pain":[22, 18, 21,16, 22, 15, 23, 14],"Fatigue":[7,4,9,3,7,4,8,3], "Drowsy":[5,5,5,4,5,5,4,5], "Sleep":[4,2,4,1,4,1,4,1], "Thinking" : [5,2,6,1,8,4,7,6], "Constipation":[10,7,10,6,9,5,10,3], "Treat": [0,1,0,1,0,1,0,1], "conv.limit": 1.05, "niters":10000, "setsize":1000, "alphaprior":["norm",0, 1e-6], "betaprior": ["norm", 0, 1e-6], "varprior" : ["sd", "unif"], "varprior.params":[0,5]}'
       
# Alternative DPU wrapper

The `wrap.norm2' function is an alternative wrapper to the same functionality. It uses data records for input and output which is somewhat more conventional JSON.

    curl https://public.opencpu.org/ocpu/github/openmhealth/trialist.nof1.dpu/R/wrap.norm2/json \
    -H 'Content-Type: application/json' \
    -d '{"observations":[{"Pain":22,"Fatigue":7,"Drowsy":5,"Sleep":4,"Thinking":5,"Constipation":10,"Treat":0},{"Pain":18,"Fatigue":4,"Drowsy":5,"Sleep":2,"Thinking":2,"Constipation":7,"Treat":1},{"Pain":21,"Fatigue":9,"Drowsy":5,"Sleep":4,"Thinking":6,"Constipation":10,"Treat":0},{"Pain":16,"Fatigue":3,"Drowsy":4,"Sleep":1,"Thinking":1,"Constipation":6,"Treat":1},{"Pain":22,"Fatigue":7,"Drowsy":5,"Sleep":4,"Thinking":8,"Constipation":9,"Treat":0},{"Pain":15,"Fatigue":4,"Drowsy":5,"Sleep":1,"Thinking":4,"Constipation":5,"Treat":1},{"Pain":23,"Fatigue":8,"Drowsy":4,"Sleep":4,"Thinking":7,"Constipation":10,"Treat":0},{"Pain":14,"Fatigue":3,"Drowsy":5,"Sleep":1,"Thinking":6,"Constipation":3,"Treat":1}], "conv.limit": 1.05, "niters":10000, "setsize":1000, "alphaprior":["norm",0, 1e-6], "betaprior": ["norm", 0, 1e-6], "varprior" : ["sd", "unif"], "varprior.params":[0,5]}'
