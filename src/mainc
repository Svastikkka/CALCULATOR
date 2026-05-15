#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <stdlib.h>
// Define epsilon
#define EPS 1e-9


int stack_values_capacity=10;
int stack_operators_capacity=10;
int stack_input_capacity=10;


double *stack_values;
int stack_values_position=-1;
char *stack_operators;
int stack_operators_position=-1;

void push_stack_value(double value) {
    if (stack_values_position >= stack_values_capacity - 1) {
        printf("Resizing stack...\n");
        stack_values_capacity *= 2;
        double *temp = realloc(stack_values,stack_values_capacity * sizeof * stack_values);
        if (!temp){
            printf("Realloc failed\n");
            free(stack_values);
            exit(1);
        }
        stack_values=temp;
    }
    stack_values[++stack_values_position]=value;
}

void push_stack_operator(char value) {
    if (stack_operators_position >= stack_operators_capacity - 1) {
        printf("Resizing stack...\n");
        stack_operators_capacity *= 2;
        char *temp = realloc(stack_operators, stack_operators_capacity * sizeof * stack_operators);
        if (!temp){
            printf("Realloc failed\n");
            free(stack_operators);
            exit(1);
        }
        stack_operators=temp;
    }
    stack_operators[++stack_operators_position]=value;
}

double pop_stack_value() {
    if (stack_values_position < 0) {
        printf("Stack underflow\n");
        exit(1);
    }
    return stack_values[stack_values_position--];
}

char pop_stack_operator() {
    if (stack_operators_position < 0) {
        printf("Stack underflow\n");
        exit(1);
    }
    return stack_operators[stack_operators_position--];
}

double applyOperation(double v1, double v2, char op) {
    switch (op)
    {
    case '+':
        return v1+v2;
    case '-':
        return v1-v2;
    case '*':
        return v1*v2;
    case '/':
        if(fabs(v2) < EPS){
            printf("DIVIDE BY ZERO\n");
            return 0;
        }
        return v1/v2;
    default:
        break;
    }
    return 0;
}
int precedence(char op) {
    if (op=='+' || op=='-'){return 1;}
    if (op=='*' || op=='/'){return 2;}
    return 0;
}

double calculate(char *expression) {
    stack_values_position = -1;
    stack_operators_position = -1;
    int i=0;
    while(expression[i]){
        if(expression[i]==' '){
            i++;
            continue;
        }
        // If char is digit
        // Restricting to digit only for now
        if((expression[i] >= '0' && expression[i] <= '9')) {
            double value=0;
            while((expression[i] >= '0' && expression[i] <= '9')) {
                value=value*10+(expression[i]-'0');
                i++;
            }
            push_stack_value(value);
            continue;
        }
        // 1+(1+1) => 1+2 => 3
        // precedence
        if (expression[i]=='(') {
            push_stack_operator(expression[i]);
        } else if(expression[i]==')') {
            while (stack_operators_position >= 0 && stack_operators[stack_operators_position]!='('){
                double v2= pop_stack_value();
                double v1=pop_stack_value();
                char op=pop_stack_operator();
                push_stack_value(applyOperation(v1,v2,op));
            }
            // pop ( operator
            pop_stack_operator();
        } else if (expression[i]=='+' || expression[i]=='-' || expression[i]=='*' || expression[i]=='/') {
            while (stack_operators_position>=0 && 
                precedence(stack_operators[stack_operators_position])>=precedence(expression[i])){
                double v2 = pop_stack_value();
                double v1 = pop_stack_value();
                char op = pop_stack_operator();
                push_stack_value(applyOperation(v1,v2,op));
            }
            push_stack_operator(expression[i]);
        }else {
            printf("Invalid character: %c\n", expression[i]);
            exit(1);
        }
        i++;
    }

    while (stack_operators_position>=0) {
        double v2 = pop_stack_value();
        double v1 = pop_stack_value();
        char op = pop_stack_operator();
        push_stack_value(applyOperation(v1,v2,op));
    }

    return pop_stack_value();
}

char *readline(){
    int ch;
    int length=0;
    char *buffer = malloc(stack_input_capacity);
    if (!buffer) {
        printf("Memory allocation failed\n");
        exit(1);
    }
    while ((ch = getchar()) != '\n' && ch != EOF){
        if (length>= stack_input_capacity-1){
            stack_input_capacity*=2;
            char *temp = realloc(buffer, stack_input_capacity);
            if (!temp) {
                printf("Realloc failed\n");
                free(buffer);
                exit(1);
            }
            buffer = temp;
        }
        buffer[length++]=ch;
    }
    buffer[length] = '\0';
    return buffer;
}

int main(){
    stack_values = malloc(stack_values_capacity * sizeof(double));
    stack_operators = malloc(stack_operators_capacity * sizeof(char));
    if (!stack_values || !stack_operators) {
        printf("Memory allocation failed\n");
        return -1;
    }

    printf("SVASTIKKKA CALCULATOR\n");
    printf("ENTER THE EXPRESSION: ");

    char *expression = readline();
    printf("ANS: %f",calculate(expression));

    free(stack_values);
    free(stack_operators);
    free(expression);

    return 0;
}
