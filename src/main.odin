package main

import "core:fmt"

import rl "vendor:raylib"

GRID_SIZE       :: 3
CELL_SIZE       :: 100
SCREEN_WIDTH    :: GRID_SIZE * CELL_SIZE * 2

BoardType :: [GRID_SIZE][GRID_SIZE]int

Cell_State :: enum  {
    EMPTY,
    PLAYER_X,
    PLAYER_O,
}

Game_State :: enum  {
    MENU,
    PLAYING,
    GAME_OVER,
}

main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_WIDTH, "Odin + Raylib: Tic Tac Toe")
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    // Initialize game state
    board: BoardType
    game_state: Game_State = .MENU
    current_player: Cell_State = .PLAYER_X
    winner: Cell_State = .EMPTY

    // Main game loop
    for !rl.WindowShouldClose() {
        handle_input(&board, &game_state, &current_player, &winner)
        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)

        switch game_state {
        case .MENU:
            draw_menu()
            // fmt.println("Menu")
        case .PLAYING:
            // draw_board(&board)
            fmt.println("Playing")
        case .GAME_OVER:
            fmt.println("Game Over")
            // draw_board(&board)
            // draw_winner_message(winner)
        }

        rl.EndDrawing()
    }
}

handle_input :: proc(board: ^BoardType, game_state: ^Game_State, current_player: ^Cell_State, winner: ^Cell_State) {
    if rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
        
    }
}

draw_menu :: proc() {
    draw_button(SCREEN_WIDTH/2 - 50, SCREEN_WIDTH/2 -25, 100, 50, "Play")
}

draw_x :: proc(x: i32, y: i32) {
    padding: i32 = 10
    rl.DrawLine(x + padding, y + padding, x + CELL_SIZE - padding, y + CELL_SIZE - padding, rl.RED)
    rl.DrawLine(x + CELL_SIZE - padding, y + padding, x + padding, y + CELL_SIZE - padding, rl.RED)
}

draw_o :: proc(x: i32, y: i32) {
    padding: i32 = 10
    rl.DrawCircle(x + CELL_SIZE / 2, y + CELL_SIZE / 2, CELL_SIZE / 3, rl.BLUE)
}

draw_winner_message :: proc(winner: Cell_State) {
    if winner == .PLAYER_X {
        rl.DrawText("Player X Wins!", SCREEN_WIDTH / 2 - 50, SCREEN_WIDTH / 2 - 20, 20, rl.RED)
    } else if winner == .PLAYER_O {
        rl.DrawText("Player O Wins!", SCREEN_WIDTH / 2 - 50, SCREEN_WIDTH / 2 - 20, 20, rl.BLUE)
    } else {
        rl.DrawText("It's a Draw!", SCREEN_WIDTH / 2 - 50, SCREEN_WIDTH / 2 - 20, 20, rl.GRAY)
    }
}

draw_button :: proc(x: i32, y: i32, width: i32, height: i32, text: cstring) {
    button_color := is_mouse_over_button(x, y, width, height) ? rl.DARKGRAY : rl.LIGHTGRAY
    text_color := is_mouse_over_button(x, y, width, height) ? rl.LIGHTGRAY : rl.DARKGRAY
    outline_color := is_mouse_over_button(x, y, width, height) ? rl.LIGHTGRAY : rl.DARKGRAY
    fmt.println("is_mouse_over_button: ", is_mouse_over_button(x, y, width, height))
    rl.DrawRectangle(x, y, width, height, button_color)
    rl.DrawRectangleLines(x, y, width, height, outline_color)

    text_x := x + (width - rl.MeasureText(text, 20)) / 2
    text_y := y + (height - 20) / 2
    rl.DrawText(text, text_x, text_y, 20, text_color)
}

is_mouse_over_button :: proc(x: i32, y: i32, width: i32, height: i32) -> bool {
    mouse_pos := rl.GetMousePosition()
    return i32(mouse_pos.x) >= x && i32(mouse_pos.x) <= x + width && i32(mouse_pos.y) >= y && i32(mouse_pos.y) <= y + height
}