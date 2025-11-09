void kmain(void)
{

    /* infinte kernel cycle */
    for (;;)
    {
        asm volatile("hlt");
    }
}