Class {
	#name : #ToComboBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#button',
		'#selectedIndex => ObservableSlot',
		'#items',
		'#listElement',
		'#buttonFactory',
		'#listPlaceHolder',
		'#buttonPlaceHolder => ObservableSlot'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBox >> button [

	^ button
]

{ #category : #accessing }
ToComboBox >> button: aButton [
	button = aButton ifTrue: [ ^ self ].
	button ifNotNil: [ button removeFromParent ].
	button := aButton.
	self addChild: button
]

{ #category : #accessing }
ToComboBox >> buttonFactory [
	" a Valuable can take 2 args, a selected data value and the previous button"

	^ buttonFactory
]

{ #category : #accessing }
ToComboBox >> buttonFactory: aValuable [
	" a Valuable can take 2 args, a selected data value and the previous button"

	buttonFactory := aValuable
]

{ #category : #accessing }
ToComboBox >> buttonItem: anObject [

	self button: (self buttonFactory cull: anObject cull: self button)

]

{ #category : #accessing }
ToComboBox >> buttonPlaceHolder [

	^ buttonPlaceHolder
]

{ #category : #accessing }
ToComboBox >> buttonPlaceHolder: anElement [

	buttonPlaceHolder := anElement
]

{ #category : #'change hook' }
ToComboBox >> buttonPlaceHolderChanged [
]

{ #category : #initialization }
ToComboBox >> defaultPlaceHolder [

	^ 'Place holder'
]

{ #category : #initialization }
ToComboBox >> defaultStartSelectedIndex [

	^ 1

	
]

{ #category : #initialization }
ToComboBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self layout: self defaultLayout.
	self fitContent
]

{ #category : #accessing }
ToComboBox >> items [
	
	^ items
]

{ #category : #accessing }
ToComboBox >> items: aCollection [

	items := aCollection.
	listElement list removeAll.
	listElement list addAll: aCollection.
]

{ #category : #accessing }
ToComboBox >> listItems [
	
	^ listElement list
]

{ #category : #accessing }
ToComboBox >> listPlaceHolder [

	^ listPlaceHolder
]

{ #category : #accessing }
ToComboBox >> listPlaceHolder: anElement [

	listPlaceHolder := anElement
]

{ #category : #accessing }
ToComboBox >> selectedIndex [
	
	^ selectedIndex 
]

{ #category : #accessing }
ToComboBox >> selectedIndex: anInteger [

	selectedIndex := anInteger
]

{ #category : #'change hook' }
ToComboBox >> selectedIndexChanged [
]

{ #category : #'change hook' }
ToComboBox >> whenButtonPlaceHolderChangedDo: aBlock [

	"set a block to perform after that the place holder has been changed, and its action performed"

	self property: #buttonPlaceHolder whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToComboBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]
