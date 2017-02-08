class Knight

	def initialize

	end

	def move(move_from_space, move_to_space)
		create_possible_moves_array(move_from_space)
		create_possible_moves_tree(@possible_moves_array)
		puts my_tree.breadth_first_search(move_to_space).value
	end

	def create_possible_moves_array(root_move_array)
		@possible_moves_array = [root_move_array]
		sequence = [[1,2],[-1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1]]
		8.times do |x|
			possible_move = root_move_array
			possible_move[0] = possible_move[0] + sequence[x][0]
			possible_move[1] = possible_move[1] + sequence[x][1]
			if possible_move[0].between?(0,7) && possible_move[1].between?(0,7)
				@possible_moves_array.push(possible_move)
			end
		end
	end

	def create_possible_moves_tree(input_array)
		my_tree = Tree.new(input_array)
	end

end

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

	def breadth_first_search(target_value)
		queue = []
		queue.push(@root)
		while queue.any?
			current_node = queue[0]
			if current_node.nil?
				queue.shift
				next
			end
			queue.push(current_node.left_child, current_node.right_child)
			return current_node if current_node.value == target_value
			queue.shift
		end
	end

	def depth_first_search(target_value)
		stack = []
		stack.push(@root)
		while stack.any?
			current_node = stack[-1]
			if current_node.nil?
				stack.pop
				next
			end
			return current_node if current_node.value == target_value
			stack.pop
			stack.push(current_node.right_child, current_node.left_child)
		end
	end

	def dfs_rec(target_value, node=@root)
		return if node.nil? || @return_value
		@return_value = node if node.value == target_value
		dfs_rec(target_value, node.left_child)
		dfs_rec(target_value, node.right_child)
		return @return_value
	end
end

class Board

	def initialize
		@spaces = []
		create_board_spaces
	end

	def create_board_spaces
		8.times do |x|
			@spaces[x] = []
			8.times do |y|
				@spaces[y] = []
			end
		end
	end

end

#my_board = Board.new

my_knight = Knight.new
my_knight.move([1,1],[2,3])
