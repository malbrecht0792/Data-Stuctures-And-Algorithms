class Knight

	def initialize

	end

	def move(move_from_space, move_to_space)
		create_possible_moves_array(move_from_space)
		create_possible_moves_tree(@possible_moves_array)
		check_if_tree_contains_move_to_space(move_to_space)
	end

	def create_possible_moves_array(root_move_array)
		@possible_moves_array = [root_move_array]
		sequence = [[1,2],[-1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1]]
		8.times do |x|
			possible_move = root_move_array.dup
			possible_move[0] = possible_move[0] + sequence[x][0]
			possible_move[1] = possible_move[1] + sequence[x][1]
			if possible_move[0].between?(0,7) && possible_move[1].between?(0,7)
				@possible_moves_array.push(possible_move)
			end
		end
	end

	def create_possible_moves_tree(input_array)
		@my_tree = Tree.new(input_array)
	end

	def check_if_tree_contains_move_to_space(move_to_space)
		return_node = nil
		@my_tree.root.children.each do |child|
			if child.value == move_to_space
				return_node = child
			end
		end
		p return_node.value
	end

end

class Node

	attr_accessor :value, :parent, :children

	def initialize(value, parent=nil, children=[])
		@value = value
		@parent = parent
		@children = children
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
			else
				@root.children.push(Node.new(value, @root))
			end
		end
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

my_knight = Knight.new
my_knight.move([1,1],[2,3])
