# [re -- Regular expression operations](https://docs.python.org/3/library/re.html#regular-expression-syntax%22RE%20syntax)
Some groups of different regular expressions that exist and can be used and are useful below this line (at the bottom a Python script as example of how using them with this language):

- Character classes
  | Character classes | Details |
  | -- | -- |
  | .	| any character except newline |
  | \w\d\s	 | word, digit, whitespace |
  | \W\D\S	 | not word, digit, whitespace |
  | [abc]	 | any of a, b, or c |
  | [^abc]	 | not a, b, or c |
  | [a-g]	 | character between a & g |

- Anchors
  | Anchors | Details | 
  | :--- | :--- |
  | ^abc$	 | start / end of the string |
  | \b\B	 | word, not-word boundary |
  | Escaped  | characters |
  | \.\*\\	 | escaped special characters |
  | \t\n\r	 | tab, linefeed, carriage return |

- Groups & Lookaround
  | Groups & Lookaround | Details | 
  | :--- | :--- |
  | (abc)	 | capture group |
  | \1	 | backreference to group #1 |
  | (?:abc)	 | non-capturing group |
  | (?=abc)	 | positive lookahead |
  | (?!abc)	 | negative lookahead |

- Quantifiers & Alternation
  | Quantifiers & Alternation | Details | 
  | :--- | :--- |
  | a*a+a?	 | 0 or more, 1 or more, 0 or 1 |
  | a{5}a{2,}	 | exactly five, two or more |
  | a{1,3}	 | between one & three |
  | a+?a{2,}?	 | match as few as possible |
  | ab\|cd	 | match ab or cd |




  
- Example im Python:
  ```
  import re
  
  def checking_email(my_pattern, my_line):
      if not re.match(my_pattern, my_line):
          print(f"Bad email format on line: {my_line}")
      else:
          print(f"Good email format for: {my_line}")
          
  
  def main():    
      email_file = open("/home/pakete/vagrant/dellbridge/email_list.txt", "r")
  
      #re_pattern = "^[a-zA-Z0-9].*?@[a-zA-Z0-9-]*\.[com|org]"
      #mail_pattern = re.compile(re_pattern)
      mail_pattern = re.compile('^[a-zA-Z0-9._-]*?@[a-zA-Z0-9.-]*?\.[com|org]')
  
      for line in email_file:
              checking_email(mail_pattern,line)
      
      email_file.close()
      
  if __name__ == "__main__":
      main()
  ```
