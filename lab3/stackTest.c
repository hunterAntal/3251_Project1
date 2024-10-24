#include <stdio.h>

#define StackSize 100

typedef struct {
    int top;
    int data[StackSize];
} Stack;

void push(Stack *s, int value){
    if(s->top < StackSize){
        s->data[s->top] = value;
        s->top++;
    }else{
        printf("Stack is full\n");
    }
}

int pop(Stack *s){
    if(s->top >=0){
        return s->data[s->top--];
    }
    else {
        printf("Stack Empty\n");
        return -1;
    }
}

int top(Stack *s){
    if(s->top >=0){
        return s->data[s->top];
    }
    else {
        printf("Stack Empty\n");
        return -1;
    }
}





int main(void){
    printf("This is a test to learn stack again\n");

    Stack s;
    printf("Adding 2 to the stack\n");
    push(&s, 2);
    printf("The top now is %d\n", s.top);
    pop(&s);
    printf("Pop\n");
    printf("The top now is %d\n", s.top);
    pop(&s);
    pop(&s);





    return 0;
}