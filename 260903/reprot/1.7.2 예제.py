def digit_value(digit):
    if "0" <= digit <= "9":
        return ord(digit) - ord("0")
    elif "A" <= digit <= "F":
        return ord(digit) - ord("A") + 10
    else:  # a~f
        return ord(digit) - ord("a") + 10


# 1
def binary_to_integer(binary):
    result = 0

    for digit in binary:
        result = result * 2

        if digit == "1":
            result += 1

    return result


# 2
def hexadecimal_to_integer(hexadecimal):
    result = 0

    for digit in hexadecimal:
        result = result * 16 + digit_value(digit)

    return result


# 3
def integer_to_binary(number):
    if number == 0:
        return "0"

    digits = "01"
    result = ""

    while number > 0:
        remainder = number % 2
        result = digits[remainder] + result
        number = number // 2

    return result


# 4
def integer_to_hexadecimal(number):
    if number == 0:
        return "0"

    digits = "0123456789ABCDEF"
    result = ""

    while number > 0:
        remainder = number % 16
        result = digits[remainder] + result
        number = number // 16

    return result


# 5
def add_base(first, second, base):
    digits = "0123456789ABCDEF"
    i = len(first) - 1
    j = len(second) - 1
    carry = 0
    result = ""

    while i >= 0 or j >= 0 or carry > 0:
        total = carry

        if i >= 0:
            total += digit_value(first[i])
            i -= 1

        if j >= 0:
            total += digit_value(second[j])
            j -= 1

        result = digits[total % base] + result
        carry = total // base

   
    start = 0
    while start < len(result) - 1 and result[start] == "0":
        start += 1

    return result[start:]


# 6
def add_hexadecimal(first, second):
    return add_base(first, second, 16)


# 7
def multiply_hexadecimal(digit, hexadecimal):
    digits = "0123456789ABCDEF"
    multiplier = digit_value(digit)
    carry = 0
    result = ""

    for i in range(len(hexadecimal) - 1, -1, -1):
        product = digit_value(hexadecimal[i]) * multiplier + carry

        result = digits[product % 16] + result
        carry = product // 16

    while carry > 0:
        result = digits[carry % 16] + result
        carry = carry // 16

 
    start = 0
    while start < len(result) - 1 and result[start] == "0":
        start += 1

    return result[start:]


# 실행 예시
if __name__ == "__main__":
    print("1번:", binary_to_integer("0000000000110101"))
    print("2번:", hexadecimal_to_integer("000000FF"))
    print("3번:", integer_to_binary(53))
    print("4번:", integer_to_hexadecimal(255))
    print("5번:", add_base("1011", "1101", 2))
    print("6번:", add_hexadecimal("FF", "1"))
    print("7번:", multiply_hexadecimal("A", "FF"))

    # 9
def subtract_binary(first, second):
    i = len(first) - 1
    j = len(second) - 1
    borrow = 0
    result = ""

    while i >= 0 or j >= 0:
        a = ord(first[i]) - ord("0") if i >= 0 else 0
        b = ord(second[j]) - ord("0") if j >= 0 else 0

        difference = a - b - borrow

        if difference < 0:
            difference += 2  
            borrow = 1
        else:
            borrow = 0

        result = "01"[difference] + result

        i -= 1
        j -= 1

    return result


print("9번:")
print("10001000 - 00000101 =", subtract_binary("10001000", "00000101"))
print("00001101 - 00000111 =", subtract_binary("00001101", "00000111"))
print("00110010 - 00010101 =", subtract_binary("00110010", "00010101"))