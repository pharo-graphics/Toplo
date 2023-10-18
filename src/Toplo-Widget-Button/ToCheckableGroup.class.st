Class {
	#name : #ToCheckableGroup,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'buttons',
		'checkingStrategy',
		'eventDispatcher'
	],
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #'adding / removing' }
ToCheckableGroup >> add: aCheckable [

	buttons add: aCheckable

]

{ #category : #'adding / removing' }
ToCheckableGroup >> addAll: aCollection [

	buttons addAll: aCollection

]

{ #category : #accessing }
ToCheckableGroup >> buttons [

	^ buttons
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> checkRequestEvent: aCheckRequest [

	aCheckRequest checked ifNil: [ ^ self ].
	checkingStrategy checkRequestEvent: aCheckRequest in: self.

]

{ #category : #accessing }
ToCheckableGroup >> checkedButtons [


	^ buttons select: [ :b | b checked ]
]

{ #category : #accessing }
ToCheckableGroup >> checkingStrategy [

	^ checkingStrategy
]

{ #category : #accessing }
ToCheckableGroup >> checkingStrategy: aCheckableGroupCheckingStrategy [

	checkingStrategy := aCheckableGroupCheckingStrategy
]

{ #category : #initialization }
ToCheckableGroup >> defaultCheckStrategy [

	^ ToCheckableGroupStrictStrategy new
]

{ #category : #'event management accessing' }
ToCheckableGroup >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToCheckableGroup >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	checkingStrategy := self defaultCheckStrategy.
	buttons := ToObservableCollection new.
	buttons whenBeforeAddChangeDo: [ :ann | self notifyBeforeButtonsInserted: ann ].
	buttons whenBeforeRemoveChangeDo: [ :ann | self notifyBeforeButtonsRemoved: ann ].
	buttons whenBeforeUpdateChangeDo: [ :ann | self notifyBeforeButtonsChanged: ann ].
	buttons whenAddChangeDo: [ :ann | self notifyButtonsInserted: ann ].
	buttons whenRemoveChangeDo: [ :ann | self notifyButtonsRemoved: ann ].

	self notifyChanged
]

{ #category : #notifications }
ToCheckableGroup >> notifyBeforeButtonsChanged: aCollectionChangeAnnouncement [

	self error: 'Changing a button in a CheckableGroup is not allowed'
]

{ #category : #notifications }
ToCheckableGroup >> notifyBeforeButtonsInserted: aCollectionChangeAnnouncement [

	self checkingStrategy notifyBeforeButtonsInserted: aCollectionChangeAnnouncement in: self
]

{ #category : #notifications }
ToCheckableGroup >> notifyBeforeButtonsRemoved: aCollectionChangeAnnouncement [

	self checkingStrategy notifyBeforeButtonsRemoved: aCollectionChangeAnnouncement in: self
]

{ #category : #notifications }
ToCheckableGroup >> notifyButtonsInserted: aCollectionChangeAnnouncement [

	self checkingStrategy notifyButtonsInserted: aCollectionChangeAnnouncement in: self
]

{ #category : #notifications }
ToCheckableGroup >> notifyButtonsRemoved: aCollectionChangeAnnouncement [

	self checkingStrategy notifyButtonsRemoved: aCollectionChangeAnnouncement in: self
]

{ #category : #'checking protocol' }
ToCheckableGroup >> notifyChanged [

	self dispatchEvent: (ToCheckableGroupChangedEvent new
			 checkedButtons: self checkedButtons;
			 uncheckedButtons: self uncheckedButtons;
			 yourself)
]

{ #category : #'adding / removing' }
ToCheckableGroup >> remove: aCheckable [

	buttons remove: aCheckable.

]

{ #category : #'adding / removing' }
ToCheckableGroup >> removeAll [

	buttons removeAll

]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> uncheckAll [

	self checkedButtons do: [ :b | b privateChecked: false ]
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> uncheckAllExcept: aButton [

	(self buttons select: [ :b | b ~= aButton and: [ b checked ] ]) do: [
		:b | b privateChecked: false ]
]

{ #category : #accessing }
ToCheckableGroup >> uncheckedButtons [

	^ buttons reject: [ :b | b checked ]
]

{ #category : #accessing }
ToCheckableGroup >> withStrictCheckingStrategy [

	self checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #accessing }
ToCheckableGroup >> withUncheckingStrategy [

	self checkingStrategy: ToCheckableGroupWithUncheckStrategy new
]

{ #category : #accessing }
ToCheckableGroup >> withoutCheckingStrategy [

	self checkingStrategy: ToCheckableGroupNoneStrategy new
]
