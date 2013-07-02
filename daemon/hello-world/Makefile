#Prject Info
TARGET  = hello-world 
INC_DIR += 
LIB_DIR += 
SRC_DIR = .
OUT_DIR = daemon
LIB     += -lpthread 

#Makefile Template For Application
TARGET  := $(strip $(TARGET))
CROSS	= $(RASPI_CROSS_PREFIX)
CC      = $(CROSS)gcc
CXX     = $(CROSS)g++
CPP     = $(CROSS)cpp
CFLAGS  += $(C_INC)
CXXFLAGS+= $(C_INC)

C_INC   = $(INC_DIR:%=-I%) $(INC)
C_LIB   = $(LIB_DIR:%=-L%) $(LIB)

C_SRC   = $(wildcard $(SRC_DIR:%=%/*.c))
CXX_SRC = $(wildcard $(SRC_DIR:%=%/*.cpp))
C_OBJ   = $(C_SRC:%.c=%.o)
CXX_OBJ = $(CXX_SRC:%.cpp=%.o)
C_DEP   = $(C_SRC:%.c=%.d)
CXX_DEP = $(CXX_SRC:%.cpp=%.d)

ALL_OBJ = $(C_OBJ) $(CXX_OBJ)
ALL_DEP = $(C_DEP) $(CXX_DEP)

ifeq ($(debug), 1)
CFLAGS   += -g -DLOCAL_DEBUG
CXXFLAGS += -g -DLOCAL_DEBUG
endif


.PHONY: all clean

all: $(TARGET)

clean:
	rm -f $(ALL_OBJ) $(ALL_DEP) $(TARGET) 

$(C_DEP): %.d : %.c
	$(CPP) $(C_INC) -MM $< > $@

$(CXX_DEP): %.d : %.cpp
	$(CPP) $(C_INC) -MM $< > $@


ifneq ($(MAKECMDGOALS), clean)
-include $(ALL_DEP)
endif

$(TARGET): $(ALL_DEP) $(ALL_OBJ)
	$(CXX) $(ALL_OBJ) $(C_LIB) $(LDFLAGS) -o $@

cp: $(TARGET)
	cp $(TARGET) $(OUT_DIR)

scp: $(TARGET)
	scp -P$(RASPI_DEV_SSH_PORT) $(TARGET) $(RASPI_DEV_USER)@$(RASPI_DEV_ADDRESS):$(RASPI_DEV_APP_BASE)/$(OUT_DIR)/
