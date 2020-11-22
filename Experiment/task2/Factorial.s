# 程序最后加上一行空行
# data 段 存储全局变量(已初始化的全局变量和已初始化的静态变量)
    .data
    .align 4 # 令数据地址按 4 对齐
i:
    .long 2
    .size i, 4
    .align 4
f:
    .long 1
    .size f, 4
# bss 段 存储全局变量(未初始化的全局变量和未初始化的局部静态变量)
    .bss
# comm 声明未初始化的数据区域; zero 声明初始化的数据区域
# comm 用法
# .comm a,4
# .comm b,8

    .align 4
n:
    .zero 4

# 函数 fac
    .text
    .globl fac
    .type fac, @function
fac:
L1:
# while(i <= n)
    movl i, %eax
    cmpl %eax, 4(%esp)
# cmpl i, n   值 n - i
# jl-有符号小于则跳转; jge-有符号大于等于则跳转; jmp无条件跳转
# i <= n 跳转
    jge	L2
# return f;
    movl f, %eax
    jmp L3

L2:
# f = f * i;
    movl	f, %edx
    movl	i, %eax
    imull	%edx, %eax
    movl	%eax, f
# i = i + 1;
    movl	i, %eax
    addl	$1, %eax
    movl	%eax, i
# 返回到条件判断
    jmp L1

L3:
    ret


# rodata 段 存储常量
    .section .rodata
STR0:
    .string "%d"
STR1:
    .string "%d"
# 主函数
    .text
    .globl main
    .type main, @function
main:
# scanf("%d",&n);
    pushl $n # 从右向左压入参数
    pushl $STR0
    call scanf
    addl $8, %esp # 不再需要参数
# printf("%d", fac(n));
    movl n, %eax
    pushl %eax
    call fac
    addl $4, %esp
    pushl %eax
    pushl $STR1
    call printf
    addl $8, %esp
# return 0;
    movl $0, %eax
    ret
# 可执行堆栈段 不清楚具体含义的话建议保留
    .section .note.GNU-stack,"",@progbits
