-----------------------------------
-- Trust: Aldo
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.ALDO_UC)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.LION] = xi.trust.messageOffset.TEAMWORK_1,
		[xi.magic.spell.ZEID] = xi.trust.messageOffset.TEAMWORK_2,
		[xi.magic.spell.GILGAMESH] = xi.trust.messageOffset.TEAMWORK_3,
    })

	mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 2000)
	mob:addGambit(ai.t.SELF, { ai.c.TP_GTE, 1000 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.ASSASSINS_CHARGE })
	mob:addGambit(ai.t.SELF, { ai.c.STATUS, xi.effect.ASSASSINS_CHARGE }, {ai.r.WS, ai.s.RANDOM, 0 })
	mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BULLY })
	mob:addGambit(ai.t.TARGET, { ai.c.STATUS, xi.effect.DOUBT }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SNEAK_ATTACK })

	mob:addMod(xi.mod.DEX, 200)
	mob:addMod(xi.mod.TP_BONUS, 250)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
