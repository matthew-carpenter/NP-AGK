
// Project: GunDream
// Created: 2017-07-30

#insert "config.agc"
#insert "types.agc"


DO


    SELECT runmode


		CASE 0						`ENGINE: core = shutdown

			end

		ENDCASE


		CASE 1						`MENU: main = run

			show_menu_main()

		ENDCASE


		CASE 2

			`TODO

		ENDCASE


		CASE 3

			`TODO

		ENDCASE


		CASE 4

			`TODO

		ENDCASE


		CASE 5						`ENGINE: run

			handle_keyboard()
			show_dev_hud()

		ENDCASE


	ENDSELECT


    SYNC()


LOOP


#insert "nplib.agc"
#insert "input.agc"
