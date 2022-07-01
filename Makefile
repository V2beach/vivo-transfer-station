ifndef CXX
	CXX = g++
endif

CXXFLAGS=-pipe \
	-Wall \
	-fPIC \
	-std=c++11 \
	-fno-omit-frame-pointer \
	-fpermissive \
	-O3 \
	-ffast-math \
	-pthread

INCPATH=$(addprefix -I, $(shell find . -type d))

# 可以学familia用libfamilia.a编译familia.so
LDFLAGS_SO = -L./build/ -ltopicmodel

.PHONY: all
all: build/ltopicmodel.so

LDA_OBJS = $(addprefix build/, $(shell find lda/ -type f -name '*.cpp))
MARISA_OBJS = $(addprefix build/, $(shell find marisa/ -type f -name '*.cc))

build/ltopicmodel.so: build/native-lib.o $(LDA_OBJS) $(MARISA_OBJS) build/marisa/marisa_wrapper.o
	$(CXX) $(INCPATH) $CXXFLAGS) -shared $(filter %.o, $?) -o $@

build/native-lib.o: native-lib.cpp
	@mkdir -p $(@D)
	$(CXX) $(INCPATH) $(CXXFLAGS) -MM -MT build/native-lib.o $< >build/native-lib.d
	$(CXX) $(INCPATH) $(CXXFLAGS) -c $< -o $@

build/lda/%.o: lda/%.cpp
	$(CXX) $(INCPATH) $(CXXFLAGS) -MM -MT build/$*.o $< >build/$*.d
	$(CXX) $(INCPATH) $(CXXFLAGS) -c $< -o $@

build/marisa/%.o: marisa/%.cc
	$(CXX) $(INCPATH) $(CXXFLAGS) -MM -MT build/$*.o $< >build/$*.d
	$(CXX) $(INCPATH) $(CXXFLAGS) -c $< -o $@

build/marisa/marisa_wrapper.o: marisa/marisa_wrapper.cpp
	$(CXX) $(INCPATH) $(CXXFLAGS) -MM -MT build/marisa/marisa_wrapper.o $< >build/marisa/marisa_wrapper.d
	$(CXX) $(INCPATH) $(CXXFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf build

-include $(wildcard */*/*.d */*.d *.d)

# 失败尝试
# SRCS = $(filter-out %.class $(shell find . -type f -name '*.c*'))
# BASE = $(basename $(SRCS))
# OBJS = $(patsubst build/%.o, %, $(BASE))

# SRCS = $(filter-out %.class $(shell find . -type f -name '*.c*'))
# NODIR = $(notdir $(SRCS))
# STEM = $(basename $(NODIR))
# OBJS = $(patsubst build/%.o, %, $(STEM))

# OBJS = $(addprefix build/, vose_alias.o inference_engine.o model.o vocab.o document.o sampler.o util.o tokenizer.o)
