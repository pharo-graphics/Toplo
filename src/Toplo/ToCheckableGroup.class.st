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
	#category : #'Toplo-Widget-Button'
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

{ #category : #testing }
ToCheckableGroup >> canSwitchToNextState: aCheckable [

	^ checkingStrategy canSwitchToNextState: aCheckable
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> checked: aCheckable [

	checkingStrategy checked: aCheckable in: self.

]

{ #category : #accessing }
ToCheckableGroup >> checkedButtons [


	^ buttons select: [ :b | b isChecked ]
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

	self fireEvent: (ToCheckableGroupChangedEvent new
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

	self checkedButtons ifNotEmpty: [ :found |
		found do: [ :b | b privateUncheck ] ]
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> uncheckAllExcept: aButton [

	self uncheckAllExcept: aButton ifFoundDo: [ ]
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> uncheckAllExcept: aButton ifFoundDo: aBlock [

	(self buttons select: [ :b | b ~= aButton and: [ b isChecked ] ])
		ifNotEmpty: [ :uncheckedBtns |
			uncheckedBtns do: [ :b | b privateUncheck ].
			aBlock value ]
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> unchecked: aCheckable [

	checkingStrategy unchecked: aCheckable in: self

]

{ #category : #accessing }
ToCheckableGroup >> uncheckedButtons [

	^ buttons reject: [ :b | b isChecked ]
]

{ #category : #'checking protocol' }
ToCheckableGroup >> whenChangedDo: aBlock [
	"Run aBlock when one of my buttons is checked. 
	 `aBlock` receives a ToCheckableGroupChanged announcement asArgument"

	self when: ToCheckableGroupChangedEvent do: aBlock
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
