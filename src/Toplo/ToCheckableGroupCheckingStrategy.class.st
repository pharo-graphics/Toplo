"
aStrategy can be Strong, Soft or None
	- Strict means that there must be always one and only one checked element. 
	- Soft  means that only one checked element is alowed but a group can have no checked element.
	- None means that there is no rule : an element can checked or unchecked whatever the others element state

"
Class {
	#name : #ToCheckableGroupCheckingStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> canSwitchToNextState: aCheckable [

	^ true
]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> checked: aCheckable in: aGroup [

	(aGroup buttons select: [ :b | b ~= aCheckable ]) do: [ :b | b privateUncheck ].

]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> unchecked: aCheckable in: aGroup [

	aGroup notifyChecked
]
