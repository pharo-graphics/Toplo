Class {
	#name : #AnObsoleteToChoiceMenu,
	#superclass : #ToMenu,
	#traits : 'TToCheckableGroupHolder',
	#classTraits : 'TToCheckableGroupHolder classTrait',
	#instVars : [
		'group',
		'data',
		'dataToTextConverter',
		'defaultLabel',
		'defaultSelectedIndex'
	],
	#category : #'Toplo-Widget-Menu-Choice menu deprecated'
}

{ #category : #testing }
AnObsoleteToChoiceMenu class >> isDeprecated [

	" use ToSelectElement instead "

	^ true
]
