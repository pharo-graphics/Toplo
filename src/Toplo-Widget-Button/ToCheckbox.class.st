Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #initialization }
ToCheckbox >> defaultEventHandler [ 

	^ ToCheckableEventHandler new 
]
