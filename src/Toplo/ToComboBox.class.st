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
		'#buttonPlaceHolder => ObservableSlot',
		'#listFrame'
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
	button addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | listFrame isAttachedToSceneGraph  ifTrue: [listFrame close] ifFalse: [ listFrame popupEvent: evt ]]).
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
ToComboBox >> defaultButtonPlaceHolder [

	^ ToLabel text: 'Button place holder'
]

{ #category : #initialization }
ToComboBox >> defaultListElement [

	^ ToListElement new
		  matchParent;
		  yourself
]

{ #category : #initialization }
ToComboBox >> defaultListFrame [
	| win |
	win := ToPopupWindow new widget: self.
	win root size: 250@350.
	win root addChild: self listElement.
	^  win
]

{ #category : #initialization }
ToComboBox >> defaultListPlaceHolder [

	^ ToLabel text: 'List place holder'
]

{ #category : #initialization }
ToComboBox >> defaultNodeFactory [

	^ [ :d |
	  ToLabeledNode new
		  beLabelFirst;
		  hMatchParent;
		  labelText: d;
		  yourself ]
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
	listElement := self defaultListElement.
	listFrame := self defaultListFrame.
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
ToComboBox >> listData [

	^ listElement data
]

{ #category : #accessing }
ToComboBox >> listElement [

	^ listElement
]

{ #category : #accessing }
ToComboBox >> listItems [

	^ listElement data
]

{ #category : #accessing }
ToComboBox >> listNodeFactory [

	^ self listElement nodeFactory
]

{ #category : #accessing }
ToComboBox >> listNodeFactory: aBlock [

	self listElement nodeFactory: aBlock
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
