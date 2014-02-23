TARGET   = argv
AS       = armv6j-hardfloat-linux-gnueabi-as
LD       = armv6j-hardfloat-linux-gnueabi-ld
ASFLAGS  =
LDLAGS   = 

SOURCES  := main.s
HEADERS  := 
OBJECTS  := $(SOURCES:%.s=%.o)

EMU		 = qemu-arm
EMUFLAGS = -L /usr/armv6j-hardfloat-linux-gnueabi/
EMUDB    = -g 9000

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) -o $@ $(LDLAGS) $(OBJECTS)

$(OBJECTS): %.o : %.s $(HEADERS)
	$(AS) $(ASFLAGS) -c $< -o $@

.PHONEY: clean
clean:
	$(RM) $(OBJECTS) $(TARGET)

.PHONEY: run
run: $(TARGET)
	$(EMU) $(EMUFLAGS) $(TARGET)

.PHONEY: debug
debug: $(TARGET)
	$(EMU) $(EMUFLAGS) $(EMUDB) $(TARGET)
