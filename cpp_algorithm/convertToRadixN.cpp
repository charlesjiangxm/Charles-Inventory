/*
 * @ breif Convert a number to an arbitrary radix 任意进制转换
*/


class Solution {
public:
	/*
	 * @brief convert to **2 radix
	 * 
	 * because string "+" operation is slow since 
	 * it'll create intermediate strings. This code may
	 * be a little bit slower.
	 *
	 * Acutally this should be fast in nature since shifting
	 * and binary& is faster in hardware
	*/
    string toHexSlow(int num) {
        string hexString = "";
        string hex_table = "0123456789abcdef";

        while (num) {
            // get the last 4 digits (num&0xF) as searching index
            hexString = hex_table[num&0xF] + hexString;
			// num must be cast to sunsigned int
            num = static_cast<unsigned int>(num) >> 4;
        }

        return hexString.empty() ? "0" : hexString;
    }
	
	/**
	 * @brief convert to any number of radix
	 * 
	 * One "%" one "/" operations are not avoidable
	 */
    vector<int> toHexQuick(int num) {
			
		// radix-26
		int radix = 26;
		
		vector<int> ans;

		if(num==0) cout <<static_cast<int>(0);

		while(num){
			ans.push_back(num%radix);
			num = num/radix;
		}
			
		reverse(ans.begin(), ans.end());
		return ans;		
	}
};

