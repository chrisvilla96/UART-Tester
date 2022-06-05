#define MAX_ALARMS 10
#define ALARM_BYTE_LENGTH  3

#define ALARM_FLAG_BYTE 0
#define ALARM_HOUR_BYTE 1
#define ALARM_MINUTE_BYTE 2

#define ALARM_FLAG_DISPENSER_0 0x02
#define ALARM_FLAG_DISPENSER_1 0x04
#define ALARM_FLAG_DISPENSER_2 0x08
#define ALARM_FLAG_ALL_DISPENSERS (\
    ALARM_FLAG_DISPENSER_2 \
    | ALARM_FLAG_DISPENSER_1 \
    | ALARM_FLAG_DISPENSER_0 \
)
#define ALARM_FLAG_ACTIVE 0x01  