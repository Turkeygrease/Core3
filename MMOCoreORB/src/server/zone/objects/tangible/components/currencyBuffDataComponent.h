
#ifndef CURRENCYBUFFDATACOMPONENT_H_
#define CURRENCYBUFFDATACOMPONENT_H_

#include "server/zone/objects/scene/components/DataObjectComponent.h"

class CurrencyBuffDataComponent : public DataObjectComponent {
protected:
	int charges;
	String buffType;
public:
	CurrencyBuffDataComponent() {
		charges = 15;
		buffType = "unset";
		addSerializableVariables();
	}

	virtual ~CurrencyBuffDataComponent() {

	}

	void setCharges(int num) {
		charges = num;
	}

	int getCharges() {
		return charges;
	}

	void setBuffType(String str) {
		buffType = str;
	}

	String getBuffType() {
		return buffType;
	}

	bool isCurrencyBuffData() {
		return true;
	}

private:
	void addSerializableVariables() {
		addSerializableVariable("charges", &charges, 0);
		addSerializableVariable("buffType", &charges, 0);
	}
};


#endif /* CurrencyBuffDATACOMPONENT_H_ */
