import tkinter as tk
import random
import json
import os
import sys

class SimpleGame:
    def __init__(self, master, progress_file='progress.json'):
        self.master = master
        self.master.title("Simple Game")
        self.progress_file = progress_file

        self.canvas = tk.Canvas(master, width=400, height=400, bg='white')
        self.canvas.pack()

        self.score = 0
        self.load_progress()

        self.score_label = tk.Label(master, text=f"Score: {self.score}")
        self.score_label.pack()

        self.circle = self.canvas.create_oval(0, 0, 50, 50, fill='red')
        self.move_circle()

    def move_circle(self):
        x = random.randint(0, 350)
        y = random.randint(0, 350)
        self.canvas.coords(self.circle, x, y, x+50, y+50)
        self.canvas.tag_bind(self.circle, '<ButtonPress-1>', self.increment_score)

    def increment_score(self, event):
        self.score += 1
        self.score_label.config(text=f"Score: {self.score}")
        self.move_circle()

    def save_progress(self):
        progress = {'score': self.score}
        with open(self.progress_file, 'w') as f:
            json.dump(progress, f)

    def load_progress(self):
        if os.path.exists(self.progress_file):
            with open(self.progress_file, 'r') as f:
                progress = json.load(f)
                self.score = progress.get('score', 0)
        else:
            self.score = 0

def main():
    progress_file = 'progress.json'
    if len(sys.argv) > 1:
        progress_file = sys.argv[1]
    root = tk.Tk()
    game = SimpleGame(root, progress_file)
    root.protocol("WM_DELETE_WINDOW", game.save_progress)  # Save progress when window is closed
    root.mainloop()

if __name__ == "__main__":
    main()
