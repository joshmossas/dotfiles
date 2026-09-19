import i3ipc
import sys

i3 = i3ipc.Connection()

# Get arguments: number (1-10) and action (switch or move)
target_num = int(sys.argv[1])
action = sys.argv[2] 

focused = i3.get_tree().find_focused()
output = focused.ipc_data['output']

# Get all active physical outputs
active_outputs = [o for o in i3.get_outputs() if o.active]

# Sort outputs: top-most first (y coordinate). If y is the same, sort left-to-right (x coordinate).
active_outputs.sort(key=lambda o: (o.rect.y, o.rect.x))

# Detect if the focused output is the top monitor (index 0)
if len(active_outputs) >= 2:
    top_output = active_outputs[0].name
    if output == top_output:
        final_ws = target_num + 10
    else:
        final_ws = target_num
else:
    # Single monitor setup
    final_ws = target_num

# Execute based on action
if action == "switch":
    i3.command(f'workspace number {final_ws}')
elif action == "move":
    i3.command(f'move container to workspace number {final_ws}')
