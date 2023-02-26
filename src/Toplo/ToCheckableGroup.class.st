Class {
	#name : #ToCheckableGroup,
	#superclass : #Object,
	#instVars : [
		'buttons',
		'default',
		'checkAction',
		'checkingStrategy'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'adding / removing' }
ToCheckableGroup >> add: aCheckable [

	aCheckable group ifNotNil: [ ^ self ].
	(buttons includes: aCheckable) ifTrue: [ ^ self ].
	buttons add: aCheckable.
	aCheckable group: self.
	aCheckable whenCheckedDo: [ self checked: aCheckable ].
	aCheckable whenUncheckedDo: [ self unchecked: aCheckable ]

]

{ #category : #'adding / removing' }
ToCheckableGroup >> addAll: aCollection [

	aCollection do: [ :b | self add: b ]

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

	aCheckable privateCheck.
	checkingStrategy checked: aCheckable in: self.
	self notifyChecked

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
	buttons := OrderedCollection new
]

{ #category : #'checking protocol' }
ToCheckableGroup >> notifyChecked [

	checkAction ifNotNil: [ checkAction cull: self checkedButtons cull: self uncheckedButtons ]
]

{ #category : #'adding / removing' }
ToCheckableGroup >> remove: aCheckable [

	(buttons includes: aCheckable) ifFalse: [ ^ self ].
	buttons remove: aCheckable.

]

{ #category : #accessing }
ToCheckableGroup >> startDefault: aCheckable [

	default ifNotNil: [ 
		default uncheck.
		default := nil ].
	aCheckable ifNil: [ ^ self ].
	(buttons select: [ :b | b ~= aCheckable ]) do: [ :b | 
		b privateUncheck ].
	aCheckable startChecked.
	default := aCheckable
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> uncheckAll [
	| current |
	current := buttons detect: [ :b | b isChecked ] ifNone: [].
	buttons do: [ :b | b privateUncheck ].
	self notifyChecked
]

{ #category : #'check-uncheck-request' }
ToCheckableGroup >> unchecked: aCheckable [

	aCheckable privateUncheck.
	checkingStrategy unchecked: aCheckable in: self

]

{ #category : #accessing }
ToCheckableGroup >> uncheckedButtons [

	^ buttons reject: [ :b | b isChecked ]
]

{ #category : #'checking protocol' }
ToCheckableGroup >> whenCheckedDo: aBlock [
	"Run aBlock when one of my buttons is checked. 
	 `aBlock` receives two optional arguments: 
	 - checked button list
	 - unchecked button list"

	checkAction := aBlock
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
