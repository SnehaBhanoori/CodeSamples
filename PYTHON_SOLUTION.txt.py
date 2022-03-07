#  Minesweeper Game


from collections import Counter


class MinesweeperGame:

    def __init__(self):
        pass

    def neighbour_cells(self, x, y, n):
        list1 = [(x, y + 1), (x + 1, y + 1), (x + 1, y), (x + 1, y - 1), (x, y - 1), (x - 1, y - 1), (x - 1, y),
                 (x - 1, y + 1)]
        for i in range(0, 8):
            for x, y in enumerate(list1):
                if 0 > y[0] or y[0] > n - 1 or 0 > y[1] or y[1] > n - 1:
                    list1.pop(x)
                    break
                else:
                    pass
        return list1


    def exclude_bombcells_neighbour_cells(self , bomb_list, cell_list):
        for i in range(0, len(cell_list)):
            for x, y in enumerate(cell_list):
                if y in bomb_list:
                    cell_list.pop(x)
                    break
        return cell_list


    def merge(self ,list1, list2):
        merged_list = [(list1[i], list2[i]) for i in range(0, len(list1))]
        return merged_list


    def bomb_val_into_count_dict(self, count_dict, bomb_list):
        for x in bomb_list:
            count_dict[x] = 'B'
        return count_dict


    def add_non_neighbourcell_count(self, count_dict, n):
        for x in range(0, n):
            for y in range(0, n):
                if (x, y) in count_dict.keys():
                    continue
                count_dict[(x, y)] = '0'
        return count_dict


    def output_frame(self,count_dict, n ):
        output_list = []
        overall_output_list = []
        val = ''
        for x in range(0, n):
            for y in range(0, n):
                val += str(count_dict[(x, y)])
            val += ' '
        return val


    def minesweeper_fn(self, n, r, c):
        bomb_list = self.merge(r, c)
        total_cell_list=[]
        clean_cell_list=[]
        for (x, y) in bomb_list:
            total_cell_list += self.neighbour_cells(x, y, n)
        clean_cell_list = self.exclude_bombcells_neighbour_cells(bomb_list, total_cell_list)
        count_dict = self.add_non_neighbourcell_count(Counter(clean_cell_list), n)
        count_dict = self.bomb_val_into_count_dict(count_dict, bomb_list)
        return self.output_frame(dict(count_dict), n)

'''---------------------------Function execution w.r.t provided cases-----------'''

new_game = MinesweeperGame()
#game_output = new_game.minesweeper_fn(N, R,C)
game_output = new_game.minesweeper_fn(3, [2, 1, 0, 2], [0, 2, 1, 2])
print(game_output)

'''In the above function call please replace the parameters for different cases below(as mentioned in the assesment)

Case 1
 N = 3,R = [2, 1, 0, 2], C= [0, 2, 1, 2] )
 
Case 2
 N = 5,R = [2, 3, 2, 3, 1, 1, 3, 1] ,C= [3, 3, 1, 1, 1, 2, 2, 3])

Case 3
N = 2 ,R= [] ,C= []

'''


