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
	(anObject isNil or: [ (item := self menuItemFromData: anObject) isNil ]) ifTrue: [ 
		selectedData := nil.
		^ self ].
	group startDefault: item
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

{ #category : #accessing }
ToChoiceBox >> group [

	^ group
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	self class initializeSlots: self.
	super initialize.
	dataToTextConverter := [ :i | i ].
	self privateData: ToObservableCollection new.
	self layout: self defaultLayout.
	self fitContent.
	menuButton := ToChoiceBoxMenuButton new.
	group := ToCheckableGroup new.
	self addChild: menuButton.
	self whenSelectedDataChangedDo: [ self selectedDataChanged ].
	self whenPlaceHolderChangedDo: [ self placeHolderChanged ].
	group whenCheckedDo: [ :checkedList :uncheckedList | 
		checkedList do: [:e | self checked: e].
		uncheckedList do:[:e | self unchecked: e ]].
	self initializeDresser.

]

{ #category : #accessing }
ToChoiceBox >> menuButton [

	^ menuButton 
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

{ #category : #'api - change hook' }
ToChoiceBox >> newSelectedDataToUseFrom: aNewSelectedData [

	| found |
	aNewSelectedData ifNil: [ ^ nil ].
	found := self data detect: [ :d | aNewSelectedData = d ] ifNone: [].
	found ifNil: [ ^ self selectedData ].
	^ found
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyChanged [

	self dispatchEvent: ToChoiceBoxChangedEvent new
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyDataChanged: anInterval [

	anInterval ifEmpty: [ ^ self ].
	anInterval do: [ :idx |
		| prevItem newItem |
		prevItem := self menuButton items at: idx.
		newItem := self newMenuItemFromData: (self data at: idx).
		self menuButton replaceItemAt: idx with: newItem.
		self group replace: prevItem with: newItem.
		(selectedData = self data at: idx) ifTrue: [ selectedData := nil ] ]
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyDataInserted: anInterval [

	| items |
	anInterval ifEmpty: [ ^ self ].
	items := anInterval collect: [ :idx | self newMenuItemFromData: (self data at: idx) ].
	self menuButton addAllItems: items.
	self group addAll: items.
	selectedData ifNil: [ self defaultData: self data first ]
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyDataRemoved: anInterval [

	| removed |
	anInterval ifEmpty: [ ^ self ].
	removed := anInterval collect: [ :idx | self menuButton items at: idx ].
	removed do: [ :item |
		self menuButton removeItem: item.
		self group remove: item ].
	(self data includes: selectedData) ifFalse: [ selectedData := nil ]
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

{ #category : #'private - accessing' }
ToChoiceBox >> privateData: anObservableCollection [

	data := anObservableCollection.

	data whenAddChangeDo: [ :ann | 
		self notifyDataInserted: ann interval ].
	data whenRemoveChangeDo: [ :ann | 
		self notifyDataRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | 
		self notifyDataChanged: ann interval ].

	self notifyChanged
]

{ #category : #'adding / removing' }
ToChoiceBox >> removeData: anObject [

	| item |
	item := self menuItemFromData: anObject.
	self data remove: anObject.
	menuButton removeItem: item.
	group remove: item.
	selectedData = anObject ifTrue: [ selectedData := nil ]
]

{ #category : #accessing }
ToChoiceBox >> selectedData [

	^ selectedData
]

{ #category : #accessing }
ToChoiceBox >> selectedData: aData [

	| newSelectedData |
	newSelectedData := self newSelectedDataToUseFrom: aData.
	newSelectedData == selectedData ifTrue: [ ^ self ].
	selectedData := newSelectedData
]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedDataChanged [ 

	| menuItem |
	selectedData ifNil: [
		self usePlaceHolder.
		^ self ].
	menuItem := self menuItemFromData: selectedData.
	menuItem ifNil: [ ^ self error: 'A menu item should exist for the current selectedData' ].
	menuButton label: (ToLabel text: (self dataToTextConverter value: selectedData) copy).
	menuItem isChecked ifFalse: [ menuItem check ]
]

{ #category : #'api - change hook' }
ToChoiceBox >> unchecked: anItem [

	self group checkedButtons ifNotEmpty: [ ^ self ].
	selectedData := nil
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

{ #category : #accessing }
ToChoiceBox >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : #accessing }
ToChoiceBox >> withUncheckingStrategy [

	self group withUncheckingStrategy
]
