


class Node:
    def __init__(self, val=0):
        self.val = val
        self.right = None
        self.left = None
    def __repr__(self):
        return "val: %r" % self.val
def inorder(k):
    if k == None:
        return
    
    inorder(k.left)
    print(k)
    inorder(k.right)
    
mn = Node(1)
mn.left = Node(2)
mn.right = Node(3)
mn.left.left = Node(4)
mn.left.right =Node(5)
mn.left.right.left = Node(8)
mn.right.left=Node(6)
mn.right.left.left=Node(9)
mn.right.left.right=Node(10)
mn.right.right=Node(7)

inorder(mn)


