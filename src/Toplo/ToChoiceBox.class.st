Class {
	#name : #ToChoiceBox,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
	#instVars : [
		'#group',
		'#placeholder => ObservableSlot',
		'#menuButton',
		'#data',
		'#dataToTextConverter',
		'#selectedIndex => ObservableSlot'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'adding / removing' }
ToChoiceBox >> addData: anObject [

	self data add: anObject
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

	anItem ifNil: [
		self selectData: nil.
		^ self ].
	self selectData: (self data
			 detect: [ :c |
				 (self dataToTextConverter value: c) asString
				 = anItem label text asString ]
			 ifNone: [ ])
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

{ #category : #'t - initialization dresser' }
ToChoiceBox >> defaultDresser [

	^ ToChoiceBoxDresser new
]

{ #category : #accessing }
ToChoiceBox >> group [

	^ group
]

{ #category : #'api - change hook' }
ToChoiceBox >> indexOfData: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
]

{ #category : #initialization }
ToChoiceBox >> initialize [

	super initialize.
	dataToTextConverter := [ :i | i ].
	selectedIndex := 0.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self fitContent.
	menuButton := ToChoiceBoxMenuButton new.
	group := ToCheckableGroup new.
	self addChild: menuButton.
	self whenSelectedIndexChangedDo: [ self selectedIndexChanged ].
	self whenPlaceholderChangedDo: [ self placeholderChanged ].
	group when: ToCheckableGroupChangedEvent do: [ :event |
		event checkedButtons do: [:e | self checked: e].
		event uncheckedButtons do:[:e | self unchecked: e ]].
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

{ #category : #initialization }
ToChoiceBox >> newDataCollection [

	^ ToObservableCollection new
]

{ #category : #'private - accessing' }
ToChoiceBox >> newMenuItemFromData: anObject [

	^ ToChoiceBoxMenuItem new labelText: (self dataToTextConverter value: anObject)
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
		(self selectedData = self data at: idx) ifTrue: [ self selectData: nil ] ]
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyDataInserted: anInterval [

	| items |
	anInterval ifEmpty: [ ^ self ].
	items := anInterval collect: [ :idx | self newMenuItemFromData: (self data at: idx) ].
	self menuButton addAllItems: items.
	self group addAll: items
]

{ #category : #'private - notifications' }
ToChoiceBox >> notifyDataRemoved: anInterval [

	| removedData |
	anInterval ifEmpty: [ ^ self ].
	removedData := anInterval collect: [ :idx | self data at: idx ].
	removedData do: [ :d |
		| item |
		item := self menuItemFromData: d.
		self menuButton removeItem: item.
		self group remove: item.
		self selectedData = d ifTrue: [ self selectData: nil ] ]
]

{ #category : #accessing }
ToChoiceBox >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToChoiceBox >> placeholder: anElement [

	placeholder := anElement
]

{ #category : #'api - change hook' }
ToChoiceBox >> placeholderChanged [

	self selectedData ifNotNil: [ ^ self ].
	self usePlaceholder
]

{ #category : #'private - accessing' }
ToChoiceBox >> privateData: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann | self notifyDataInserted: ann interval ].
	data whenBeforeRemoveChangeDo: [ :ann | self notifyDataRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | self notifyDataChanged: ann interval ].

	self notifyChanged
]

{ #category : #'private - accessing' }
ToChoiceBox >> privateSelectedIndex: anInteger [

	selectedIndex := anInteger.
	self dispatchEvent: ToChoiceBoxSelectedIndexChangeEvent new	

]

{ #category : #'adding / removing' }
ToChoiceBox >> removeData: anObject [

	| item |
	item := self menuItemFromData: anObject.
	self selectedData = anObject ifTrue: [ self selectData: nil ].
	self data remove: anObject
]

{ #category : #accessing }
ToChoiceBox >> selectData: aData [

	| idx |
	idx := self indexOfData: aData.
	self selectedIndex = idx ifTrue: [ ^ self ].
	self privateSelectedIndex: idx
]

{ #category : #accessing }
ToChoiceBox >> selectIndex: anInteger [

	self selectedIndex = anInteger ifTrue: [ ^ self ].
	anInteger > self data size ifTrue: [ ^ self ].
	self privateSelectedIndex: anInteger
]

{ #category : #accessing }
ToChoiceBox >> selectedData [

	^ self selectedIndex isZero
		  ifTrue: [ nil ]
		  ifFalse: [ self data at: self selectedIndex ]
]

{ #category : #accessing }
ToChoiceBox >> selectedIndex [

	^ selectedIndex 
]

{ #category : #'api - change hook' }
ToChoiceBox >> selectedIndexChanged [

	| menuItem |
	self selectedData ifNil: [
		self usePlaceholder.
		^ self ].
	menuItem := self menuItemFromData: self selectedData.
	menuItem ifNil: [ ^ self error: 'A menu item should exist for the current selectedData' ].
	menuButton label: (ToLabel text: (self dataToTextConverter value: self selectedData) copy).
	menuItem checked ifFalse: [ menuItem check ]
]

{ #category : #'api - change hook' }
ToChoiceBox >> unchecked: anItem [

	self group checkedButtons ifNotEmpty: [ ^ self ].
	self selectData: nil
]

{ #category : #'api - change hook' }
ToChoiceBox >> usePlaceholder [

	menuButton label: self placeholder.
	group uncheckAll
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenPlaceholderChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #placeholder whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToChoiceBox >> whenSelectedIndexChangedDo: aBlock [

	"set a block to perform after that the selected item has been changed, and its action performed"

	self property: #selectedIndex whenChangedDo: aBlock
]

{ #category : #accessing }
ToChoiceBox >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : #accessing }
ToChoiceBox >> withUncheckingStrategy [

	self group withUncheckingStrategy
]
