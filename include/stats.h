
#define NSTEP   6500
extern struct stats
{
        int len;
        long cmp, jump;
        long slow;
        long extra, extra2, extra3;
        /* permuted here to safer place, if NSTEP is too small*/
        long step[NSTEP];
} stats;
