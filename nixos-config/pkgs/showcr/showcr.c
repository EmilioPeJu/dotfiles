#include <linux/module.h>
#include <linux/smp.h>

static int __init showcr_init(void)
{
    int cpu = get_cpu();
    unsigned long cr0, cr2, cr3, cr4, cr8;
    asm volatile(
        "movq %%cr0, %0\n"
        "movq %%cr2, %1\n"
        "movq %%cr3, %2\n"
        "movq %%cr4, %3\n"
        "movq %%cr8, %4\n"
        : "=r" (cr0), "=r" (cr2), "=r" (cr3), "=r" (cr4), "=r" (cr8)
    );
    pr_info("Init showcr for cpu %d\n", cpu);
    pr_info("CR0: 0x%lx\n", cr0);
    pr_info("CR2: 0x%lx\n", cr2);
    pr_info("CR3: 0x%lx\n", cr3);
    pr_info("CR4: 0x%lx\n", cr4);
    pr_info("CR8: 0x%lx\n", cr8);
    put_cpu();
    return -EIO;
}

module_init(showcr_init);

MODULE_LICENSE("Dual BSD/GPL");
