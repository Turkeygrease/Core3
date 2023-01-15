
#ifndef CURRENCYBUFFATTIBUTELISTCOMPONENT_H_
#define CURRENCYBUFFATTIBUTELISTCOMPONENT_H_

#include "server/zone/objects/scene/components/AttributeListComponent.h"
#include "server/zone/objects/tangible/TangibleObject.h"
#include "server/zone/objects/tangible/components/currencyBuffDataComponent.h"

class CurrencyBuffAttributeListComponent: public AttributeListComponent {
public:

	/**
	 * Fills the Attributes
	 * @pre { this object is locked }
	 * @post { this object is locked, menuResponse is complete}
	 * @param menuResponse ObjectMenuResponse that will be sent to the client
	 */
	void fillAttributeList(AttributeListMessage* alm, CreatureObject* creature, SceneObject* object) const {

		ManagedReference<TangibleObject*> tano = cast<TangibleObject*>(object);

		CurrencyBuffDataComponent* data = cast<CurrencyBuffDataComponent*>(tano->getDataObjectComponent()->get());

		if (data == NULL || !data->isCurrencyBuffData())
			return;

		int charges;
		String buffType = data->getBuffType();
		String quality = "?error?";
		String range = "?error?";
		String buff = "?error?";
		String skill = "?error?";
		String rules = "\nRules:\n* Must be in LOS.\n* Must be in same area.";
		int power = 0; 

		/* Test Bracelet to see if it is set up yet */
		if(buffType == "unset"){ 
			String name = object->getDisplayedName();
			int bonus = System::random(6);/*Base Bonus Modifier*/

			if (name.contains("Exceptional")){
				name[name.length()-1] = '_';
				name[name.length()-13] = '_';
				name[name.length()-14] = '_';
				bonus +=5; /*Exceptional Base Bonus */
				bonus += System::random(6); /*Exceptional Random Bonus*/
				name = name.replaceAll("__Exceptional_","");
			}else if (name.contains("Legendary")){
				name[name.length()-1] = '_';
				name[name.length()-11] = '_';
				name[name.length()-12] = '_';
				bonus +=10; /*Legendary Base Bonus*/
				bonus += System::random(11); /*Legendary Random Bonus*/
				name = name.replaceAll("__Legendary_","");
			}

			// type , prof , faction , level , target prefference, boost choice
			// (0=pve,1=pvp),(0=doc,1=ent),(0=neut,1=imp,2=reb),(0=novice,1=journeyman,2=master),(?=unset,0=target,1=group,2=area),(?)
			if(name == "Currency Buff Bracelet (System Generated)"){data->setBuffType("1011?"); data->setCharges(30);
			}else if(name == "T1 PVP Doctor Band (IMP)"){data->setBuffType("1010?"); data->setCharges(8);
			}else if(name == "T2 PVP Doctor Band (IMP)"){data->setBuffType("1011?"); data->setCharges(18);
			}else if(name == "T3 PVP Doctor Band (IMP)"){data->setBuffType("1012?"); data->setCharges(28);

			}else if(name == "T1 PVP Doctor Band (REB)"){data->setBuffType("1020?"); data->setCharges(8);
			}else if(name == "T2 PVP Doctor Band (REB)"){data->setBuffType("1021?"); data->setCharges(18);
			}else if(name == "T3 PVP Doctor Band (REB)"){data->setBuffType("1022?"); data->setCharges(28);

			}else if(name == "T1 PVP Entertainer Band (IMP)"){data->setBuffType("1110?"); data->setCharges(8);
			}else if(name == "T2 PVP Entertainer Band (IMP)"){data->setBuffType("1111?"); data->setCharges(18);
			}else if(name == "T3 PVP Entertainer Band (IMP)"){data->setBuffType("1112?"); data->setCharges(28);

			}else if(name == "T1 PVP Entertainer Band (REB)"){data->setBuffType("1120?"); data->setCharges(8);
			}else if(name == "T2 PVP Entertainer Band (REB)"){data->setBuffType("1121?"); data->setCharges(18);
			}else if(name == "T3 PVP Entertainer Band (REB)"){data->setBuffType("1122?"); data->setCharges(28);

			}else if(name == "T1 PVE Doctor Band"){data->setBuffType("0000?"); data->setCharges(8);
			}else if(name == "T2 PVE Doctor Band"){data->setBuffType("0001?"); data->setCharges(18);
			}else if(name == "T3 PVE Doctor Band"){data->setBuffType("0002?"); data->setCharges(28);

			}else if(name == "T1 PVE Entertainer Band"){data->setBuffType("0100?"); data->setCharges(8);
			}else if(name == "T2 PVE Entertainer Band"){data->setBuffType("0101?"); data->setCharges(18);
			}else if(name == "T3 PVE Entertainer Band"){data->setBuffType("0102?"); data->setCharges(28);
			}
			data->setCharges(data->getCharges()+bonus); //apply bonus if any
		}

		/* Determine Bracelet type and set up attribute list */
		if(buffType[1] == '0'){ //is doc buff?
			buff = "Doctor Buffs(ALL)";
			if(buffType[0] == '1'){ //pvp buff
				rules += "\n* Must be OVERT.";
				rules += (buffType[2]=='1')? "\n* Must be Imperial." : "\n* Must be Rebel.";
				switch(buffType[3]){ //what tier is the buff
					case '0':{quality = "uncommon"; range = "Target(10m)"; power = 3400; skill = "GCW Medic Novice"; break;}
					case '1':{quality = "rare"; range = "Group(35m)"; power = 3600; skill = "GCW Medic 1"; break;}
					case '2':{quality = "legendary"; range = "Area(35m)"; power = 3800; skill = "GCW Medic 3"; break;}
				}
			}else{ //pve buff
				rules += "\n* Must be ON-LEAVE.";
				switch(buffType[3]){ //what tier is the buff
					case '0':{quality = "common"; range = "Target(10m)"; power = 3000; skill = "Novice Doctor"; break;}
					case '1':{quality = "uncommon"; range = "Group(35m)"; power = 3200; skill = "Medicine Knowledge 4"; break;}
					case '2':{quality = "rare"; range = "Area(35m)"; power = 3400; skill = "Master Doctor"; break;}
				}				
			}
		}else{
			buff = "Entertainer Buffs(ALL)";
			if(buffType[0] == '1'){ //pvp buff
				rules += "\n* Must be OVERT.";
				rules += (buffType[2]=='1')? "\n* Must be Imperial." : "\n* Must be Rebel.";
				switch(buffType[3]){ //what tier is the buff
					case '0':{quality = "uncommon"; range = "Target(10m)"; power = 1200; skill = "Master Entertainer"; break;}
					case '1':{quality = "rare"; range = "Group(35m)"; power = 1375; skill = "Novice Specialty"; break;}
					case '2':{quality = "legendary"; range = "Area(35m)"; power = 1550; skill = "Master Specialties"; break;}
				}
			}else{ //pve buff
				rules += "\n* Must be ON-LEAVE.";
				switch(buffType[3]){ //what tier is the buff
					case '0':{quality = "common"; range = "Target(10m)"; power = 1050; skill = "Master Entertainer"; break;}
					case '1':{quality = "uncommon"; range = "Group(35m)"; power = 1125; skill = "Novice Specialty"; break;}
					case '2':{quality = "rare"; range = "Area(35m)"; power = 1200; skill = "Master Specialty"; break;}
				}				
			}
		}

		charges = data->getCharges();
		int duration = calcPower(creature, buffType[1]);
		power += (duration*3); /*Power X Skill multiplier*/
		duration = (((duration*4)+((buffType[3]-47)*300))*1000)+7200000;/*3600000 = 1hr as base duration*/

		alm->insertAttribute("charges", charges);
		alm->insertAttribute("effect", buff+"\n");
		alm->insertAttribute("quality", quality);
		alm->insertAttribute("power", power);
		alm->insertAttribute("duration", getCooldownString(duration));
		alm->insertAttribute("range", range+"\n");
		alm->insertAttribute("skill_required", skill+"\n");
		alm->insertAttribute("contents","Use:\n Equip and radial to apply instant buffs\n"+rules);
		
		if (!creature->checkCooldownRecovery("Currency_Buff")) {
			Time* timeRemaining = creature->getCooldownTime("Currency_Buff");
			alm->insertAttribute("time_remaining", getCooldownString(timeRemaining->miliDifference() * -1));
		}

	}

	String getCooldownString(uint32 delta) const {

		int seconds = delta / 1000;

		int hours = seconds / 3600;
		seconds -= hours * 3600;

		int minutes = seconds / 60;
		seconds -= minutes * 60;

		StringBuffer buffer;

		if (hours > 0)
			buffer << hours << "h ";

		if (minutes > 0)
			buffer << minutes << "m ";

		if (seconds > 0)
			buffer << seconds << "s";

		return buffer.toString();
	}

	int calcPower(CreatureObject* creature, int type) const{
		int maxBuffStrength = 0.0f;
		if(type == '0') { // Doctor Buff being applied
			maxBuffStrength += creature->getSkillMod("healing_ability");
			maxBuffStrength += creature->getSkillMod("combat_healing_ability");
		}else { // Entertainer Buff being applied
			maxBuffStrength += creature->getSkillMod("healing_dance_mind");
			maxBuffStrength += creature->getSkillMod("healing_music_mind");
			maxBuffStrength /= 2;
		}
		return maxBuffStrength;
	}
};

#endif
