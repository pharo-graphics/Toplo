Class {
	#name : #ToChoiceMenu,
	#superclass : #ToMenu,
	#instVars : [
		'group',
		'data',
		'dataToTextConverter',
		'defaultLabel',
		'defaultSelectedIndex'
	],
	#category : #'Toplo-Widget-Menu-Choice menu'
}

{ #category : #'adding / removing' }
ToChoiceMenu >> addData: anObject [

	self data add: anObject
]

{ #category : #'private - notifications' }
ToChoiceMenu >> checkableGroupChangedEvent: anEvent [

	self updateLabel.
	self notifyChanged
]

{ #category : #'private - accessing' }
ToChoiceMenu >> checkedMenuItem [

	^ group buttons
		  detect: [ :btn | btn isChecked ]
		  ifNone: [  ]
]

{ #category : #accessing }
ToChoiceMenu >> data [

	^ data 
]

{ #category : #accessing }
ToChoiceMenu >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : #accessing }
ToChoiceMenu >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : #accessing }
ToChoiceMenu >> defaultLabel [ 

	^ defaultLabel
]

{ #category : #accessing }
ToChoiceMenu >> defaultLabel: aLabel [

	defaultLabel = aLabel ifTrue: [ ^ self ].
	defaultLabel := aLabel.
	self selectedIndex > 0 ifFalse: [ self label: self defaultLabel ]
]

{ #category : #accessing }
ToChoiceMenu >> defaultLabelText: aText [

	self defaultLabel: (ToLabel text: aText)
]

{ #category : #accessing }
ToChoiceMenu >> defaultSelectedIndex [

	^ defaultSelectedIndex 
]

{ #category : #accessing }
ToChoiceMenu >> defaultSelectedIndex: anInteger [

	defaultSelectedIndex = anInteger ifTrue: [ ^ self ].
	defaultSelectedIndex := anInteger.
	self selectedIndex > 0 ifFalse: [
		self data size >= self defaultSelectedIndex ifTrue: [
			self selectIndex: self defaultSelectedIndex ] ]
]

{ #category : #accessing }
ToChoiceMenu >> group [

	^ group
]

{ #category : #'private - accessing' }
ToChoiceMenu >> indexOfData: aData [

	^ self data indexOf: aData ifAbsent: [ 0 ]
]

{ #category : #initialization }
ToChoiceMenu >> initialize [

	super initialize.
	defaultSelectedIndex := 0.
	dataToTextConverter := [ :i | i ].
	self privateData: self newDataCollection.
	" a group with unchecking strategy by default "
	group := ToCheckableGroup new withUncheckingStrategy.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event | self checkableGroupChangedEvent: event ])
]

{ #category : #'private - accessing' }
ToChoiceMenu >> menuItemFromData: anObject [

	^ group buttons
		  detect: [ :btn | btn data = anObject ]
		  ifNone: [  ]
]

{ #category : #initialization }
ToChoiceMenu >> newDataCollection [

	^ ToObservableCollection new
]

{ #category : #'private - notifications' }
ToChoiceMenu >> newMenuItemFromData: anObject [

	^ ToChoiceItem new
		  labelText: (self dataToTextConverter value: anObject);
		  data: anObject;
		  yourself
]

{ #category : #skin }
ToChoiceMenu >> newRawSkin [

	^ ToChoiceMenuSkin new
	
]

{ #category : #'private - notifications' }
ToChoiceMenu >> notifyChanged [

	self dispatchEvent: ToChoiceChangedEvent new
]

{ #category : #'hooks - children' }
ToChoiceMenu >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	(self defaultSelectedIndex > 0 and: [ self selectedIndex isZero ])
		ifTrue: [
			self data size >= self defaultSelectedIndex ifTrue: [
				self selectIndex: self defaultSelectedIndex ] ]
]

{ #category : #'private - accessing' }
ToChoiceMenu >> privateData: anObservableCollection [

	data := anObservableCollection.
	data addEventHandler: (ToChoiceMenuDataEventHandler new choiceMenu: self; yourself).
	self notifyChanged
]

{ #category : #'adding / removing' }
ToChoiceMenu >> removeData: anObject [

	| item |
	item := self menuItemFromData: anObject.
	self selectedData = anObject ifTrue: [ self selectData: nil ].
	self data remove: anObject
]

{ #category : #accessing }
ToChoiceMenu >> selectData: aData [

	aData
		ifNil: [
			self checkedMenuItem ifNotNil: [ :mitem |
				mitem checked: false.
				self checkedMenuItem ifNotNil: [
					Error signal: 'Can''t uncheck a selected item' ] ] ]
		ifNotNil: [
			(self menuItemFromData: aData)
				ifNil: [ Error signal: 'Not found data' ]
				ifNotNil: [ :mitem | mitem checked: true ] ]
]

{ #category : #accessing }
ToChoiceMenu >> selectIndex: anInteger [

	self selectData: (self data at: anInteger)
]

{ #category : #accessing }
ToChoiceMenu >> selectedData [

	^ self checkedMenuItem ifNotNil: [ :cmi | cmi data ]
]

{ #category : #accessing }
ToChoiceMenu >> selectedIndex [

	^ self selectedData
		  ifNil: [ 0 ]
		  ifNotNil: [ :d | self data indexOf: d ]
]

{ #category : #'private - notifications' }
ToChoiceMenu >> updateLabel [

	self selectedData ifNotNil: [ :d |
		self label: (ToLabel text: (self dataToTextConverter value: d)).
		^ self ].
	self defaultLabel ifNotNil: [ :l |
		self label: self defaultLabel.
		^ self ].
	self label: nil
]

{ #category : #accessing }
ToChoiceMenu >> withStrictCheckingStrategy [

	self group withStrictCheckingStrategy
]

{ #category : #accessing }
ToChoiceMenu >> withUncheckingStrategy [

	self group withUncheckingStrategy
]
