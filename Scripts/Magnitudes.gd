extends Node

const NONE = { "ab":"", "value":1, "zeros":0 }
const THOUSAND = { "ab":"K", "value": float(pow(10, 3)), "zeros":3 }
const MILLION = { "ab":"M", "value": float(pow(10, 6)), "zeros":6 }
const BILLION = { "ab":"B", "value": float(pow(10, 9)), "zeros":9 }
const TRILLION = { "ab":"T", "value": float(pow(10, 12)), "zeros":12 }
const QUADRILLION = { "ab":"q", "value": float(pow(10, 15)), "zeros":15 }
const QUINTILLION = { "ab":"Q", "value": float(pow(10, 18)), "zeros":18 }
const SIXTILLION = { "ab":"s", "value": float(pow(10, 21)), "zeros":21 }
const SEPTILLION = { "ab":"S", "value": float(pow(10, 24)), "zeros":24 }
const OCTILLION = { "ab":"o", "value": float(pow(10, 27)), "zeros":27 }
const NONILLION = { "ab":"N", "value": float(pow(10, 30)), "zeros":30 }
const DECILLION = { "ab":"d", "value": float(pow(10, 33)), "zeros":33 }
const UNDECILLION = { "ab":"U", "value": float(pow(10, 36)), "zeros":36 }
const DUODECILLION = { "ab":"D", "value": float(pow(10, 39)), "zeros":39 }
const TREDECILLION = { "ab":"Td", "value": float(pow(10, 42)), "zeros":42 }
const QUATTUORDECILLION = { "ab":"qd", "value": float(pow(10, 45)), "zeros":45 }
const QUINDECILLION = { "ab":"Qd", "value": float(pow(10, 48)), "zeros":48 }
const SEXDECILLION = { "ab":"sd", "value": float(pow(10, 51)), "zeros":51 }
const SEPTENDECILLION = { "ab":"Sd", "value": float(pow(10, 54)), "zeros":54 }
const OCTODECILLION = { "ab":"Od", "value": float(pow(10, 57)), "zeros":57 }
const NOVEMDECILLION = { "ab":"Nd", "value": float(pow(10, 60)), "zeros":60 }
const VIGINTILLION = { "ab":"V", "value": float(pow(10, 63)), "zeros":63 }
const UNVIGINTILLION = { "ab":"uV", "value": float(pow(10, 66)), "zeros":66 }
const DUOVIGINTILLION = { "ab":"db", "value": float(pow(10, 69)), "zeros":69 }
const TRESVIGINTILLION = { "ab":"tV", "value": float(pow(10, 72)), "zeros":72 }
const QUATTUORVIGINTILLION = { "ab":"S", "value": float(pow(10, 75)), "zeros":75 }
const QUINVIGINTILLION = { "ab":"QV", "value": float(pow(10, 78)), "zeros":78 }
const SESVIGINTILLION = { "ab":"sV", "value": float(pow(10, 81)), "zeros":81 }
const SEPTENVIGINTILLION = { "ab":"SV", "value": float(pow(10, 84)), "zeros":84 }
const OCTOVIGINTILLION = { "ab":"OV", "value": float(pow(10, 87)), "zeros":87 }
const NOVEMVIGINTILLION = { "ab":"NV", "value": float(pow(10, 90)), "zeros":90 }
const TRIGINTILLION = { "ab":"TG", "value": float(pow(10, 93)), "zeros":93 }

var list : Array = [ NONE, THOUSAND, MILLION, BILLION, TRILLION, QUADRILLION, QUINTILLION, SIXTILLION, SEPTILLION, OCTILLION, NONILLION, DECILLION, UNDECILLION, DUODECILLION, TREDECILLION, QUATTUORDECILLION, QUINDECILLION, SEXDECILLION, SEPTENDECILLION, OCTODECILLION, NOVEMDECILLION, VIGINTILLION, UNVIGINTILLION, DUOVIGINTILLION, TRESVIGINTILLION, QUATTUORVIGINTILLION, QUINVIGINTILLION, SESVIGINTILLION, SEPTENVIGINTILLION, OCTOVIGINTILLION, NOVEMVIGINTILLION, TRIGINTILLION ]

var enum_list : Array = [ group.NONE, group.THOUSAND, group.MILLION, group.BILLION, group.TRILLION, group.QUADRILLION, group.QUINTILLION, group.SIXTILLION, group.SEPTILLION, group.OCTILLION, group.NONILLION, group.DECILLION, group.UNDECILLION, group.DUODECILLION, group.TREDECILLION, group.QUATTUORDECILLION, group.QUINDECILLION, group.SEXDECILLION, group.SEPTENDECILLION, group.OCTODECILLION, group.NOVEMDECILLION, group.VIGINTILLION, group.UNVIGINTILLION, group.DUOVIGINTILLION, group.TRESVIGINTILLION, group.QUATTUORVIGINTILLION, group.QUINVIGINTILLION, group.SESVIGINTILLION, group.SEPTENVIGINTILLION, group.OCTOVIGINTILLION, group.NOVEMVIGINTILLION, group.TRIGINTILLION ]

enum group { NONE, THOUSAND, MILLION, BILLION, TRILLION, QUADRILLION, QUINTILLION, SIXTILLION, SEPTILLION, OCTILLION, NONILLION, DECILLION, UNDECILLION, DUODECILLION, TREDECILLION, QUATTUORDECILLION, QUINDECILLION, SEXDECILLION, SEPTENDECILLION, OCTODECILLION, NOVEMDECILLION, VIGINTILLION, UNVIGINTILLION, DUOVIGINTILLION, TRESVIGINTILLION, QUATTUORVIGINTILLION, QUINVIGINTILLION, SESVIGINTILLION, SEPTENVIGINTILLION, OCTOVIGINTILLION, NOVEMVIGINTILLION, TRIGINTILLION }


func get_magnitude( quantity, magnitude ):

	return quantity * ( Magnitudes.list[ magnitude ].value )
#
#func set_quantity( quantity ):
#	var new_quantity = quantity
#	var new_magnitude = group.NONE
#	var index = 0
#	for i in range( 1, Magnitudes.list.size() - 1 ):
#		if quantity >= Magnitudes.list[ i ].value and quantity < Magnitudes.list[ i + 1 ].value:
#
#			print("Hallado en " +  Magnitudes.list[i].ab + " " + str( quantity ) + " x " + str(Magnitudes.list[ i ].value))
#			new_quantity = quantity / Magnitudes.list[ i ].value
#			new_magnitude = enum_list[i]
#	return [ new_quantity, new_magnitude ]
