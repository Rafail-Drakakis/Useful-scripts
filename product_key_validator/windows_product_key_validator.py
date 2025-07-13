import subprocess

def check_product_key(product_key):
    """
    The function `check_product_key` checks the license status of a product key using the `slmgr`
    command in Windows.
    
    :param product_key: The product_key parameter is a string that represents the product key for a
    software license
    :return: a boolean value indicating whether the license status of the product key is "Licensed" or
    not.
    """
    command = f'slmgr /dli {product_key}'
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    output = result.stdout.decode('utf-8')
    return 'License Status: Licensed' in output

def read_product_keys_from_file(filename):
    """
    The function reads product keys from a file and returns them as a list.
    
    :param filename: The filename parameter is a string that represents the name of the file from which
    we want to read the product keys
    :return: a list of product keys read from the file.
    """
    with open(filename, 'r') as file:
        return [line for line in file]

if __name__ == "__main__":
    product_keys = read_product_keys_from_file("C:\\Users\\Rafail\\Downloads\\keys.txt")    
    
    valid_keys = []
    invalid_keys = []
    
    for key in product_keys:
        is_valid = check_product_key(key)
        if is_valid:
            valid_keys.append(key)
        else:
            invalid_keys.append(key)

    with open("valid.txt", "w") as valid_file:
        valid_file.write("\n".join(valid_keys))

    with open("invalid.txt", "w") as invalid_file:
        invalid_file.write("\n".join(invalid_keys))

    print("Validation completed. Valid keys are saved in valid.txt, and invalid keys are saved in invalid.txt.")