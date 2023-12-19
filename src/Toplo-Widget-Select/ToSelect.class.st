Class {
	#name : 'ToSelect',
	#superclass : 'ToElement',
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'group',
		'menuButton',
		'data',
		'dataToTextConverter',
		'selectedIndex'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'adding / removing' }
ToSelect >> addData: anObject [

	self data add: anObject
]

{ #category : 'adding / removing' }
ToSelect >> addSeparator [

	menuButton addSeparator
]

{ #category : 'initialization' }
ToSelect >> beFlexible [

	menuButton hMatchParent.
	menuButton flexible: true
]

{ #category : 'api - change hook' }
ToSelect >> checked: anItem [

	anItem ifNil: [
		self selectData: nil.
		^ self ].
	self selectData: (self data
			 detect: [ :c |
				 (self dataToTextConverter value: c) asString = anItem label text asString ]
			 ifNone: [ ])
]

{ #category : 'accessing' }
ToSelect >> data [

	^ data 
]

{ #category : 'accessing' }
ToSelect >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : 'accessing' }
ToSelect >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : 'accessing' }
ToSelect >> group [

	^ group
]

{ #category : 'api - change hook' }
ToSelect >> indexOfData: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
]

{ #category : 'initialization' }
ToSelect >> initialize [

	super initialize.
	dataToTextConverter := [ :i | i ].
	selectedIndex := 0.
	self privateData: self newDataCollection.
	self layout: self defaultLayout.
	self fitContent.
	menuButton := ToSelectInnerButton new.
	group := ToCheckableGroup new.
	self addChild: menuButton.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event | " #checked: must be sent before #unchecked: "
				 event checkedButtons do: [ :e | self checked: e ].
				 event uncheckedButtons do: [ :e | self unchecked: e ] ]).
	self showPlaceholder 

]

{ #category : 'accessing' }
ToSelect >> menuButton [

	^ menuButton 
]

{ #category : 'accessing' }
ToSelect >> menuItemFromData: anObject [

	^ group buttons
		  detect: [ :i | i label text asString = (self dataToTextConverter value: anObject) asString ]
		  ifNone: [  ]
]

{ #category : 'initialization' }
ToSelect >> newDataCollection [

	^ ToObservableCollection new
]

{ #category : 'private - accessing' }
ToSelect >> newMenuItemFromData: anObject [

	^ ToSelectItem new
		  labelText: (self dataToTextConverter value: anObject)
		  yourself
]

{ #category : 'private - notifications' }
ToSelect >> notifyChanged [

	self dispatchEvent: ToSelectChangedEvent new
]

{ #category : 'private - notifications' }
ToSelect >> notifyDataChanged: anInterval [

	anInterval ifEmpty: [ ^ self ].
	anInterval do: [ :idx |
		| prevItem newItem |
		prevItem := self menuButton items at: idx.
		newItem := self newMenuItemFromData: (self data at: idx).
		self menuButton replaceItemAt: idx with: newItem.
		self group replace: prevItem with: newItem.
		(self selectedData = self data at: idx) ifTrue: [ self selectData: nil ] ]
]

{ #category : 'private - notifications' }
ToSelect >> notifyDataInserted: anInterval [

	| items |
	anInterval ifEmpty: [ ^ self ].
	items := anInterval collect: [ :idx | self newMenuItemFromData: (self data at: idx) ].
	self menuButton addAllItems: items.
	self group addAll: items
]

{ #category : 'private - notifications' }
ToSelect >> notifyDataRemoved: anInterval [

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

{ #category : 'api - change hook' }
ToSelect >> placeholderChanged [

	self selectedData ifNotNil: [
		self hidePlaceholder.
		^ self ].
	self showPlaceholder
]

{ #category : 'private - accessing' }
ToSelect >> privateData: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann | self notifyDataInserted: ann interval ].
	data whenBeforeRemoveChangeDo: [ :ann | self notifyDataRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | self notifyDataChanged: ann interval ].

	self notifyChanged
]

{ #category : 'private - accessing' }
ToSelect >> privateSelectedIndex: anInteger [

	selectedIndex := anInteger.
	self selectedIndexChanged.
	self showHidePlaceHolder.
	self dispatchEvent: ToSelectSelectedIndexChangeEvent new.

]

{ #category : 'adding / removing' }
ToSelect >> removeData: anObject [

	| item |
	item := self menuItemFromData: anObject.
	self selectedData = anObject ifTrue: [ self selectData: nil ].
	self data remove: anObject
]

{ #category : 'accessing' }
ToSelect >> selectData: aData [
	| idx |
	idx := self indexOfData: aData.
	self selectedIndex = idx ifTrue: [ ^ self ].
	self privateSelectedIndex: idx
]

{ #category : 'accessing' }
ToSelect >> selectIndex: anInteger [

	self selectedIndex = anInteger ifTrue: [ ^ self ].
	anInteger > self data size ifTrue: [ ^ self ].
	self privateSelectedIndex: anInteger
]

{ #category : 'accessing' }
ToSelect >> selectedData [

	^ self selectedIndex isZero
		  ifTrue: [ nil ]
		  ifFalse: [ self data at: self selectedIndex ]
]

{ #category : 'accessing' }
ToSelect >> selectedIndex [

	^ selectedIndex 
]

{ #category : 'api - change hook' }
ToSelect >> selectedIndexChanged [

	| menuItem |
	self selectedData ifNil: [
		self showPlaceholder.
		^ self ].
	menuItem := self menuItemFromData: self selectedData.
	menuItem ifNil: [ ^ self error: 'A menu item should exist for the current selectedData' ].
	menuButton label: (ToLabel text: (self dataToTextConverter value: self selectedData) copy).
	menuItem checked ifFalse: [ menuItem check ]
]

{ #category : 'private - accessing' }
ToSelect >> showHidePlaceHolder [

	self selectedIndex > 0
		ifTrue: [ self hidePlaceholder ]
		ifFalse: [ self showPlaceholder ]
]

{ #category : 'api - change hook' }
ToSelect >> unchecked: anItem [

	self group checkedButtons ifNotEmpty: [ ^ self ].
	self selectData: nil
]

{ #category : 'accessing' }
ToSelect >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : 'accessing' }
ToSelect >> withUncheckingStrategy [

	self group withUncheckingStrategy
]
