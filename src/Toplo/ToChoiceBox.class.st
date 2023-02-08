Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#choices',
		'#button',
		'#group',
		'#selectedItem => ObservableSlot',
		'#toTextConverter',
		'#items'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'adding / removing' }
ToChoiceBox >> addAllChoices: aList [

	aList do: [ :t | self addItem: t ]

]

{ #category : #'adding / removing' }
ToChoiceBox >> addItem: anObject [

	self items add: anObject.
	self privateAddItem: (self newItemFromChoice: anObject).
	selectedItem ifNil: [ self defaultItem: anObject ]
]

{ #category : #'adding / removing' }
ToChoiceBox >> addSeparator [

	button addSeparator
]

{ #category : #initialization }
ToChoiceBox >> beJustified [

	button hMatchParent.
	button beJustified
]

{ #category : #accessing }
ToChoiceBox >> choiceFromItem: anItem [

	^ self items
		  detect: [ :c | 
			  (self toTextConverter value: c) asString
			  = anItem label text asString ]
		  ifNone: [  ]
]

{ #category : #accessing }
ToChoiceBox >> choices [

	^ choices
]

{ #category : #accessing }
ToChoiceBox >> defaultChoiceIndex: anInteger [


	self defaultItem: (self items at: anInteger)
	
]

{ #category : #'t - initialization dresser' }
ToChoiceBox >> defaultDresser [

	^ ToChoiceBoxDresser new
]

{ #category : #accessing }
ToChoiceBox >> defaultItem: anObject [


	| item |
	item := self itemFromChoice: anObject.
	item ifNil: [ ^ self ].
	group default: item.
	selectedItem := anObject
	
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	toTextConverter := [ :i | i ].
	items := OrderedCollection new.
	self layout: BlFrameLayout new.
	self fitContent.
	button := ToChoiceBoxButton new.
	group := ToCheckableGroup new.
	self addChild: button.
	self whenSelectedItemChangedDo: [ self selectedItemChanged ].
	group whenCheckedDo: [ :item :previous | selectedItem := self choiceFromItem: item ].
	self initializeDresser.

]

{ #category : #accessing }
ToChoiceBox >> itemFromChoice: anObject [

	^ button items
		  detect: [ :i | 
			  i label text asString
			  = (self toTextConverter value: anObject) asString ]
		  ifNone: [  ]
]

{ #category : #accessing }
ToChoiceBox >> items [

	^ items 
]

{ #category : #'adding / removing' }
ToChoiceBox >> newItemFromChoice: anObject [

	^ ToChoiceBoxItem new labelText:
		  (self toTextConverter value: anObject)
]

{ #category : #'private adding / removing' }
ToChoiceBox >> privateAddItem: anItem [

	button addItem: anItem.
	group add: anItem

]

{ #category : #'private adding / removing' }
ToChoiceBox >> privateRemoveItem: anItem [

	button removeItem: anItem.
	group remove: anItem

]

{ #category : #'adding / removing' }
ToChoiceBox >> removeChoice: anObject [

	| i |
	self items remove: anObject.
	i := self itemFromChoice: anObject.
	self privateRemoveItem: i
]

{ #category : #accessing }
ToChoiceBox >> selectedItem [

	^ selectedItem
]

{ #category : #accessing }
ToChoiceBox >> selectedItem: anObject [

	selectedItem := anObject
]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedItemChanged [

	selectedItem ifNil: [ 
		button labelText: nil.
		^ self ].
	button labelText: (self toTextConverter value: selectedItem) copy
]

{ #category : #accessing }
ToChoiceBox >> toTextConverter [

	^ toTextConverter
]

{ #category : #accessing }
ToChoiceBox >> toTextConverter: anObject [

	toTextConverter := anObject
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenSelectedItemChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedItem whenChangedDo: aBlock
]
