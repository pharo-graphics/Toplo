Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#button',
		'#group',
		'#selectedItem => ObservableSlot'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'adding / removing' }
ToChoiceBox >> addAllChoiceNames: aListOfText [

	aListOfText do: [ :t | self addChoiceName: t ]

]

{ #category : #'adding / removing' }
ToChoiceBox >> addAllItems: aCollection [

	button addAllItems: aCollection
]

{ #category : #'adding / removing' }
ToChoiceBox >> addChoiceName: aText [

	self addItem: (ToChoiceBoxItem new labelText: aText)

]

{ #category : #'adding / removing' }
ToChoiceBox >> addItem: anItem [

	button addItem: anItem.
	group add: anItem

]

{ #category : #'adding / removing' }
ToChoiceBox >> addSeparator [

	button addSeparator
]

{ #category : #initialization }
ToChoiceBox >> default: aCheckable [

	group default: aCheckable.
	selectedItem := aCheckable
	
]

{ #category : #'t - initialization dresser' }
ToChoiceBox >> defaultDresser [

	^ ToChoiceBoxDresser new
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	self layout: BlFrameLayout new.
	self fitContent.
	button := ToChoiceBoxButton new.
	group := ToCheckableGroup new.
	self addChild: button.
	self whenSelectedItemChangedDo: [ self selectedItemChanged ].
	group whenCheckedDo: [ :item :previous | selectedItem := item ].
	self initializeDresser.

]

{ #category : #accessing }
ToChoiceBox >> itemWithLabelString: aString [

	^ button items detect: [ :i | i labelText asString = aString  ] ifNone: [  ]
	

]

{ #category : #'adding / removing' }
ToChoiceBox >> removeItem: anItem [

	button removeItem: anItem

]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedItemChanged [

	selectedItem ifNil: [ 
		button labelText: nil.
		^ self ].
	button labelText: selectedItem labelText copy
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenSelectedItemChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedItem whenChangedDo: aBlock
]
