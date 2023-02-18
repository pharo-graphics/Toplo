Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#group',
		'#placeHolder => ObservableSlot',
		'#menuButton',
		'#data',
		'#selectedData => ObservableSlot',
		'#dataToTextConverter'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'adding / removing' }
ToChoiceBox >> addAllData: aCollection [

	aCollection do: [ :t | self addData: t ]

]

{ #category : #'adding / removing' }
ToChoiceBox >> addData: anObject [

	| item |
	self data add: anObject.
	item := self newMenuItemFromData: anObject.
	menuButton addItem: item.
	group add: item.
	selectedData ifNil: [ self defaultData: anObject ]
]

{ #category : #'adding / removing' }
ToChoiceBox >> addSeparator [

	menuButton addSeparator
]

{ #category : #initialization }
ToChoiceBox >> beJustified [

	menuButton hMatchParent.
	menuButton beJustified
]

{ #category : #'api - change hook' }
ToChoiceBox >> checked: anItem [

	anItem ifNil: [ selectedData := nil. ^ self ].
	selectedData := self data
		  detect: [ :c | (self dataToTextConverter value: c) asString = anItem label text asString ]
		  ifNone: [ ^ self ]
]

{ #category : #accessing }
ToChoiceBox >> data [

	^ data 
]

{ #category : #accessing }
ToChoiceBox >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : #accessing }
ToChoiceBox >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : #accessing }
ToChoiceBox >> defaultData: anObject [

	| item |
	anObject ifNil: [
		selectedData := nil.
		^ self ].
	item := self menuItemFromData: anObject.
	item ifNil: [
		selectedData := nil.
		^ self ].
	group default: item.
	selectedData := anObject
]

{ #category : #'t - initialization dresser' }
ToChoiceBox >> defaultDresser [

	^ ToChoiceBoxDresser new
]

{ #category : #accessing }
ToChoiceBox >> defaultSelectedIndex: anInteger [

	self defaultData:
		((anInteger > 0 and: [ anInteger <= self data size ])
			 ifTrue: [ self data at: anInteger ]
			 ifFalse: [  ])
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	dataToTextConverter := [ :i | i ].
	data := OrderedCollection new.
	self layout: self defaultLayout.
	self fitContent.
	menuButton := ToChoiceBoxMenuButton new.
	group := ToCheckableGroup new.
	self addChild: menuButton.
	self whenSelectedDataChangedDo: [ self selectedDataChanged ].
	self whenPlaceHolderChangedDo: [ self placeHolderChanged ].
	group whenCheckedDo: [ :item :previous | self checked: item ].
	self initializeDresser.

]

{ #category : #accessing }
ToChoiceBox >> menuItemFromData: anObject [

	^ group buttons
		  detect: [ :i | i label text asString = (self dataToTextConverter value: anObject) asString ]
		  ifNone: [  ]
]

{ #category : #'adding / removing' }
ToChoiceBox >> newMenuItemFromData: anObject [

	^ ToChoiceBoxMenuItem new labelText: (self dataToTextConverter value: anObject)
]

{ #category : #accessing }
ToChoiceBox >> placeHolder [

	^ placeHolder
]

{ #category : #accessing }
ToChoiceBox >> placeHolder: anElement [

	placeHolder := anElement
]

{ #category : #'api - change hook' }
ToChoiceBox >> placeHolderChanged [

	selectedData ifNotNil: [ ^ self ].
	self usePlaceHolder 

]

{ #category : #'adding / removing' }
ToChoiceBox >> removeData: anObject [

	| item |
	self data remove: anObject.
	item := self menuItemFromData: anObject.
	menuButton removeItem: item.
	group remove: item.
	selectedData = anObject ifTrue: [ selectedData := nil ]
]

{ #category : #accessing }
ToChoiceBox >> selectedData [

	^ selectedData
]

{ #category : #accessing }
ToChoiceBox >> selectedData: anObject [

	selectedData := anObject
]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedDataChanged [

	| found menuItem |
	selectedData ifNil: [
		self usePlaceHolder.
		^ self ].
	found := self data detect: [ :d | selectedData = d ] ifNone: [].
	found == selectedData ifFalse: [ selectedData := found ].
	menuButton label: (ToLabel text: (self dataToTextConverter value: selectedData) copy).
	menuItem := self menuItemFromData: selectedData.
	menuItem isChecked ifFalse: [ menuItem check ]
]

{ #category : #'api - change hook' }
ToChoiceBox >> usePlaceHolder [

	menuButton label: self placeHolder.
	group uncheckAll
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenPlaceHolderChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #placeHolder whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenSelectedDataChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedData whenChangedDo: aBlock
]
