	//define and resize the output of the bitline voltages -----------------------------------
	//1D:number of MAC used(the MACs are in a row-by-row sequence); 2D:batch_num;
	//3D:iter_num; 4D:CB_COL
    vector<vector<vector<MatrixXd * > > > bitline_voltage;
	bitline_voltage.resize(mac_row * mac_col);
	for (int i = 0; i < mac_row * mac_col; i++) {
		bitline_voltage[i].resize(batch_num);
		for (int j = 0; j < batch_num; j++) {
			bitline_voltage[i][j].resize(iter_num);
			for (int k = 0; k < iter_num; k++) {

				bitline_voltage[i][j][k] = new MatrixXd(MatrixXd::Zero(1, 128));
                *bitline_voltage[i][j][k] = MatrixXd::Zero(1, 128);
			}
		}
	}
