Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#button',
		'#selectedItem => ObservableSlot',
		'#list'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	list := ToList new.
]
