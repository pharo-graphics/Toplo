Class {
	#name : 'ToChoiceMenu',
	#superclass : 'ToMenu',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'group',
		'data',
		'dataToTextConverter',
		'selectedIndex',
		'defaultLabel'
	],
	#category : 'Toplo-Widget-Menu-Choice menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Choice menu'
}

{ #category : 'adding / removing' }
ToChoiceMenu >> addData: anObject [

	self data add: anObject
]

{ #category : 'api - change hook' }
ToChoiceMenu >> checked: anItem [

	anItem ifNil: [
		self selectData: nil.
		^ self ].
	self selectData: (self data
			 detect: [ :c |
				 (self dataToTextConverter value: c) asString = anItem label text asString ]
			 ifNone: [ ])
]

{ #category : 'accessing' }
ToChoiceMenu >> data [

	^ data 
]

{ #category : 'accessing' }
ToChoiceMenu >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : 'accessing' }
ToChoiceMenu >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : 'accessing' }
ToChoiceMenu >> defaultLabel [ 

	^ defaultLabel
]

{ #category : 'accessing' }
ToChoiceMenu >> defaultLabel: aLabel [

	defaultLabel = aLabel ifTrue: [ ^ self ].
	defaultLabel := aLabel.
	self selectedIndex > 0 ifFalse: [ self label: self defaultLabel ]
]

{ #category : 'accessing' }
ToChoiceMenu >> defaultLabelText: aText [

	self defaultLabel: (ToLabel text: aText)
]

{ #category : 'accessing' }
ToChoiceMenu >> group [

	^ group
]

{ #category : 'api - change hook' }
ToChoiceMenu >> indexOfData: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
]

{ #category : 'initialization' }
ToChoiceMenu >> initialize [

	super initialize.
	dataToTextConverter := [ :i | i ].
	selectedIndex := 0.
	self privateData: self newDataCollection.
	group := ToCheckableGroup new.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event | " #checked: must be sent before #unchecked: "
				 event checkedButtons do: [ :e | self checked: e ].
				 event uncheckedButtons do: [ :e | self unchecked: e ] ])
]

{ #category : 'skin' }
ToChoiceMenu >> installRawStyle [ 

	super installRawStyle.
	self beLabelFirst.
	self flexible: true.
	self interspace: 10.
	self icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom))
]

{ #category : 'accessing' }
ToChoiceMenu >> menuItemFromData: anObject [

	^ group buttons
		  detect: [ :i | i label text asString = (self dataToTextConverter value: anObject) asString ]
		  ifNone: [  ]
]

{ #category : 'initialization' }
ToChoiceMenu >> newDataCollection [

	^ ToObservableCollection new
]

{ #category : 'private - accessing' }
ToChoiceMenu >> newMenuItemFromData: anObject [

	^ ToChoiceItem new
		  labelText: (self dataToTextConverter value: anObject)
		  yourself
]

{ #category : 'private - notifications' }
ToChoiceMenu >> notifyChanged [

	self dispatchEvent: ToChoiceChangedEvent new
]

{ #category : 'private - notifications' }
ToChoiceMenu >> notifyDataChanged: anInterval [

	anInterval ifEmpty: [ ^ self ].
	anInterval do: [ :idx |
		| prevItem newItem |
		prevItem := self items at: idx.
		newItem := self newMenuItemFromData: (self data at: idx).
		self flag: 'ToDo'.
		self replaceItemAt: idx with: newItem.
		self group replace: prevItem with: newItem.
		(self selectedData = self data at: idx) ifTrue: [ self selectData: nil ] ]
]

{ #category : 'private - notifications' }
ToChoiceMenu >> notifyDataInserted: anInterval [

	| found |
	anInterval ifEmpty: [ ^ self ].
	found := anInterval collect: [ :idx | self newMenuItemFromData: (self data at: idx) ].
	self addAllItems: found.
	self group addAll: found
]

{ #category : 'private - notifications' }
ToChoiceMenu >> notifyDataRemoved: anInterval [

	| removedData |
	anInterval ifEmpty: [ ^ self ].
	removedData := anInterval collect: [ :idx | self data at: idx ].
	removedData do: [ :d |
		| item |
		item := self menuItemFromData: d.
		self removeItem: item.
		self group remove: item.
		self selectedData = d ifTrue: [ self selectData: nil ] ]
]

{ #category : 'api - change hook' }
ToChoiceMenu >> placeholderChanged [

	self selectedData ifNotNil: [
		self hidePlaceholder.
		^ self ].
	self showPlaceholder
]

{ #category : 'private - accessing' }
ToChoiceMenu >> privateData: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann | self notifyDataInserted: ann interval ].
	data whenBeforeRemoveChangeDo: [ :ann | self notifyDataRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | self notifyDataChanged: ann interval ].

	self notifyChanged
]

{ #category : 'private - accessing' }
ToChoiceMenu >> privateSelectedIndex: anInteger [

	selectedIndex := anInteger.
	self selectedIndexChanged.
	self dispatchEvent: ToChoiceSelectedIndexChangeEvent new.

]

{ #category : 'adding / removing' }
ToChoiceMenu >> removeData: anObject [

	| item |
	item := self menuItemFromData: anObject.
	self selectedData = anObject ifTrue: [ self selectData: nil ].
	self data remove: anObject
]

{ #category : 'accessing' }
ToChoiceMenu >> selectData: aData [
	| idx |
	idx := self indexOfData: aData.
	self selectedIndex = idx ifTrue: [ ^ self ].
	self privateSelectedIndex: idx
]

{ #category : 'accessing' }
ToChoiceMenu >> selectIndex: anInteger [

	self selectedIndex = anInteger ifTrue: [ ^ self ].
	anInteger > self data size ifTrue: [ ^ self ].
	self privateSelectedIndex: anInteger
]

{ #category : 'accessing' }
ToChoiceMenu >> selectedData [

	^ self selectedIndex isZero
		  ifTrue: [ nil ]
		  ifFalse: [ self data at: self selectedIndex ]
]

{ #category : 'accessing' }
ToChoiceMenu >> selectedIndex [

	^ selectedIndex 
]

{ #category : 'api - change hook' }
ToChoiceMenu >> selectedIndexChanged [

	| menuItem |
	self selectedData ifNil: [
		self label: self defaultLabel.
		^ self ].
	menuItem := self menuItemFromData: self selectedData.
	menuItem ifNil: [ ^ self error: 'A menu item should exist for the current selectedData' ].
	self label: (ToLabel text: (self dataToTextConverter value: self selectedData) copy).
	menuItem checked ifFalse: [ menuItem check ]
]

{ #category : 'api - change hook' }
ToChoiceMenu >> unchecked: anItem [

	self group checkedButtons ifNotEmpty: [ ^ self ].
	self selectData: nil
]

{ #category : 'accessing' }
ToChoiceMenu >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : 'accessing' }
ToChoiceMenu >> withUncheckingStrategy [

	self group withUncheckingStrategy
]
