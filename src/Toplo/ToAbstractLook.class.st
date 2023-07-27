Class {
	#name : #ToAbstractLook,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private event handling' }
ToAbstractLook >> elementLookEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractLook >> installLookEvent: anEvent [


]

{ #category : #testing }
ToAbstractLook >> isNull [

	^ false
]

{ #category : #removing }
ToAbstractLook >> removeLook: aLook previous: previousLook [

	self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractLook >> uninstallLookEvent: anEvent [


]
