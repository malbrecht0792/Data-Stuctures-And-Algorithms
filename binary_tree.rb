class Node

	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

end

class Tree

	attr_accessor :root

	def initialize(array)
		build_tree(array)
	end

	def build_tree(array)
		array.each_with_index do |value, index|
			if index == 0
				@root = Node.new(value)
				@current_node = @root
			else
				@current_node = @root
				find_location_and_create_node(value)		
			end
		end
	end

	def find_location_and_create_node(value)
		if value < @current_node.value
			#Check if the current node has a left child
			if left_child_nil(@current_node)
				set_left_child(@current_node, value)
			else
				#Traverse down the left side of the node
				#Reset current node
				@current_node = @current_node.left_child
				find_location_and_create_node(value)
			end
		elsif value > @current_node.value
			#Check if the current node has a right child
			if right_child_nil(@current_node)
				set_right_child(@current_node, value)
			else
				#Traverse down the right side of the node
				#Reset current node
				@current_node = @current_node.right_child
				find_location_and_create_node(value)
			end
		end
	end

	def left_child_nil(node)
		node.left_child.nil?
	end

	def right_child_nil(node)
		node.right_child.nil?
	end

	def set_left_child(parent, value)
		parent.left_child = Node.new(value, parent)
	end

	def set_right_child(parent, value)
		parent.right_child = Node.new(value, parent)
	end
end

my_tree = Tree.new([8,3,10,13,1,7,4,14])

puts "Root: #{my_tree.root.value}"
puts "Root.left_child: #{my_tree.root.left_child.value}"
puts "Root.left_child.left_child: #{my_tree.root.left_child.left_child.value}"
puts "Root.left_child.right_child: #{my_tree.root.left_child.right_child.value}"
puts "Root.left_child.right_child.left_child: #{my_tree.root.left_child.right_child.left_child.value}"
puts "Root.right_child: #{my_tree.root.right_child.value}"
puts "Root.right_child.right_child: #{my_tree.root.right_child.right_child.value}"
puts "Root.right_child.right_child.right_child: #{my_tree.root.right_child.right_child.right_child.value}"




