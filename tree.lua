function insertOnTree(tree, value)
    if tree.value then
        if value > tree.value then 
            tree.insert(tree.right, value)
        else
            tree.insert(tree.left, value)
        end
    else
        tree.value = valor 
        tree.right = {}
        tree.left = {}
    end
end
