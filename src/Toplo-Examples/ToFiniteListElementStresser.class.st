Class {
	#name : #ToFiniteListElementStresser,
	#superclass : #Object,
	#instVars : [
		'list',
		'size',
		'process',
		'round',
		'counter',
		'rand',
		'runned'
	],
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToFiniteListElementStresser class >> run [

	<script>

	self new run

]

{ #category : #initialization }
ToFiniteListElementStresser >> initialize [

	super initialize.
	rand := Random new.
	list := self newListElement.
	size := self listSize.
	list dataAccessor addAll: (1 to: size).
	list matchParent.
	counter := 0.
	runned := OrderedCollection new
]

{ #category : #accessing }
ToFiniteListElementStresser >> listSize [ 

	^ 50
]

{ #category : #accessing }
ToFiniteListElementStresser >> maxRound [

	^ 2000
]

{ #category : #accessing }
ToFiniteListElementStresser >> newListElement [ 

	^ ToListElement finite
]

{ #category : #accessing }
ToFiniteListElementStresser >> nextCounter [

	^ counter := counter + 1
]

{ #category : #running }
ToFiniteListElementStresser >> processBlock [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToFiniteListElementStresser >> randIndex [

	| s |
	s := list dataAccessor size.
	^ s isZero
		  ifTrue: [ 0 ]
		  ifFalse: [ ((rand nextIntegerBetween: 1 and: s) max: 1) min: s]
]

{ #category : #running }
ToFiniteListElementStresser >> run [

	| space |
	space := BlSpace new.
	process := self processBlock newProcess.
	process name: self class name.
	process priority: Processor userBackgroundPriority .
	list addEventHandlerOn: ToAddedToSpaceEvent do: [ :event |
			self inspect.
			process resume ].
	list
		addEventHandlerOn: ToRemovedFromSpaceEvent
		do: [ :event | process terminate ].

	space root addChild: list.
	space show
]

{ #category : #actions }
ToFiniteListElementStresser >> storeRunnedAction: aString [

	"runned add: aString"
]
