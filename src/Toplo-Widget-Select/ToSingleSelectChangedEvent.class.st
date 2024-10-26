Class {
	#name : #ToSingleSelectChangedEvent,
	#superclass : #ToSelectChangedEvent,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #testing }
ToSingleSelectChangedEvent class >> isDeprecated [
	" use ToSelectChangedEvent instead "

	^ true
]
