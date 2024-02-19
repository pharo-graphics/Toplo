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
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'adding / removing' }
ToCheckableGroup >> add: aCheckable [

	buttons add: aCheckable

]

{ #category : #'adding / removing' }
ToCheckableGroup >> addAll: aCollection [

	buttons addAll: aCollection

]

{ #category : #testing }
ToCheckableGroup >> allowUnchecking [

	^ self checkingStrategy allowUnchecking
]

{ #category : #accessing }
ToCheckableGroup >> buttons [

	^ buttons
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> checkRequestEvent: aCheckRequest [

	aCheckRequest checked isSymbol ifTrue: [ ^ self ].
	checkingStrategy checkRequestEvent: aCheckRequest in: self.

]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> checkableChangedEvent: aCheckedEvent [

	self notifyChanged

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

{ #category : #testing }
ToCheckableGroup >> forbidUnchecking [

	^ self allowUnchecking not
]

{ #category : #initialization }
ToCheckableGroup >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	checkingStrategy := self defaultCheckStrategy.
	buttons := ToObservableCollection new.
	buttons addEventHandler: (ToCheckableGroupButtonCollectionEventHandler new checkableGroup: self; yourself).

	self notifyChanged
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
