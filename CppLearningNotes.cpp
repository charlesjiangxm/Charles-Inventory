/* ---------------------------------------------------
 * 1. How to use pointer/New/Delete
 * ---------------------------------------------------
 */
vector<MatrixXd * > bitline_voltage;

bitline_voltage.resize(128);
for (int k = 0; k < iter_num; k++) {
	// 指针需要先用new来初始化后才能进行赋值, new的意思是分配一段内存给bitline_voltage
	bitline_voltage[i][j][k] = new MatrixXd(MatrixXd::Zero(1, 128));
	// 若没有上面那行语句，单独使用这行语句会报segmentation fault，就是系统为保护自己不让用户使用未分配的
	// 内存，但是如果已经new过bitline_voltage了，就可以直接使用下面这行语句了
	*bitline_voltage[i][j][k] = MatrixXd::Zero(1, 128);
}
