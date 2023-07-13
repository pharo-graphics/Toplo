Class {
	#name : #ToAbstractElementLook,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private event handling' }
ToAbstractElementLook >> elementLookEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> installLookEvent: anEvent [


]

{ #category : #testing }
ToAbstractElementLook >> isNull [

	^ false
]

{ #category : #removing }
ToAbstractElementLook >> removeLook: aLook previous: previousLook [

	self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> uninstallLookEvent: anEvent [


]
