Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidget >> defaultBackground [
	^ Color transparent
]

{ #category : #initialization }
ToWidget >> initialize [

	super initialize.
	self background: self defaultBackground
]

{ #category : #'model - events' }
ToWidget >> whenActionRequired: anActionRequiredAnnouncement [

	anActionRequiredAnnouncement value: self
]
