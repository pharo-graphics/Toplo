Class {
	#name : #ToCheckableGroup,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'buttons',
		'checkingStrategy'
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

{ #category : #initialization }
ToCheckableGroup >> initialize [ 

	super initialize.
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

	self announce: (ToCheckableGroupChangedAnnouncement new
			 checkedButtons: self checkedButtons;
			 uncheckedButtons: self uncheckedButtons;
			 yourself)
]

{ #category : #'adding / removing' }
ToCheckableGroup >> remove: aCheckable [

	buttons remove: aCheckable.

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

	self whenAnnouncement: ToCheckableGroupChangedAnnouncement do: aBlock
]

{ #category : #'checking protocol' }
ToCheckableGroup >> whenChangedSend: aSelector to: aReceiver [
	"Send a message to the receiver according to the argument selector (with the announcement as argument) "

	self whenAnnouncement: ToCheckableGroupChangedAnnouncement send: aSelector to: aReceiver
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
