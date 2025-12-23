Class {
	#name : #ToCheckableGroupPane,
	#superclass : #ToPane,
	#traits : 'TToCheckableGroupUser',
	#classTraits : 'TToCheckableGroupUser classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #configuration }
ToCheckableGroupPane >> applyConfiguration [

	super applyConfiguration.
	self isHorizontal
		ifTrue: [
		self children accountedByLayout do: [ :e | e hFitContent ] ]
		ifFalse: [
		self children accountedByLayout do: [ :e | e hMatchParent ] ]
]

{ #category : #initialization }
ToCheckableGroupPane >> initialize [

	super initialize.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

]

{ #category : #accessing }
ToCheckableGroupPane >> items [

	^ self registeredCheckables 
]

{ #category : #'hooks - children' }
ToCheckableGroupPane >> onChildAdded: anElement [

	super onChildAdded: anElement.
	self register: anElement.
	self requestConfiguration 
]

{ #category : #'hooks - children' }
ToCheckableGroupPane >> onChildRemoved: anElement [

	self unregister: anElement.
	super onChildRemoved: anElement

]
