Class {
	#name : #ToButtonAbstractStateDresser,
	#superclass : #ToElementCompanion,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - state transitions' }
ToButtonAbstractStateDresser >> clicked: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAbstractStateDresser >> escaped: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAbstractStateDresser >> hover: anElement [

	self subclassResponsibility 

]

{ #category : #'api - hooks' }
ToButtonAbstractStateDresser >> initialState: anElement [

	self subclassResponsibility 

]

{ #category : #'api - state transitions' }
ToButtonAbstractStateDresser >> leaved: anElement [

	self subclassResponsibility 

]

{ #category : #'api - hooks' }
ToButtonAbstractStateDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement.

	"Initialization of the state engine - this is subclasse reponsibility to implement state transtion methods"
	anElement
		when: BlMouseEnterEvent
		do: [ :anEvent | self hover: anElement ].

	anElement
		when: BlMouseLeaveEvent
		do: [ :anEvent | self leaved: anElement ].

	anElement
		when: BlMouseDownEvent
		do: [ :anEvent | self pressed: anElement ].

	anElement
		when: BlClickEvent
		do: [ :anEvent | self clicked: anElement ].

	anElement
		when: BlMouseUpSomewhereEvent
		do: [ :anEvent | self escaped: anElement ]
]

{ #category : #'api - state transitions' }
ToButtonAbstractStateDresser >> pressed: anElement [

	self subclassResponsibility 

]
