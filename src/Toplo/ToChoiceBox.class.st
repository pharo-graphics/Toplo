Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'button',
		'group'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #adding }
ToChoiceBox >> addAllChoiceNames: aListOfText [

	aListOfText do: [ :t | self addChoiceName: t ]

]

{ #category : #adding }
ToChoiceBox >> addAllItems: aCollection [

	button addAllItems: aCollection
]

{ #category : #adding }
ToChoiceBox >> addChoiceName: aText [

	self addItem: (ToChoiceBoxItem new labelText: aText)

]

{ #category : #adding }
ToChoiceBox >> addItem: anItem [

	button addItem: anItem.
	group add: anItem

]

{ #category : #adding }
ToChoiceBox >> addSeparator [

	button addSeparator
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	super initialize.
	button := ToMenu new labelText: 'choicebox'.
	group := ToCheckableGroup new.
	self addChild: button.
	self fitContent.
	
	self initializeDresser 
]

{ #category : #adding }
ToChoiceBox >> removeItem: anItem [

	button removeItem: anItem

]
