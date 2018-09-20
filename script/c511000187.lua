--Armored Xyz
function c511000187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000187.target)
	e1:SetOperation(c511000187.activate)
	c:RegisterEffect(e1)
end
function c511000187.filter(c)
	return c:IsType(TYPE_XYZ)
end
function c511000187.filterx(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511000187.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000187.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000187.filter,tp,LOCATION_GRAVE,0,1,nil) 
	and Duel.IsExistingTarget(c511000187.filterx,tp,LOCATION_MZONE,0,1,nil) end
end
function c511000187.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=Duel.SelectTarget(tp,c511000187.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local g=Duel.SelectTarget(tp,c511000187.filterx,tp,LOCATION_MZONE,0,1,1,nil)
	local equip=eq:GetFirst()
	local tg=g:GetFirst()
	local code=equip:GetOriginalCode()
	local atk=equip:GetTextAttack()
	if not Duel.Equip(tp,equip,tg,false) then return end
	if atk>0 then
		--Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1)
		equip:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetCode(EFFECT_CHANGE_CODE)
		e2:SetValue(code)
		equip:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e3:SetCode(EFFECT_SET_ATTACK)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(atk)
		equip:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(511000187,0))
		e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e4:SetCountLimit(1)
		e4:SetCode(EVENT_DAMAGE_STEP_END)
		e4:SetRange(LOCATION_SZONE)
		e4:SetCost(c511000187.cost)
		e4:SetTarget(c511000187.atktg)
		e4:SetOperation(c511000187.atkop)
		equip:RegisterEffect(e4)
	end			
end
function c511000187.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000187.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c511000187.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end