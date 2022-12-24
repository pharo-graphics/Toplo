Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#choices',
		'#button',
		'#group',
		'#selectedChoice => ObservableSlot',
		'#toTextConverter'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'adding / removing' }
ToChoiceBox >> addAllChoices: aList [

	aList do: [ :t | self addChoice: t ]

]

{ #category : #'adding / removing' }
ToChoiceBox >> addChoice: anObject [

	self choices add: anObject.
	self privateAddItem: (self newItemFromChoice: anObject).
	selectedChoice ifNil: [ self defaultChoice: anObject ]
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

	^ self choices
		  detect: [ :c | 
			  (self toTextConverter value: c) asString
			  = anItem labelText asString ]
		  ifNone: [  ]
]

{ #category : #accessing }
ToChoiceBox >> choices [

	^ choices
]

{ #category : #accessing }
ToChoiceBox >> defaultChoice: anObject [


	| item |
	item := self itemFromChoice: anObject.
	item ifNil: [ ^ self ].
	group default: item.
	selectedChoice := anObject
	
]

{ #category : #accessing }
ToChoiceBox >> defaultChoiceIndex: anInteger [


	self defaultChoice: (self choices at: anInteger)
	
]

{ #category : #'t - initialization dresser' }
ToChoiceBox >> defaultDresser [

	^ ToChoiceBoxDresser new
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	toTextConverter := [ :i | i ].
	choices := OrderedCollection new.
	self layout: BlFrameLayout new.
	self fitContent.
	button := ToChoiceBoxButton new.
	group := ToCheckableGroup new.
	self addChild: button.
	self whenSelectedChoiceChangedDo: [ self selectedChoiceChanged ].
	group whenCheckedDo: [ :item :previous | selectedChoice := self choiceFromItem: item ].
	self initializeDresser.

]

{ #category : #accessing }
ToChoiceBox >> itemFromChoice: anObject [

	^ button items
		  detect: [ :i | 
			  i labelText asString
			  = (self toTextConverter value: anObject) asString ]
		  ifNone: [  ]
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
	self choices remove: anObject.
	i := self itemFromChoice: anObject.
	self privateRemoveItem: i
]

{ #category : #accessing }
ToChoiceBox >> selectedChoice [

	^ selectedChoice
]

{ #category : #accessing }
ToChoiceBox >> selectedChoice: anObject [

	selectedChoice := anObject
]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedChoiceChanged [

	selectedChoice ifNil: [ 
		button labelText: nil.
		^ self ].
	button labelText: (self toTextConverter value: selectedChoice) copy
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
ToChoiceBox >> whenSelectedChoiceChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedChoice whenChangedDo: aBlock
]
