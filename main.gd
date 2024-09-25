extends Node
@export var enemy_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$ScoreTimer.start()
	$EnemyTimer.start()
	


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = get_node(^"EnemyPath2D/EnemySpawnLocation")
	enemy_spawn_location.progress = randi()
	
	var direction = enemy_spawn_location.rotation + PI / 2
	
	enemy.position = enemy_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	add_child(enemy)
