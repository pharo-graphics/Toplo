Class {
	#name : #ToComboBox,
	#superclass : #ToPolyElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#button',
		'#selectedItem => ObservableSlot',
		'#list',
		'#selectedIndex'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self layout: self defaultLayout.
	list := ToList new.
	button := ToBoxButton new.
	selectedIndex := self defaultStartSelectedIndex.
	self addChild: button.
	self whenSelectedIndexChangedDo: [ self selectedIndexChanged ].

	self initializeDresser.

]

{ #category : #accessing }
ToComboBox >> selectedIndex [
	
	^ selectedIndex 
]

{ #category : #accessing }
ToComboBox >> selectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #'selection change' }
ToComboBox >> selectedIndexChanged [
]

{ #category : #enumerating }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
