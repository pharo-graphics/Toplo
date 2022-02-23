Class {
	#name : #ToBasicWidget,
	#superclass : #ToWidget,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToBasicWidget >> initialize [
	self class initializeSlots: self.
	super initialize.

]

{ #category : #accessing }
ToBasicWidget >> model [

	^ self 
	
]
