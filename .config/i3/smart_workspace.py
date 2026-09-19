import i3ipc
import sys

i3 = i3ipc.Connection()

# Get arguments: number (1-10) and action (switch or move)
target_num = int(sys.argv[1])
action = sys.argv[2] 

focused = i3.get_tree().find_focused()
output = focused.ipc_data['output']

# Detect monitor (Replace with your xrandr names)
# If focused on top monitor, offset the workspace by 10
if output == 'HDMI-A-0':
    final_ws = target_num + 10
else:
    final_ws = target_num

# Execute based on action
if action == "switch":
    i3.command(f'workspace number {final_ws}')
elif action == "move":
    i3.command(f'move container to workspace number {final_ws}')